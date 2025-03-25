import 'package:dio/dio.dart';
import 'package:kabar/data/datasources/remote/models/request/login_request_model.dart';
import 'package:kabar/data/datasources/remote/models/response/login_response_model.dart';
import 'package:kabar/data/datasources/remote/models/user_info_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // Authenticate
  @POST('/api/login')
  Future<LoginResponseModel> login(@Body() LoginRequestModel loginRequest);

  @GET('/api/user-info')
  Future<UserInfoModel> getUserInfo();
}
