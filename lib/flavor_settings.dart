import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

enum FlavorEnvironment {
  develop,
  production;

  String get apiBaseUrl {
    return switch (this) {
      FlavorEnvironment.develop => 'http://',
      FlavorEnvironment.production => 'https://',
    };
  }
}

@singleton
class FlavorSettings {
  FlavorSettings.development() : env = FlavorEnvironment.develop;
  FlavorSettings.production() : env = FlavorEnvironment.production;

  @FactoryMethod(preResolve: true)
  static Future<FlavorSettings> create() async {
    final String? flavor =
        await const MethodChannel('flavor').invokeMethod<String>('getFlavor');
    if (flavor == 'dev') {
      return FlavorSettings.production();
    } else if (flavor == 'prod') {
      return FlavorSettings.production();
    } else {
      throw Exception('Unknown flavor: $flavor');
    }
  }

  final FlavorEnvironment env;

  String get apiBaseUrl => env.apiBaseUrl;
}
