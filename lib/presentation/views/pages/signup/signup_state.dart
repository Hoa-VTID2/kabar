import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kabar/presentation/base/base_state.dart';
import 'package:kabar/presentation/base/page_status.dart';

part 'signup_state.freezed.dart';

@freezed
abstract class SignupState extends BaseState with _$SignupState {
  const factory SignupState({
    @Default(PageStatus.Loaded) PageStatus pageStatus,
    @Default('') String username,
    @Default('') String password,
    @Default(null) String? usernameError,
    @Default(null) String? passwordError,
    @Default(true) bool remember
  }) = _SignupState;
}
