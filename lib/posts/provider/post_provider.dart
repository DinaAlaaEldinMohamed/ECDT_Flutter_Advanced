import 'package:flutter/material.dart';
import 'package:read_posts_api/posts/models/comment.dart';
import 'package:read_posts_api/posts/models/post.dart';
import 'package:read_posts_api/repository/comments_repostiory.dart';
import 'package:read_posts_api/repository/posts_repostiory.dart';

class PostProvider with ChangeNotifier {
  final PostsRepository _postsRepository = PostsRepository();
  final CommentsRepository _commentsRepository = CommentsRepository();

  List<Post> _posts = [];
  Post? _post;
  List<Comment> _comments = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Post> get posts => _posts;
  Post? get post => _post;
  List<Comment> get comments => _comments;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchPosts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _postsRepository.get();
      if (result.isSuccess) {
        _posts = List<Post>.from(result.data.map((e) => Post.fromJson(e)));
      } else {
        _errorMessage = result.error;
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPostById(int postId) async {
    if (_post == null) {
      // Only fetch if not already fetched
      _isLoading = true;
      notifyListeners();

      try {
        final result = await _postsRepository.get({'id': postId.toString()});
        if (result.isSuccess) {
          // Ensure proper spelling
          _post = Post.fromJson(result.data[0]);
        } else {
          _errorMessage = result.error;
        }
      } catch (e) {
        _errorMessage = e.toString();
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> fetchComments(int postId) async {
    if (_comments.isEmpty) {
      // Only fetch if not already fetched
      _isLoading = true;
      notifyListeners();

      try {
        final result =
            await _commentsRepository.get({'postId': postId.toString()});
        if (result.isSuccess) {
          // Ensure proper spelling
          _comments =
              List<Comment>.from(result.data.map((e) => Comment.fromJson(e)));
        } else {
          _errorMessage = result.error;
        }
      } catch (e) {
        _errorMessage = e.toString();
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }
}
