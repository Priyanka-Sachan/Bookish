import 'package:bookish/models/article.dart';
import 'package:bookish/models/bookish_pages.dart';
import 'package:bookish/models/user.dart';
import 'package:bookish/models/your_article.dart';
import 'package:bookish/providers/profile_provider.dart';
import 'package:bookish/providers/your_articles_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:textfield_tags/textfield_tags.dart';

class AddArticleScreen extends StatefulWidget {
  final Function(YourArticle) onCreate;
  final Function(YourArticle) onUpdate;
  final YourArticle? originalItem;
  bool isUpdating;

  static MaterialPage page({
    required YourArticle? originalItem,
    required Function(YourArticle) onCreate,
    required Function(YourArticle) onUpdate,
  }) {
    return MaterialPage(
      name: BookishPages.addArticlePath,
      key: ValueKey(BookishPages.addArticlePath),
      child: AddArticleScreen(
        originalItem: originalItem,
        onCreate: onCreate,
        onUpdate: onUpdate,
      ),
    );
  }

  AddArticleScreen({
    Key? key,
    this.originalItem,
    required this.onCreate,
    required this.onUpdate,
  })  : isUpdating = (originalItem != null),
        super(key: key);

  @override
  State<AddArticleScreen> createState() => _AddArticleScreenState();
}

class _AddArticleScreenState extends State<AddArticleScreen> {
  final _imageController = TextEditingController();
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  final _messageController = TextEditingController();
  final _bodyController = TextEditingController();
  String _id = '-1';
  String _type = "";
  String _title = "";
  String _subtitle = "";
  String _backgroundImage = "";
  String _message = "";
  String _authorName = "Anonymous";
  String _authorImage =
      "https://images.unsplash.com/photo-1531988042231-d39a9cc12a9a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fGJvb2tzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60";
  List<String> _tags = [];
  String _body = "";
  DateTime _timeStamp = DateTime.now();
  bool _isUploaded = false;

  @override
  void initState() {
    YourArticle? originalItem = widget.originalItem;
    if (originalItem != null) {
      _id = originalItem.article.id;
      print('id...$_id');
      _type = originalItem.article.type;
      _title = originalItem.article.title;
      _subtitle = originalItem.article.subtitle;
      _backgroundImage = originalItem.article.backgroundImage;
      _message = originalItem.article.message;
      _authorName = originalItem.article.authorName;
      _authorImage = originalItem.article.authorImage;
      _body = originalItem.article.body;
      _tags = originalItem.article.tags;
      _timeStamp = originalItem.article.timeStamp;
      _isUploaded = originalItem.isUploaded;

      _imageController.text = _backgroundImage;
      _titleController.text = _title;
      _subtitleController.text = _subtitle;
      _messageController.text = _message;
      _bodyController.text = _body;
    } else {
      User user = Provider.of<ProfileProvider>(context, listen: false).user;
      _authorName = user.username;
      _authorImage = user.profileImageUrl;
    }
    _imageController.addListener(() {
      setState(() {
        _backgroundImage = _imageController.text;
      });
    });
    _titleController.addListener(() {
      setState(() {
        _title = _titleController.text;
      });
    });

    _subtitleController.addListener(() {
      setState(() {
        _subtitle = _subtitleController.text;
      });
    });

    _messageController.addListener(() {
      setState(() {
        _message = _messageController.text;
      });
    });

    _bodyController.addListener(() {
      setState(() {
        _body = _bodyController.text;
      });
    });
    super.initState();
  }

  YourArticle getArticle() {
    Article article = Article(
        id: _id,
        type: _type,
        title: _title,
        subtitle: _subtitle,
        backgroundImage: _backgroundImage,
        message: _message,
        authorName: _authorName,
        authorImage: _authorImage,
        tags: _tags,
        body: _body,
        timeStamp: DateTime.now());
    YourArticle yourArticle =
        YourArticle(article: article, isUploaded: _isUploaded);
    return yourArticle;
  }

  saveArticle() {
    YourArticle yourArticle = getArticle();
    if (widget.isUpdating)
      widget.onUpdate(yourArticle);
    else
      widget.onCreate(yourArticle);
    Provider.of<YourArticlesProvider>(context, listen: false).tapItem(null);
  }

