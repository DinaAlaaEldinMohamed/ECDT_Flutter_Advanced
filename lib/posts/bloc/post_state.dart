part of 'post_bloc.dart';

enum PostStatus { initial, loading, success, failure }

class PostState extends Equatable {
  const PostState({
    this.status = PostStatus.initial,
    this.posts = const <Post>[],
    this.post,
    this.comments = const <Comment>[],
    this.hasReachedMax = false,
  });

  final PostStatus status;
  final List<Post> posts;
  final Post? post;
  final List<Comment> comments;
  final bool hasReachedMax;

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    Post? post,
    List<Comment>? comments,
    bool? hasReachedMax,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      post: post ?? this.post,
      comments: comments ?? this.comments,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${posts.length}, comments: ${comments.length} }''';
  }

  @override
  List<Object?> get props => [status, posts, post, comments, hasReachedMax];
}
