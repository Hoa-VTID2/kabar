import 'package:injectable/injectable.dart';
import 'package:kabar/domain/entities/comment.dart';
import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/domain/repositories/auth_repository.dart';
import 'package:kabar/domain/repositories/comment_repository.dart';
import 'package:kabar/domain/repositories/user_repository.dart';
import 'package:kabar/presentation/base/base_controller.dart';
import 'package:kabar/presentation/views/pages/comment/comment_state.dart';

@injectable
class CommentController extends BaseController<CommentState> {
  CommentController(
      this.commentRepository, this.authRepository, this.userRepository)
      : super(const CommentState());
  final CommentRepository commentRepository;
  final AuthRepository authRepository;
  final UserRepository userRepository;

  @override
  CommentState createEmptyState() {
    return const CommentState();
  }

  Future<void> initCommentData(int newsId) async {
    List<Comment>? comments = (await commentRepository.getComments()).data;
    final List<UserInfo>? users = (await userRepository.getUsers()).data;
    if (comments != null && users != null) {
      final int latestId = comments.last.id;
      comments = comments
          .where(
            (element) =>
                element.newId == newsId,
          )
          .toList();
      final List<bool> show = [];
      for(int i =0; i<comments.length;i++) {
        show.add(false);
      }
      state = state.copyWith(
          comments: comments,
          commentId: latestId,
          newsId: newsId,
          users: users,
          showSubs: show,
      );
    }
  }

  Future<void> updateData(int newsId) async {
    List<Comment>? comments = (await commentRepository.getComments()).data;
    final List<UserInfo>? users = (await userRepository.getUsers()).data;
    if (comments != null && users != null) {
      final int latestId = comments.last.id;
      comments = comments
          .where(
            (element) =>
        element.newId == newsId,
      )
          .toList();
      state = state.copyWith(
        comments: comments,
        commentId: latestId,
        newsId: newsId,
        users: users,
      );
    }
  }

  void updateContent(String content) {
    state = state.copyWith(content: content);
  }

  void updateReply(int replyTo) {
    state = state.copyWith(replyTo: replyTo);
  }

  void likeComment(int id) {
    Comment comment = state.comments.firstWhere(
      (element) => element.id == id,
    );
    comment = comment.copyWith(liked: true, likes: comment.likes + 1);
    commentRepository.updateComment(comment);
    updateData(state.newsId);
  }

  void unLikeComment(int id) {
    Comment comment = state.comments.firstWhere(
      (element) => element.id == id,
    );
    comment = comment.copyWith(liked: false, likes: comment.likes - 1);
    commentRepository.updateComment(comment);
    updateData(state.newsId);
  }

  Future<void> sendComment() async {
    final UserInfo? userInfo = (await authRepository.getUserInfo()).data;
    final Comment cmt = Comment(
        id: state.commentId + 1,
        newId: state.newsId,
        userId: userInfo?.id ?? 1,
        content: state.content,
        sendAt: DateTime.now(),
        likes: 0,
        liked: false);
    commentRepository.postComment(cmt);
    state = state.copyWith(commentId: state.commentId + 1, content: '');
  }

  void showSub(int id) {
    final List<bool> show = List.from(state.showSubs);
    show[id] = true;
    state = state.copyWith(showSubs:  show);
  }

  void hideSub(int id) {
    final List<bool> show = List.from(state.showSubs);
    show[id] = false;
    state = state.copyWith(showSubs:  show);
  }
}
