import 'package:kabar/domain/entities/notification.dart';
import 'package:kabar/shared/common/result.dart';

abstract interface class NotificationRepository {
  Future<Result<List<NotificationItem>>> getNotifications({DateTime? day});
}
