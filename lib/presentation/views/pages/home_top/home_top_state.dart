import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kabar/domain/entities/news.dart';
import 'package:kabar/domain/entities/notification.dart';
import 'package:kabar/presentation/base/base_state.dart';
import 'package:kabar/presentation/base/page_status.dart';

part 'home_top_state.freezed.dart';

@freezed
abstract class HomeTopState extends BaseState with _$HomeTopState {
  const factory HomeTopState({
    @Default(PageStatus.Loaded) PageStatus pageStatus,
    @Default([]) List<News> news,
    @Default([]) List<NotificationItem> notifications,
    @Default({}) Set<DateTime> sendTimes,
    @Default(false) bool isNotificationPage,
  }) = _HomeTopState;

}
