import 'package:bookish/models/article.dart';
import 'package:bookish/models/your_article.dart';
import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:uuid/uuid.dart';

class AddArticleScreen extends StatefulWidget {
  final Function(YourArticle) onCreate;
  final Function(String, YourArticle) onUpdate;
  final Function(String) onUpload;
  final YourArticle? originalItem;
  bool isUpdating;

  AddArticleScreen({
    Key? key,
    required this.onCreate,
    required this.onUpdate,
    required this.onUpload,
    this.originalItem,
  })  : isUpdating = (originalItem != null),
        super(key: key);

  @override
  State<AddArticleScreen> createState() => _AddArticleScreenState();
}

class _AddArticleScreenState extends State<AddArticleScreen> {
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  final _messageController = TextEditingController();
  final _bodyController = TextEditingController();

  String _id = const Uuid().v1();
  String _type = "";
  String _title = "";
  String _subtitle = "";
  String _backgroundImage =
      "https://images.unsplash.com/photo-1531988042231-d39a9cc12a9a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fGJvb2tzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60";
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
    final originalItem = widget.originalItem;
    if (originalItem != null) {
      _id = originalItem.article.id;
      _type = originalItem.article.type;
      _title = originalItem.article.title;
      _subtitle = originalItem.article.subtitle;
      _backgroundImage = originalItem.article.backgroundImage;
      _message = originalItem.article.message;
      _body = originalItem.article.body;
      _tags = originalItem.article.tags;
      _timeStamp = originalItem.article.timeStamp;
      _isUploaded = originalItem.isUploaded;

      _titleController.text = _title;
      _subtitleController.text = _subtitle;
      _messageController.text = _message;
      _bodyController.text = _body;
    }
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
      widget.onUpdate(_id, yourArticle);
    else {
      widget.onCreate(yourArticle);
      widget.isUpdating = true;
    }
  }

  uploadArticle() {
    YourArticle yourArticle = getArticle();
    if (!widget.isUpdating) {
      widget.onCreate(yourArticle);
      widget.isUpdating = true;
    }
    widget.onUpdate(_id, yourArticle);
    widget.onUpload(_id);
    _isUploaded = true;
  }

  @override
  void dispose() {
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
          IconButton(
            icon: const Icon(Icons.cloud_upload_outlined),
            onPressed: uploadArticle,
          )
        ],
        title: Text('Bookish', style: Theme.of(context).textTheme.headline6),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
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
                )
              ],
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
              maxLength: 128,
              decoration: InputDecoration(
                hintText: 'Sub-title',
                border: OutlineInputBorder(),
              ),
            ),
            Expanded(
              child: TextFormField(
                controller: _bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: 'Enter your article..........',
                  // border: OutlineInputBorder(),
                ),
              ),
            ),
            TextFieldTags(
                initialTags: _tags,
                textFieldStyler:
                    TextFieldStyler(helperText: '', textFieldBorder: null),
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
                  if (tag.length > 15) {
                    return "Hey that's too long";
                  }
                  return null;
                }),
            TextFormField(
              controller: _messageController,
              maxLength: 128,
              decoration: InputDecoration(
                hintText: 'Message',
                border: OutlineInputBorder(),
              ),
            ),
            Text(
              'Edited at $_timeStamp',
              style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
            )
          ],
        ),
      ),
    );
  }
}
