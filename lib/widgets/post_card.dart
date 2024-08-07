import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_posts_api/posts/bloc/post_bloc.dart';
import 'package:read_posts_api/posts/models/post.dart';
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
        onTap: () {
          context.read<PostsBloc>().add(FetchPostById(post.id));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetailPage(postId: post.id),
            ),
          );
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
                  color: Colors.black87, // Custom color for title text
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                post.body,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[700], // Custom color for body text
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
