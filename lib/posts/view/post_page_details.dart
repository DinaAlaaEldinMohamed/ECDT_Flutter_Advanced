import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_posts_api/posts/provider/post_provider.dart';
import 'package:read_posts_api/widgets/comment_card.dart';

class PostDetailPage extends StatelessWidget {
  final int postId;

  const PostDetailPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    // Fetch data if not already fetched
    if (postProvider.post == null && postProvider.comments.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        postProvider.fetchPostById(postId);
        postProvider.fetchComments(postId);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Consumer<PostProvider>(
        builder: (context, postProvider, child) {
          if (postProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (postProvider.errorMessage.isNotEmpty) {
            return Center(child: Text(postProvider.errorMessage));
          } else if (postProvider.post == null) {
            return const Center(child: Text('Post not found.'));
          } else {
            final post = postProvider.post!;
            final comments = postProvider.comments;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.blueGrey.shade200,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Text(
                      post.title,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    post.body,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  const Text(
                    'Comments',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        return CommentCard(comment: comment);
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
