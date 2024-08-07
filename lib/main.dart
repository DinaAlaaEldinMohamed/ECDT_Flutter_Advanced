import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_posts_api/posts/bloc/post_bloc.dart';
import 'package:read_posts_api/posts/view/posts_page.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(BlocProvider(
    create: (context) => PostsBloc(http.Client()),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PostsPage(),
    );
  }
}
