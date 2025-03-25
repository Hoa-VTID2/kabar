import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<String?> getAccessToken();

  Future<void> saveAccessToken(String accessToken);

  Future<void> removeAccessToken();

  Future<String?> getUsername();

  Future<void> saveUsername(String username);

  Future<void> removeUsername();
}

@Injectable(as: AuthLocalDataSource, order: -2)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl();

  static const String accessTokenKey = 'access_token_key';
  static const String usernameKey = 'username_key';

  @override
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(accessTokenKey);
  }

  @override
  Future<void> removeAccessToken() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(accessTokenKey);
  }

  @override
  Future<void> saveAccessToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(accessTokenKey, accessToken);
  }

  @override
  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(usernameKey);
  }

  @override
  Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(usernameKey, username);
  }

  @override
  Future<void> removeUsername() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(usernameKey);
  }
}
