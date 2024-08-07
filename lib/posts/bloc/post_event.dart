part of 'post_bloc.dart';

abstract class PostsEvent {}

class FetchPosts extends PostsEvent {}

class FetchPostById extends PostsEvent {
  final int id;
  FetchPostById(this.id);
}

class FetchCommentsByPostId extends PostsEvent {
  final int postId;
  FetchCommentsByPostId(this.postId);
}
