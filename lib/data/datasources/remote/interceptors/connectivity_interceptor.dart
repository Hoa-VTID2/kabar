import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Named('connectivity_interceptor')
@Singleton(as: Interceptor)
class ConnectivityInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final isConnected = await checkInternetConnectionAndCallAPI();
    if (isConnected) {
      handler.next(options);
    } else {
      handler.reject(DioException(
        message: 'No Internet Connection',
        type: DioExceptionType.connectionError,
        requestOptions: options,
      ));
    }
  }
}

Future<bool> checkInternetConnectionAndCallAPI() async {
  final connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult.contains(ConnectivityResult.none)) {
    // No Internet Connection
    return false;
  } else {
    return true;
  }
}
