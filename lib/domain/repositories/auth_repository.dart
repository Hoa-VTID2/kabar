import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/shared/common/result.dart';

abstract interface class AuthRepository {
  Future<Result<UserInfo>> login(
      {required String username, required String password});

  Future<Result<String?>> getUsername();

  Future<Result<void>> saveUsername(String username);

  Future<Result<UserInfo>> getUserInfo();

  Future<Result<bool>> isLogined();

  Future<Result<void>> removeAccessToken();
}
