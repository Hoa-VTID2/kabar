import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/shared/common/result.dart';

abstract interface class UserRepository {
  Future<Result<List<UserInfo>>> getUsers();
  Future<Result<UserInfo>> getUserById(int id);
}
