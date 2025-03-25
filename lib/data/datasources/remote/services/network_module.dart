import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:kabar/data/datasources/remote/services/api_service.dart';
import 'package:kabar/flavor_settings.dart';
import 'package:kabar/shared/extensions/int_extensions.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class NetworkModule {
  Interceptor get loggingInterceptor => PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        compact: false,
        maxWidth: 150,
        logPrint: (o) => debugPrint('API $o'),
      );

  @singleton
  Dio getDio(
    @Named('connectivity_interceptor') Interceptor connectivityInterceptor,
    @Named('token_interceptor') Interceptor tokenInterceptor,
    @Named('response_parser_interceptor') Interceptor responseParserInterceptor,
  ) {
    final dio = Dio(
      BaseOptions(
        connectTimeout: 5.seconds,
        receiveTimeout: 120.seconds,
      ),
    )..interceptors.addAll([
        connectivityInterceptor,
        tokenInterceptor,
        responseParserInterceptor,
      ]);

    if (kDebugMode) {
      dio.interceptors.add(loggingInterceptor);
    }
    return dio;
  }

  @singleton
  ApiService getApiService(Dio dio, FlavorSettings settings) =>
      ApiService(dio, baseUrl: settings.apiBaseUrl);
}
