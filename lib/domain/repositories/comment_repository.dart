import 'package:kabar/domain/entities/comment.dart';
import 'package:kabar/shared/common/result.dart';

abstract interface class CommentRepository {
  Future<Result<List<Comment>>> getComments();
  Future<void> postComment(Comment comment);
  Future<void> updateComment(Comment comment);
}
