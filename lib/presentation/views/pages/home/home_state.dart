import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kabar/presentation/base/base_state.dart';
import 'package:kabar/presentation/base/page_status.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState extends BaseState with _$HomeState {
  const factory HomeState({
    @Default(PageStatus.Loaded) PageStatus pageStatus,
    @Default(false) bool isNotificationPage,
  }) = _HomeState;
}
