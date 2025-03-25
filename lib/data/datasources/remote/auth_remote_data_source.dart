import 'package:kabar/data/datasources/remote/models/response/login_response_model.dart';
import 'package:kabar/data/datasources/remote/models/user_info_model.dart';
import 'package:kabar/data/datasources/remote/services/api_service.dart';
import 'package:kabar/shared/common/exception_converter.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login({
    required String username,
    required String password,
  });

  Future<UserInfoModel> getUserInfo();
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._apiService);

  final ApiService _apiService;

  @override
  Future<LoginResponseModel> login(
      {required String username, required String password}) async {
    try {
      // Mock
      return const LoginResponseModel(token: 'token', isChangedPassword: false);
      // return await _apiService
      //     .login(LoginRequestModel(username: username, password: password));
    } catch (e) {
      throw ExceptionConverter.convert(e);
    }
  }

  @override
  Future<UserInfoModel> getUserInfo() async {
    try {
      // Mock
      return UserInfoModel(
        userId: 1,
        address: 'address',
        dateOfBirth: '01/01/2000',
        email: 'email@example.com',
        gender: 'male',
        identifierCode: 'identifierCode',
        name: 'Test',
        phoneNumber: '0123456789',
      );

      // return await _apiService.getUserInfo();
    } catch (e) {
      throw ExceptionConverter.convert(e);
    }
  }
}
