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

  void updateContent(String content) {
    state = state.copyWith(content: content);
  }

  void updateReply(int replyTo) {
    state = state.copyWith(replyTo: replyTo);
  }

  void likeComment(int id) {
    final List<Comment> comments = List<Comment>.from(state.comments);
    int index =0;
    for(int i=0;i<comments.length;i++) {
      if(comments[i].id==id){
        index = i;
      }
    }
    comments[index] = comments[index].copyWith(liked: true, likes: comments[index].likes+1);
    commentRepository.updateComment(comments[index]);
    state = state.copyWith(comments:  comments);
  }

  void unLikeComment(int id) {
    final List<Comment> comments = List<Comment>.from(state.comments);
    int index =0;
    for(int i=0;i<comments.length;i++) {
      if(comments[i].id==id){
        index = i;
      }
    }
    comments[index] = comments[index].copyWith(liked: false, likes: comments[index].likes-1);
    commentRepository.updateComment(comments[index]);
    state = state.copyWith(comments:  comments);
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
        liked: false,
        replyCommentId: (state.replyTo != -1) ? state.replyTo : -1
    );
    final List<Comment> comments = List<Comment>.from(state.comments);
    comments.add(cmt);
    final List<bool> show = [];
    for(int i =0; i<comments.length;i++) {
      show.add(false);
    }
    final List<bool> oldShow = List<bool>.from(state.showSubs);
    for(int i=0; i<oldShow.length;i++){
      show[i] = show[i] | oldShow[i];
    }
    commentRepository.postComment(cmt);
    state = state.copyWith(comments: comments,commentId: state.commentId + 1, content: '', replyTo: -1,showSubs: show);
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
