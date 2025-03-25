import 'package:injectable/injectable.dart';
import 'package:kabar/domain/entities/news.dart';
import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/domain/enum/category.dart';
import 'package:kabar/domain/repositories/news_repository.dart';
import 'package:kabar/gen/assets.gen.dart';
import 'package:kabar/presentation/base/base_controller.dart';
import 'package:kabar/presentation/base/page_status.dart';
import 'package:kabar/presentation/views/pages/home_top/home_top_state.dart';

@injectable
class HomeTopController extends BaseController<HomeTopState> {
  HomeTopController(this.newsRepository) : super(const HomeTopState());
  final NewsRepository newsRepository;

  @override
  Future<void> initData() async {
    state = state.copyWith(pageStatus: PageStatus.Loaded);
  }

  @override
  HomeTopState createEmptyState() {
    return const HomeTopState();
  }

  Future<void> getTopicNews({Category? category}) async {
    final List<News>? news =
        (await newsRepository.getNews(category: category)).data;
    state = state.copyWith(news: news ?? []);
  }

  News getTrendNews() {
    return newsRepository.getTrendNews().data ??
        News(
            id: 0,
            img: Assets.images.img.path,
            topic: 'topic',
            fullName: 'content',
            detail: 'detail content',
            author: UserInfo(
                id: 0,
                fullName: 'Name',
                image: Assets.images.avtPlacehoder.path,
                isAuthor: true,
                follower: 0),
            time: DateTime.now(),
            category: Category.all);
  }
}
