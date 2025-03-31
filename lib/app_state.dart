import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/shared/common/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
abstract class AppState with _$AppState {
  const factory AppState({
    @Default(null) UserInfo? userInfo,
    @Default(false) bool isLoading,
    @Default(null) Failure? failureGetInitData,
    @Default(true) bool lightTheme,
  }) = _AppState;
}
