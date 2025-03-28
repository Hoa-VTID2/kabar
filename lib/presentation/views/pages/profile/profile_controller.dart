import 'package:injectable/injectable.dart';
import 'package:kabar/domain/entities/news.dart';
import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/domain/repositories/auth_repository.dart';
import 'package:kabar/domain/repositories/news_repository.dart';
import 'package:kabar/presentation/base/base_controller.dart';
import 'package:kabar/presentation/views/pages/profile/profile_state.dart';

@injectable
class ProfileController extends BaseController<ProfileState> {
  ProfileController(this.authRepository, this.newsRepository)
      : super(const ProfileState());
  final AuthRepository authRepository;
  final NewsRepository newsRepository;

  @override
  ProfileState createEmptyState() {
    return const ProfileState();
  }

  Future<void> initUserData() async {
    final UserInfo? user = (await authRepository.getUserInfo()).data;
    if (user != null) {
      List<News>? news = (await newsRepository.getNews()).data;
      news = news
          ?.where(
            (element) => element.author.fullName == user.fullName,
          )
          .toList();
      final List<News>? recent = news
          ?.where(
            (element) => element.time
                .isAfter(DateTime.now().subtract(const Duration(days: 3))),
          )
          .toList();
      state = state.copyWith(currentUser: user, userNews: news ?? [], recentNews: recent ?? []);
    }
  }
}
