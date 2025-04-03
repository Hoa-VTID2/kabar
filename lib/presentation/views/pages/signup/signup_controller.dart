import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:kabar/app_controller.dart';
import 'package:kabar/presentation/base/base_controller.dart';
import 'package:kabar/presentation/resources/locale_keys.dart';
import 'package:kabar/presentation/views/pages/signup/signup_state.dart';

@injectable
class SignupController extends BaseController<SignupState> {
  SignupController(
      this._appController,
      ) : super(const SignupState());

  final AppController _appController;

  Future<bool> signup() async {
    bool isValid = true;
    String? usernameError;
    String? passwordError;

    if (state.username.trim().isEmpty || state.username.length <3) {
      usernameError = LocaleKeys.login_username_null_error.tr();
      isValid = false;
    }
    if (state.password.trim().isEmpty) {
      passwordError = LocaleKeys.login_password_null_error.tr();
      isValid = false;
    }
    state = state.copyWith(usernameError: usernameError, passwordError: passwordError);
    if (!isValid) {
      return false;
    }
    return true;
  }

  void updateUserName(String username) {
    state = state.copyWith(username: username, usernameError: null);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password, passwordError: null);
  }

  void updateRemember(bool remember) {
    state = state.copyWith(remember: remember);
  }

  @override
  SignupState createEmptyState() {
    return const SignupState();
  }
}
