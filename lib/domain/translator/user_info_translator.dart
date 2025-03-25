import 'package:kabar/data/datasources/remote/models/user_info_model.dart';
import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/gen/assets.gen.dart';

class UserInfoTranslator {
  static UserInfo translateToEntity(UserInfoModel model) {
    return UserInfo(
      id: model.userId,
      fullName: model.name, image: Assets.images.wilson.path,
      isAuthor: true,
      follower: 2156,
      following: 567,
      newsNumber: 23,
    );
  }
}
