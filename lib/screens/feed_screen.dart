import 'package:bookish/api/mock_book_service.dart';
import 'package:bookish/widgets/article_section.dart';
import 'package:bookish/widgets/post_section.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  FeedScreen({Key? key}) : super(key: key);

  final mockBookService = MockBookService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: mockBookService.getFeeds(),
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final articles = snapshot.data!['articles'] ?? [];
              final posts = snapshot.data!['posts'] ?? [];
              return ListView(children: [
                ArticleSection(articles: articles),
                PostSection(posts: posts)
              ]);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
