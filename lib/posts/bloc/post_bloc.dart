import 'dart:async';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:read_posts_api/posts/models/comment.dart';
import 'package:read_posts_api/posts/models/post.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostState> {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';
  final http.Client httpClient;

  PostsBloc(this.httpClient) : super(const PostState()) {
    on<FetchPosts>(_onFetchPosts);
    on<FetchPostById>(_onFetchPostById);
    on<FetchCommentsByPostId>(_onFetchCommentsByPostId);
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    if (state.status == PostStatus.loading) return;

    try {
      emit(state.copyWith(status: PostStatus.loading));
      final response = await httpClient.get(Uri.parse('$baseUrl/posts'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final posts = data.map((json) => Post.fromJson(json)).toList();
        emit(state.copyWith(
          status: PostStatus.success,
          posts: posts,
          hasReachedMax: false,
        ));
      } else {
        emit(state.copyWith(status: PostStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<void> _onFetchPostById(
      FetchPostById event, Emitter<PostState> emit) async {
    try {
      emit(state.copyWith(status: PostStatus.loading));
      final response =
          await httpClient.get(Uri.parse('$baseUrl/posts/${event.id}'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final post = Post.fromJson(data);
        emit(state.copyWith(
          status: PostStatus.success,
          post: post,
        ));
      } else {
        emit(state.copyWith(status: PostStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<void> _onFetchCommentsByPostId(
      FetchCommentsByPostId event, Emitter<PostState> emit) async {
    try {
      emit(state.copyWith(status: PostStatus.loading));
      final response = await httpClient
          .get(Uri.parse('$baseUrl/posts/${event.postId}/comments'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final comments = data.map((json) => Comment.fromJson(json)).toList();
        emit(state.copyWith(
          status: PostStatus.success,
          comments: comments,
        ));
      } else {
        emit(state.copyWith(status: PostStatus.failure));
      }
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}
