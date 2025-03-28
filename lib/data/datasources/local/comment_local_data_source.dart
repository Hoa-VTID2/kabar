import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:kabar/domain/entities/comment.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CommentLocalDataSource {
  Future<List<Comment>> getComments();
  Future<void> saveComment(Comment comment);
  Future<void> updateComment(Comment comment);
  Future<void> deleteComment(int commentId);
  Future<void> clearAllComments();
}

@Injectable(as: CommentLocalDataSource)
class CommentLocalDataSourceImpl implements CommentLocalDataSource {
  static const String commentKey = 'comments';

  static final List<Comment> _defaultComments = [
    Comment(
      id: 1,
      newId: 1,
      userId: 1,
      content:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      sendAt: DateTime.now().subtract(const Duration(days: 28)),
      likes: 125,
      liked: false,
    ),
    Comment(
      id: 2,
      newId: 1,
      userId: 2,
      content:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      sendAt: DateTime.now().subtract(const Duration(days: 28)),
      likes: 3,
      liked: true,
      replyCommentId: 1,
    ),
    Comment(
      id: 3,
      newId: 1,
      userId: 2,
      content:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      sendAt: DateTime.now().subtract(const Duration(days: 28)),
      likes: 3,
      liked: true,
      replyCommentId: 1,
    ),
    Comment(
      id: 4,
      newId: 1,
      userId: 2,
      content:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      sendAt: DateTime.now().subtract(const Duration(days: 28)),
      likes: 3,
      liked: true,
      replyCommentId: 1,
    ),
    Comment(
      id: 5,
      newId: 1,
      userId: 5,
      content:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      sendAt: DateTime.now().subtract(const Duration(days: 28)),
      likes: 25,
      liked: false,
    ),
    Comment(
      id: 6,
      newId: 1,
      userId: 4,
      content:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      sendAt: DateTime.now().subtract(const Duration(days: 28)),
      likes: 12,
      liked: false,
    ),
    Comment(
      id: 7,
      newId: 1,
      userId: 2,
      content:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      sendAt: DateTime.now().subtract(const Duration(days: 28)),
      likes: 3,
      liked: true,
      replyCommentId: 6,
    ),
    Comment(
      id: 8,
      newId: 1,
      userId: 2,
      content:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      sendAt: DateTime.now().subtract(const Duration(days: 28)),
      likes: 3,
      liked: true,
      replyCommentId: 6,
    ),
    Comment(
      id: 9,
      newId: 1,
      userId: 3,
      content:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      sendAt: DateTime.now().subtract(const Duration(days: 28)),
      likes: 16,
      liked: true,
    ),
    Comment(
      id: 10,
      newId: 1,
      userId: 6,
      content:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      sendAt: DateTime.now().subtract(const Duration(days: 28)),
      likes: 14000,
      liked: true,
    ),
  ];

  Future<SharedPreferences> _getPrefs() async =>
      SharedPreferences.getInstance();

  @override
  Future<List<Comment>> getComments() async {
    final prefs = await _getPrefs();
    final commentJson = prefs.getString(commentKey);
    if (commentJson == null) {
      await prefs.setString(
        commentKey,
        json.encode(_defaultComments.map((e) => e.toJson()).toList()),
      );
      return _defaultComments;
    }

    final List<dynamic> jsonList = json.decode(commentJson) as List<dynamic>;
    return jsonList
        .map((e) => Comment.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveComment(Comment comment) async {
    final prefs = await _getPrefs();
    final comments = await getComments();
    comments.add(comment);
    await prefs.setString(
      commentKey,
      json.encode(comments.map((e) => e.toJson()).toList()),
    );
  }

  @override
  Future<void> updateComment(Comment comment) async {
    final prefs = await _getPrefs();
    final comments = await getComments();
    final index = comments.indexWhere((c) => c.id == comment.id);
    if (index != -1) {
      comments[index] = comment;
      await prefs.setString(
        commentKey,
        json.encode(comments.map((e) => e.toJson()).toList()),
      );
    }
  }

  @override
  Future<void> deleteComment(int commentId) async {
    final prefs = await _getPrefs();
    final comments = await getComments();
    comments.removeWhere((c) => c.id == commentId);
    await prefs.setString(
      commentKey,
      json.encode(comments.map((e) => e.toJson()).toList()),
    );
  }

  @override
  Future<void> clearAllComments() async {
    final prefs = await _getPrefs();
    await prefs.remove(commentKey);
  }
}
