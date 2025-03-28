import 'package:injectable/injectable.dart';
import 'package:kabar/domain/entities/news.dart';
import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/presentation/base/base_controller.dart';
import 'package:kabar/presentation/views/pages/detail/detail_state.dart';

@injectable
class DetailController extends BaseController<DetailState> {
  DetailController() : super(const DetailState());

  @override
  DetailState createEmptyState() {
    return const DetailState();
  }

  void iniNews(News news) {
    state = state.copyWith(news: news);
  }

  void followAuthor() {
    final News? news = state.news?.copyWith(
        author: state.news?.author.copyWith(followed: true) ??
            const UserInfo(
                id: 0,
                fullName: '',
                image: '',
                isAuthor: true,
                follower: 0,
                following: 0,
                ));
    if (news != null) {
      state = state.copyWith(news: news);
    }
  }

  void unFollowAuthor() {
    final News? news = state.news?.copyWith(
        author: state.news?.author.copyWith(followed: false) ??
            const UserInfo(
                id: 0,
                fullName: '',
                image: '',
                isAuthor: true,
                follower: 0,
                following: 0,
                ));
    if (news != null) {
      state = state.copyWith(news: news);
    }
  }

  void like(bool liked){
    final News? news;
    if(liked) {
      news = state.news?.copyWith(
          liked: true,
        likes: state.news!.likes+1,
      );
    }
    else{
      news = state.news?.copyWith(
          liked: false,
        likes: state.news!.likes-1,
      );
    }
    if (news != null) {
      state = state.copyWith(news: news);
    }
  }

  void save(bool saved) {
    final News? news;
    if(saved) {
      news = state.news?.copyWith(
        saved: true,
      );
    }
    else{
      news = state.news?.copyWith(
        saved: false,
      );
    }
    if (news != null) {
      state = state.copyWith(news: news);
    }
  }
}
