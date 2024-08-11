import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_posts_api/posts/models/post.dart';
import 'package:read_posts_api/posts/provider/post_provider.dart';
import 'package:read_posts_api/posts/view/post_page_details.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () async {
          final postProvider =
              Provider.of<PostProvider>(context, listen: false);

          // Define a function to handle fetching and navigation
          Future<void> handleNavigation() async {
            if (postProvider.post == null || postProvider.post?.id != post.id) {
              try {
                await postProvider.fetchPostById(post.id);
                await postProvider.fetchComments(post.id);
              } catch (e) {
                String errorMessage = 'Error: $e';
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(errorMessage)),
                  );
                }
                return; // Exit if there was an error
              }
            }

            if (context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetailPage(postId: post.id),
                ),
              );
            }
          }

          handleNavigation();
        },
        borderRadius: BorderRadius.circular(10.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                post.body,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[700],
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
