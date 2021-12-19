import 'package:bookish/models/post.dart';
import 'package:bookish/widgets/post_card.dart';
import 'package:flutter/material.dart';

class PostSection extends StatelessWidget {

  final List<Post> posts;
  PostSection({required this.posts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Social Bookworms', style: Theme.of(context).textTheme.headline3),
          const SizedBox(height: 16),
          Container(
            // height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              //Important 3 lines for nested lists
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: posts.length,
              itemBuilder: (ctx, i) {
                return PostCard(post: posts[i]);
              },
            ),
          )
        ],
      ),
    );
  }
}
