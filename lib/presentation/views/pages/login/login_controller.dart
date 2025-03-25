import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:kabar/app_controller.dart';
import 'package:kabar/domain/usecases/get_username_use_case.dart';
import 'package:kabar/domain/usecases/login_use_case.dart';
import 'package:kabar/presentation/base/base_controller.dart';
import 'package:kabar/presentation/base/page_status.dart';
import 'package:kabar/presentation/resources/locale_keys.dart';
import 'package:kabar/presentation/views/pages/login/login_state.dart';
import 'package:kabar/shared/common/error_handler.dart';

@injectable
class LoginController extends BaseController<LoginState> {
  LoginController(
    this._appController,
    this._loginUseCase,
    this._getUsernameUseCase,
  ) : super(const LoginState());

  final AppController _appController;
  final LoginUseCase _loginUseCase;
  final GetUsernameUseCase _getUsernameUseCase;

  @override
  Future<void> initData() async {
    final result = await _getUsernameUseCase.invoke(null);
    String username = '';
    if (result.success) {
      username = result.data ?? '';
    }
    state = state.copyWith(pageStatus: PageStatus.Loaded, username: username);
  }

  void updateUsername(String username) {
    state = state.copyWith(username: username, usernameError: null);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password, passwordError: null);
  }

  void updateRemember(bool remember) {
    state = state.copyWith(remember: remember);
  }

  Future<bool> login() async {
    _appController.showLoading();
    bool isValid = true;
    String? usernameError;
    String? passwordError;

    if (state.username.trim().isEmpty) {
      usernameError = LocaleKeys.login_username_null_error.tr();
      isValid = false;
    }
    if (state.password.trim().isEmpty) {
      passwordError = LocaleKeys.login_password_null_error.tr();
      isValid = false;
    }
    state = state.copyWith(usernameError: usernameError, passwordError: passwordError);
    final param = LoginParam(
      username: state.username,
      password: state.password,
    );

    if(!isValid) {
      return false;
    }

    final loginResult = await _loginUseCase.invoke(param);

    if (!loginResult.success) {
      _appController.hideLoading();
      ErrorHandler.handle(loginResult.failure);
      return false;
    }

    if (loginResult.data != null) {
      _appController.setUserInfo(loginResult.data!);
    }

    _appController.hideLoading();
    return true;
  }

  @override
  LoginState createEmptyState() {
    return const LoginState();
  }
}
