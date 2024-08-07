import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_posts_api/posts/bloc/post_bloc.dart';
import 'package:read_posts_api/widgets/post_card.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        backgroundColor: Colors.greenAccent,
        elevation: 4.0,
      ),
      body: BlocBuilder<PostsBloc, PostState>(
        builder: (context, state) {
          if (state.status == PostStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == PostStatus.success) {
            if (state.posts.isEmpty) {
              return const Center(child: Text('No posts available.'));
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return PostCard(post: post);
                },
              ),
            );
          } else if (state.status == PostStatus.failure) {
            return const Center(child: Text('Failed to load posts.'));
          }
          return const Center(child: Text('No data'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<PostsBloc>().add(FetchPosts());
        },
        backgroundColor: Colors.greenAccent,
        tooltip: 'Refresh Posts',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
