import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
abstract class Comment with _$Comment {
  @JsonSerializable(explicitToJson: true)
  const factory Comment({
    required int id,
    required int newId,
    required int userId,
    required String content,
    required DateTime sendAt,
    required int likes,
    required bool liked,
    @Default(-1) int replyCommentId,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
