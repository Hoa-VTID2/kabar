import 'package:injectable/injectable.dart';
import 'package:kabar/data/datasources/local/auth_local_data_source.dart';
import 'package:kabar/data/datasources/remote/auth_remote_data_source.dart';
import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/domain/repositories/auth_repository.dart';
import 'package:kabar/domain/translator/user_info_translator.dart';
import 'package:kabar/shared/common/failure_converter.dart';
import 'package:kabar/shared/common/result.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authRemoteDataSource, this._authLocalDataSource);

  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  @override
  Future<Result<UserInfo>> login({
    required String username,
    required String password,
  }) async {
    try {
      final result = await _authRemoteDataSource.login(
        username: username,
        password: password,
      );

      // Save access token
      await _authLocalDataSource.saveAccessToken(result.token);

      final driverInfoResult = await getUserInfo();

      if (driverInfoResult.success) {
        // Save username
        await _authLocalDataSource.saveUsername(username);
      } else {
        // Remove access token
        await _authLocalDataSource.removeAccessToken();
      }

      return driverInfoResult;
    } catch (e) {
      return Result.failure(FailureConverter.convert(e));
    }
  }

  @override
  Future<Result<String?>> getUsername() async {
    final username = await _authLocalDataSource.getUsername();
    return Result.completed(username);
  }

  @override
  Future<Result<void>> saveUsername(String username) async {
    await _authLocalDataSource.saveUsername(username);
    return Result.completed(null);
  }

  @override
  Future<Result<UserInfo>> getUserInfo() async {
    try {
      final result = await _authRemoteDataSource.getUserInfo();

      final entity = UserInfoTranslator.translateToEntity(result);

      return Result.completed(entity);
    } catch (e) {
      return Result.failure(FailureConverter.convert(e));
    }
  }

  @override
  Future<Result<bool>> isLogined() async {
    final accessToken = await _authLocalDataSource.getAccessToken();
    return Result.completed(accessToken != null && accessToken.isNotEmpty);
  }

  @override
  Future<Result<void>> removeAccessToken() async {
    await _authLocalDataSource.removeAccessToken();
    return Result.completed(null);
  }
}
