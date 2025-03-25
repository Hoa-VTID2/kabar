import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/domain/enum/action.dart';

part 'notification.freezed.dart';

@freezed
abstract class NotificationItem with _$NotificationItem {
  const factory NotificationItem({
    required int id,
    required UserInfo creator,
    required UserAction action,
    required DateTime sendAt,
    String? newsName,
    String? newsTopic,
  }) = _NotificationItem;
}
