import 'package:injectable/injectable.dart';
import 'package:kabar/domain/entities/notification.dart';
import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/domain/enum/action.dart';
import 'package:kabar/domain/repositories/notification_repository.dart';
import 'package:kabar/gen/assets.gen.dart';
import 'package:kabar/shared/common/result.dart';
import 'package:kabar/shared/extensions/datetime.dart';

@Injectable(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  @override
  Future<Result<List<NotificationItem>>> getNotifications(
      {DateTime? day}) async {
    final List<NotificationItem> list = [
      NotificationItem(
        id: 1,
        creator: UserInfo(
          id: 1,
          fullName: 'BBC News',
          image: Assets.images.bbc.path,
          isAuthor: true,
          follower: 10000,
          following: 0,
          newsNumber: 0,
        ),
        action: UserAction.posted,
        newsTopic: 'europe news',
        newsName:
            "Ukraine's President Zelensky to BBC: Blood money being paid for Russian oil",
        sendAt: DateTime.now().subtract(const Duration(minutes: 15)),
      ),
      NotificationItem(
        id: 2,
        creator: UserInfo(
          id: 2,
          fullName: 'Modelyn Saris',
          image: Assets.images.saris.path,
          isAuthor: true,
          follower: 10000,
          following: 0,
          newsNumber: 0,
        ),
        action: UserAction.follow,
        sendAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      NotificationItem(
        id: 3,
        creator: UserInfo(
          id: 3,
          fullName: 'Omar Merditz',
          image: Assets.images.omar.path,
          isAuthor: true,
          follower: 10000,
          following: 0,
          newsNumber: 0,
        ),
        action: UserAction.comment,
        newsName:
            'Minting Your First NFT: America children build widget at beach',
        sendAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      NotificationItem(
        id: 4,
        creator: UserInfo(
          id: 4,
          fullName: 'Marley Botosh',
          image: Assets.images.marley.path,
          isAuthor: true,
          follower: 10000,
          following: 0,
          newsNumber: 0,
        ),
        action: UserAction.follow,
        sendAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      NotificationItem(
        id: 5,
        creator: UserInfo(
          id: 2,
          fullName: 'Modelyn Saris',
          image: Assets.images.saris.path,
          isAuthor: true,
          follower: 10000,
          following: 0,
          newsNumber: 0,
        ),
        action: UserAction.like,
        newsName:
            'Minting Your First NFT: America children build widget at beach',
        sendAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      NotificationItem(
        id: 6,
        creator: UserInfo(
          id: 5,
          fullName: 'CNN',
          image: Assets.images.cnn.path,
          isAuthor: true,
          follower: 10000,
          following: 0,
          newsNumber: 0,
        ),
        action: UserAction.posted,
        newsTopic: 'travel news',
        newsName:
            'Her train broke down. Her phone died. And then she met her future husband',
        sendAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      NotificationItem(
        id: 7,
        creator: UserInfo(
          id: 3,
          fullName: 'Omar Merditz',
          image: Assets.images.omar.path,
          isAuthor: true,
          follower: 10000,
          following: 0,
          newsNumber: 0,
        ),
        action: UserAction.like,
        newsName:
            'Minting Your First NFT: America children build widget at beach',
        sendAt: DateTime.now().subtract(const Duration(days: 4)),
      ),
    ];
    if (day == null) {
      return Result.completed(list);
    } else {
      return Result.completed(
          list.where((n) => n.sendAt.dateOnly == day.dateOnly).toList());
    }
  }
}
