import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kabar/data/datasources/remote/models/response/error_response_mode.dart';
import 'package:injectable/injectable.dart';

@Named('response_parser_interceptor')
@Singleton(as: Interceptor, order: -1)
class ResponseParserInterceptor extends Interceptor {
  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    try {
      final Map<String, dynamic> valueMap;
      if (response.data is String) {
        valueMap = jsonDecode(response.data as String) as Map<String, dynamic>;
      } else {
        valueMap = response.data as Map<String, dynamic>;
      }
      final typeSuccess = valueMap['type'] as String;
      final success = typeSuccess == 'ok';
      if (success) {
        final data = valueMap['data'];
        if (data != null) {
          if (data is List) {
            final metaData = valueMap['meta'] as Map<String, dynamic>?;
            if (metaData != null) {
              response.data = {
                ...metaData,
                'data': data,
              };
            } else {
              response.data = data;
            }
          } else {
            response.data = data;
          }
        } else {
          response.data = null;
        }
        return handler.next(response);
      } else {
        final code = valueMap['code'] as String?;
        final message = valueMap['message'] as String?;
        return handler.reject(
          DioException(
            requestOptions: response.requestOptions,
            error: ErrorResponseModel(
              httpCode: response.statusCode,
              code: code,
              message: message,
            ),
          ),
        );
      }
    } catch (error) {
      return handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          error: ErrorResponseModel(
            httpCode: response.statusCode,
          ),
        ),
      );
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    if (response != null) {
      try {
        final valueMap = response.data as Map<String, dynamic>;
        final code = valueMap['code'] as String;
        final message = valueMap['message'] as String;
        return handler.next(err.copyWith(
          error: ErrorResponseModel(
            httpCode: response.statusCode,
            code: code,
            message: message,
          ),
        ));
      } catch (error) {
        return handler.next(err);
      }
    } else {
      return handler.next(err);
    }
  }
}
