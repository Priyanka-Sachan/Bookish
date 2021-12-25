import 'package:bookish/models/your_article.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:synchronized/synchronized.dart';

class DatabaseHelper {
  static const _databaseName = 'Bookish.db';
  static const _databaseVersion = 1;

  static const articleTable = 'Article';
  static const articleId = 'id';

  static late BriteDatabase _streamDatabase;

// make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static var lock = Lock();

// only have a single app-wide reference to the database
  static Database? _database;

// SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE $articleTable (
                       $articleId INTEGER PRIMARY KEY,
                       type TEXT,
                       title TEXT,
                       subtitle TEXT,
                       backgroundImage TEXT,
                       authorName TEXT,
                       authorImage TEXT,
                       message TEXT,
                       tags TEXT,
                       body TEXT,
                       timeStamp TEXT,
                       isUploaded INTEGER
                       )''');
  }

// this opens the database (and creates it if it doesn't exist)
  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    // TODO: Remember to turn off debugging before deploying app to store(s).
    Sqflite.setDebugModeOn(true);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Use this object to prevent concurrent access to data
    await lock.synchronized(() async {
      // lazily instantiate the db the first time it is accessed
      if (_database == null) {
        _database = await _initDatabase();
        _streamDatabase = BriteDatabase(_database!);
      }
    });
    return _database!;
  }

  Future<BriteDatabase> get streamDatabase async {
    await database;
    return _streamDatabase;
  }

  // All functions for articles.
  List<YourArticle> parseArticles(List<Map<String, dynamic>> articleList) {
    final yourArticles = <YourArticle>[];
    articleList.forEach((articleMap) {
      final article = YourArticle.fromJson(articleMap);
      yourArticles.add(article);
    });
    return yourArticles;
  }

  Future<List<YourArticle>> findAllArticles() async {
    final db = await instance.streamDatabase;
    final articleList = await db.query(articleTable);
    final articles = parseArticles(articleList);
    return articles;
  }

  Future<YourArticle> findArticleById(int id) async {
    final db = await instance.streamDatabase;
    final articleList = await db.query(articleTable);
    final article = parseArticles(articleList)
        .firstWhere((e) => e.article.id == id.toString());
    return article;
  }

  Stream<List<YourArticle>> watchAllArticles() async* {
    final db = await instance.streamDatabase;
    yield* db
        .createQuery(articleTable)
        .mapToList((row) => YourArticle.fromJson(row));
  }

  Future<int> _insert(String table, Map<String, dynamic> row) async {
    final db = await instance.streamDatabase;
    return db.insert(table, row);
  }

  Future<int> insertArticle(YourArticle yourArticle) {
    return _insert(articleTable, yourArticle.toJson());
  }

  Future<int> _update(
      String table, Map<String, dynamic> row, String columnId, int id) async {
    final db = await instance.streamDatabase;
    return db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateArticle(YourArticle yourArticle) async {
    return _update(articleTable, yourArticle.toJson(), articleId,
        int.parse(yourArticle.article.id));
  }

  Future<int> _delete(String table, String columnId, int id) async {
    final db = await instance.streamDatabase;
    return db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteArticle(int id) async {
    return _delete(articleTable, articleId, id);
  }

  void close() {
    _streamDatabase.close();
  }
}
