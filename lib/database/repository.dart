import 'package:bookish/models/your_article.dart';

abstract class Repository {

  Future init();

  Future<List<YourArticle>> findAllArticles();

  Future<YourArticle> findArticleById(int id);

  Stream<List<YourArticle>> watchAllArticles();

  Future<int> insertArticle(YourArticle article);

  Future<int> updateArticle(YourArticle yourArticle);

  Future<int> deleteArticle(int id);

  void close();
}
