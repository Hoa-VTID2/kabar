import 'package:injectable/injectable.dart';
import 'package:kabar/domain/entities/news.dart';
import 'package:kabar/domain/entities/notification.dart';
import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/domain/enum/category.dart';
import 'package:kabar/domain/repositories/news_repository.dart';
import 'package:kabar/domain/repositories/notification_repository.dart';
import 'package:kabar/gen/assets.gen.dart';
import 'package:kabar/presentation/base/base_controller.dart';
import 'package:kabar/presentation/base/page_status.dart';
import 'package:kabar/presentation/views/pages/home_top/home_top_state.dart';
import 'package:kabar/shared/extensions/datetime.dart';

@injectable
class HomeTopController extends BaseController<HomeTopState> {
  HomeTopController(this.newsRepository, this.notificationRepository)
      : super(const HomeTopState());
  final NewsRepository newsRepository;
  final NotificationRepository notificationRepository;

  @override
  Future<void> initData() async {
    final List<NotificationItem>? notifications =
        (await notificationRepository.getNotifications()).data;
    final Set<DateTime> dates = {};
    if (notifications != null) {
      for (final n in notifications) {
        dates.add(n.sendAt.dateOnly);
      }
    }
    state = state.copyWith(
        pageStatus: PageStatus.Loaded,
        notifications: notifications ?? [],
        sendTimes: dates);
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
              follower: 0,
              following: 0,
              newsNumber: 0,
            ),
            time: DateTime.now(),
            category: Category.all);
  }

  Future<void> getAllNotifications({DateTime? day}) async {
    final List<NotificationItem>? notifications;
    if (day == null) {
      notifications = (await notificationRepository.getNotifications()).data;
    } else {
      notifications =
          (await notificationRepository.getNotifications(day: day)).data;
    }
    state = state.copyWith(notifications: notifications ?? []);
  }

  void followUser(String name) {
    final List<NotificationItem> list =
        List<NotificationItem>.from(state.notifications);
    for (int i = 0; i < list.length; i++) {
      if (list[i].creator.fullName == name) {
        list[i] =
            list[i].copyWith(creator: list[i].creator.copyWith(followed: true));
        break;
      }
    }
    state = state.copyWith(notifications: list);
  }

  void unFollowUser(String name) {
    final List<NotificationItem> list =
        List<NotificationItem>.from(state.notifications);
    for (int i = 0; i < list.length; i++) {
      if (list[i].creator.fullName == name) {
        list[i] = list[i]
            .copyWith(creator: list[i].creator.copyWith(followed: false));
        break;
      }
    }
    state = state.copyWith(notifications: list);
  }

  void updateNotificationPage(bool isNotificationPage) {
    state = state.copyWith(isNotificationPage: isNotificationPage);
  }
}
