import 'package:injectable/injectable.dart';
import 'package:kabar/app_state.dart';
import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/domain/usecases/check_logined_use_case.dart';
import 'package:kabar/domain/usecases/get_user_info_use_case.dart';
import 'package:kabar/domain/usecases/remove_access_token_use_case.dart';
import 'package:state_notifier/state_notifier.dart';

@singleton
class AppController extends StateNotifier<AppState> {
  AppController(
    this._checkLoginedUseCase,
    this._getUserInfoUseCase,
    this._removeAccessTokenUseCase,
  ) : super(const AppState());

  final CheckLoginedUseCase _checkLoginedUseCase;
  final GetUserInfoUseCase _getUserInfoUseCase;
  final RemoveAccessTokenUseCase _removeAccessTokenUseCase;

  void setUserInfo(UserInfo userInfo) {
    if (mounted) {
      state = state.copyWith(
        userInfo: userInfo,
      );
    }
  }

  void showLoading() {
    if (mounted) {
      state = state.copyWith(isLoading: true);
    }
  }

  void hideLoading() {
    if (mounted) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> clearAllData() async {
    await _removeAccessTokenUseCase.invoke(null);
    if (mounted) {
      state = const AppState();
    }
  }

  Future<bool> _isLogined() async {
    final result = await _checkLoginedUseCase.invoke(null);
    return result.data ?? false;
  }

  Future<void> getInitData() async {
    final isLogined = await _isLogined();
    if (!isLogined) {
      return;
    }

    // Get user info
    final userInfoResult = await _getUserInfoUseCase.invoke(null);
    if (!userInfoResult.success) {
      // Remove access token
      await _removeAccessTokenUseCase.invoke(null);
      // Save error to show after
      state = state.copyWith(failureGetInitData: userInfoResult.failure);
      return;
    }

    // Save user info
    if (userInfoResult.data != null) {
      setUserInfo(userInfoResult.data!);
    }
  }

  void removeErrorInitDataApp() {
    if (mounted) {
      state = state.copyWith(failureGetInitData: null);
    }
  }

  void logout() {
    state = state.copyWith(userInfo: null);
  }

  void updateTheme(bool lighTheme) {
    state = state.copyWith(lightTheme: lighTheme);
  }
}
