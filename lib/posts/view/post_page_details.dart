import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_posts_api/posts/bloc/post_bloc.dart';
import 'package:read_posts_api/widgets/comment_card.dart';

class PostDetailPage extends StatelessWidget {
  final int postId;

  const PostDetailPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    // Fetch post details and comments when the page is first built
    context.read<PostsBloc>().add(FetchPostById(postId));
    context.read<PostsBloc>().add(FetchCommentsByPostId(postId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
        backgroundColor: Colors.greenAccent,
      ),
      body: BlocBuilder<PostsBloc, PostState>(
        builder: (context, state) {
          if (state.status == PostStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == PostStatus.success) {
            final post = state.post;
            final comments = state.comments;

            if (post == null) {
              return const Center(child: Text('Post not found.'));
            }

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
          } else if (state.status == PostStatus.failure) {
            return const Center(
                child: Text('Failed to load post details or comments.'));
          }
          return const Center(child: Text('No data available.'));
        },
      ),
    );
  }
}