  @override
  void dispose() {
    _imageController.dispose();
    _titleController.dispose();
    _subtitleController.dispose();
    _messageController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: saveArticle,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Wrap(
              children: [
                ChoiceChip(
                  label: Text('Editorial'),
                  selected: _type == "editorial",
                  backgroundColor: Colors.transparent,
                  shape: StadiumBorder(side: BorderSide()),
                  selectedColor: Theme.of(context).colorScheme.primary,
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                  onSelected: (bool newValue) {
                    setState(() {
                      _type = "editorial";
                    });
                  },
                ),
                SizedBox(
                  width: 4,
                ),
                ChoiceChip(
                  label: Text('Review'),
                  selected: _type == "review",
                  backgroundColor: Colors.transparent,
                  shape: StadiumBorder(side: BorderSide()),
                  selectedColor: Theme.of(context).colorScheme.primary,
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                  onSelected: (bool newValue) {
                    setState(() {
                      _type = "review";
                    });
                  },
                ),
                SizedBox(
                  width: 4,
                ),
                ChoiceChip(
                  label: Text('Upcoming'),
                  selected: _type == "upcoming",
                  backgroundColor: Colors.transparent,
                  shape: StadiumBorder(side: BorderSide()),
                  selectedColor: Theme.of(context).colorScheme.primary,
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                  onSelected: (bool newValue) {
                    setState(() {
                      _type = "upcoming";
                    });
                  },
                ),
                SizedBox(
                  width: 4,
                ),
                ChoiceChip(
                  label: Text('Special'),
                  selected: _type == "special",
                  backgroundColor: Colors.transparent,
                  shape: StadiumBorder(side: BorderSide()),
                  selectedColor: Theme.of(context).colorScheme.primary,
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                  onSelected: (bool newValue) {
                    setState(() {
                      _type = "special";
                    });
                  },
                ),
                SizedBox(
                  width: 4,
                ),
                ChoiceChip(
                  label: Text('Story'),
                  selected: _type == "story",
                  backgroundColor: Colors.transparent,
                  shape: StadiumBorder(side: BorderSide()),
                  selectedColor: Theme.of(context).colorScheme.primary,
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                  onSelected: (bool newValue) {
                    setState(() {
                      _type = "story";
                    });
                  },
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: _imageController,
              decoration: InputDecoration(
                hintText: 'Image URL',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: _titleController,
              maxLength: 32,
              decoration: InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: _subtitleController,
              minLines: 2,
              maxLines: null,
              maxLength: 128,
              decoration: InputDecoration(
                hintText: 'Sub-title',
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: _bodyController,
              keyboardType: TextInputType.multiline,
              minLines: 24,
              maxLines: null,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Enter your article..."),
            ),
            TextFieldTags(
                initialTags: _tags,
                textSeparators: [','],
                textFieldStyler: TextFieldStyler(
                    helperText: '',
                    helperStyle:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                    textFieldBorder: InputBorder.none,
                    textFieldFocusedBorder: InputBorder.none,
                    textFieldDisabledBorder: InputBorder.none,
                    textFieldEnabledBorder: InputBorder.none),
                tagsStyler: TagsStyler(
                    tagPadding: const EdgeInsets.all(8.0),
                    tagDecoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius:
                            BorderRadiusDirectional.all(Radius.circular(8))),
                    tagCancelIcon: const Icon(Icons.cancel,
                        size: 18.0, color: Colors.black)),
                onTag: (tag) {
                  _tags.add(tag);
                },
                onDelete: (tag) {
                  _tags.remove(tag);
                },
                validator: (tag) {
                  if (tag.length > 16) {
                    return "Hey that's too long";
                  }
                  if (_tags.contains(tag)) {
                    return "Tag already added";
                  }
                  return null;
                }),
            TextFormField(
              controller: _messageController,
              minLines: 2,
              maxLines: null,
              maxLength: 128,
              decoration: InputDecoration(
                hintText: 'Message',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Edited at ${DateFormat.yMMMd().format(_timeStamp)}',
              textAlign: TextAlign.end,
              style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
            )
          ],
        ),
      ),
    );
  }
}
