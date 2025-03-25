import 'package:injectable/injectable.dart';
import 'package:kabar/domain/entities/notification.dart';
import 'package:kabar/domain/repositories/notification_repository.dart';
import 'package:kabar/presentation/base/base_controller.dart';
import 'package:kabar/presentation/base/page_status.dart';
import 'package:kabar/presentation/views/pages/home_notification/home_notification_state.dart';
import 'package:kabar/shared/extensions/datetime.dart';

@injectable
class HomeNotificationController extends BaseController<HomeNotificationState> {
  HomeNotificationController(this.notificationRepository) : super( const HomeNotificationState());
  final NotificationRepository notificationRepository;

  @override
  Future<void> initData() async {
    final List<NotificationItem>? notifications =(await notificationRepository.getNotifications()).data;
    final Set<DateTime> dates = {};
    if(notifications != null) {
      for (final n in notifications) {
        dates.add(n.sendAt.dateOnly);
      }
    }
    state = state.copyWith(pageStatus: PageStatus.Loaded, notifications: notifications ?? [], sendTimes: dates);
  }

  @override
  HomeNotificationState createEmptyState() {
    return const HomeNotificationState();
  }

  Future<void> getAllNotifications({DateTime? day}) async{
    final List<NotificationItem>? notifications;
    if(day == null) {
      notifications = (await notificationRepository.getNotifications()).data;
    }
    else{
      notifications = (await notificationRepository.getNotifications(day: day)).data;
    }
    state = state.copyWith(notifications: notifications ?? []);
  }

  void followUser(String name) {
    final List<NotificationItem> list = List<NotificationItem>.from(state.notifications);
    for (int i =0; i<list.length;i++) {
      if(list[i].creator.fullName == name) {
        list[i] = list[i].copyWith(creator: list[i].creator.copyWith(followed: true));
        break;
      }
    }
    state = state.copyWith(notifications: list);
  }

  void unFollowUser(String name) {
    final List<NotificationItem> list = List<NotificationItem>.from(state.notifications);
    for (int i =0; i<list.length;i++) {
      if(list[i].creator.fullName == name) {
        list[i] = list[i].copyWith(creator: list[i].creator.copyWith(followed: false));
        break;
      }
    }
    state = state.copyWith(notifications: list);
  }
}
