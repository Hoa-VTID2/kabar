import 'package:injectable/injectable.dart';
import 'package:kabar/data/datasources/local/comment_local_data_source.dart';
import 'package:kabar/domain/entities/comment.dart';
import 'package:kabar/domain/repositories/comment_repository.dart';
import 'package:kabar/shared/common/result.dart';

@Injectable(as: CommentRepository)
class CommentRepositoryImpl implements CommentRepository {
  CommentRepositoryImpl(this._commentLocalDataSource);
  final CommentLocalDataSource _commentLocalDataSource;

  @override
  Future<Result<List<Comment>>> getComments() async {
    final List<Comment> comments = await _commentLocalDataSource.getComments();
    return Result.completed(comments);
  }

  @override
  Future<void> postComment(Comment comment) async {
    _commentLocalDataSource.saveComment(comment);
  }

  @override
  Future<void> updateComment(Comment comment) async {
    _commentLocalDataSource.updateComment(comment);
  }



}
