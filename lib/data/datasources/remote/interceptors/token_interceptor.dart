import 'package:dio/dio.dart';
import 'package:kabar/data/datasources/local/auth_local_data_source.dart';
import 'package:injectable/injectable.dart';

@Named('token_interceptor')
@Singleton(as: Interceptor, order: -1)
class TokenInterceptor extends Interceptor {
  const TokenInterceptor(this._authLocalDataSource);

  final AuthLocalDataSource _authLocalDataSource;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _authLocalDataSource.getAccessToken();

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    super.onRequest(options, handler);
  }
}
