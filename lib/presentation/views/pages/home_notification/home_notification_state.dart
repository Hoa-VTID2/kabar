import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kabar/domain/entities/notification.dart';
import 'package:kabar/presentation/base/base_state.dart';
import 'package:kabar/presentation/base/page_status.dart';

part 'home_notification_state.freezed.dart';

@freezed
abstract class HomeNotificationState extends BaseState with _$HomeNotificationState {
  const factory HomeNotificationState({
    @Default(PageStatus.Loaded) PageStatus pageStatus,
    @Default([]) List<NotificationItem> notifications,
    @Default({}) Set<DateTime> sendTimes,
  }) = _HomeNotificationState;

}
