import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kabar/domain/entities/comment.dart';
import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/presentation/base/base_state.dart';
import 'package:kabar/presentation/base/page_status.dart';

part 'comment_state.freezed.dart';

@freezed
abstract class CommentState extends BaseState with _$CommentState {
  const factory CommentState({
    @Default(PageStatus.Loaded) PageStatus pageStatus,
    @Default([]) List<Comment> comments,
    @Default([]) Map<int,bool> showSubs,
    @Default([]) List<UserInfo> users,
    @Default(1) int newsId,
    @Default('') String content,
    @Default(-1) int replyTo,
    @Default(1000) int commentId,
  }) = _CommentState;
}
