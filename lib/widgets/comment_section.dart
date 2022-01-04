import 'package:bookish/models/article.dart';
import 'package:bookish/models/user.dart';
import 'package:bookish/providers/articles_provider.dart';
import 'package:bookish/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'comment_card.dart';

class CommentSection extends StatefulWidget {
  final String id;
  final List<Comment>? comments;

  const CommentSection({Key? key, required this.id, required this.comments})
      : super(key: key);

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final _commentController = TextEditingController();
  String message = "";

  @override
  void initState() {
    widget.comments?.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
    _commentController.addListener(() {
      message = _commentController.text;
    });
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void addComment() {
    User user = Provider.of<ProfileProvider>(context, listen: false).user;
    Comment comment = Comment(
        id: user.uid,
        username: user.username,
        imageUrl: user.profileImageUrl,
        message: message,
        timeStamp: DateTime.now());
    Provider.of<ArticlesProvider>(context, listen: false)
        .addComment(widget.id, comment);
    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Read & Comment',
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  ?.copyWith(color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: widget.comments != null
                ? Column(children: [
                    ...widget.comments!
                        .map((c) => CommentCard(
                              comment: c,
                            ))
                        .toList()
                  ])
                : SizedBox(),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: _commentController,
              minLines: 1,
              maxLines: 8,
              // maxLength: 128,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Comment',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                suffixIcon: IconButton(
                  onPressed: addComment,
                  icon: Icon(
                    Icons.whatshot,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
