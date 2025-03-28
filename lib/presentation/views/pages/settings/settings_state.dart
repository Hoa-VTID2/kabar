import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kabar/presentation/base/base_state.dart';
import 'package:kabar/presentation/base/page_status.dart';

part 'settings_state.freezed.dart';

@freezed
abstract class SettingsState extends BaseState with _$SettingsState {
  const factory SettingsState({
    @Default(PageStatus.Loaded) PageStatus pageStatus,
    @Default(false) bool darkMode,
  }) = _SettingsState;
}
