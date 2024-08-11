import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_posts_api/posts/provider/post_provider.dart';
import 'package:read_posts_api/widgets/post_card.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  void initState() {
    super.initState();
    // Fetch posts when the widget is first initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final postProvider = Provider.of<PostProvider>(context, listen: false);
      postProvider.fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        backgroundColor: Colors.greenAccent,
        elevation: 4.0,
      ),
      body: Consumer<PostProvider>(
        builder: (context, postProvider, child) {
          if (postProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (postProvider.errorMessage.isNotEmpty) {
            return Center(child: Text(postProvider.errorMessage));
          } else if (postProvider.posts.isEmpty) {
            return const Center(child: Text('No posts available.'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: postProvider.posts.length,
              itemBuilder: (context, index) {
                final post = postProvider.posts[index];
                return PostCard(post: post);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final postProvider =
              Provider.of<PostProvider>(context, listen: false);
          postProvider.fetchPosts();
        },
        backgroundColor: Colors.greenAccent,
        tooltip: 'Refresh Posts',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
