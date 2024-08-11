import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_posts_api/posts/provider/post_provider.dart';
import 'package:read_posts_api/posts/view/posts_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => PostProvider()..fetchPosts()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Posts  api with provider',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PostsPage(),
    );
  }
}
