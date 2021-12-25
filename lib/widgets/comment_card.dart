import 'package:bookish/models/article.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;

  const CommentCard({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(comment.imageUrl),
                radius: 20,
              ),
              Flexible(
                child: Container(
                  child: Container(
                    padding: EdgeInsets.all(4),
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(4),
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4)),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment.username,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Wrap(
                          children: [
                            Text(
                              comment.message,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Text(
            'At ${DateFormat.yMMMd().format(comment.timeStamp)}',
            style:
                TextStyle(color: Colors.grey[300], fontStyle: FontStyle.italic),
          )
        ],
      ),
    );
  }
}
