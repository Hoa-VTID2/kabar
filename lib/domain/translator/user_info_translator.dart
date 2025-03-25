import 'package:kabar/data/datasources/remote/models/user_info_model.dart';
import 'package:kabar/domain/entities/user_info.dart';

class UserInfoTranslator {
  static UserInfo translateToEntity(UserInfoModel model) {
    return UserInfo(
      id: model.userId,
      fullName: model.name, image: '',
      isAuthor: false,
      follower: 0,
    );
  }
}
