import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kabar/domain/entities/news.dart';
import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/presentation/base/base_state.dart';
import 'package:kabar/presentation/base/page_status.dart';

part 'profile_state.freezed.dart';

@freezed
abstract class ProfileState extends BaseState with _$ProfileState {
  const factory ProfileState({
    @Default(PageStatus.Loaded) PageStatus pageStatus,
    UserInfo? currentUser,
    @Default([]) List<News> userNews,
    @Default([]) List<News> recentNews,
  }) = _ProfileState;
}
