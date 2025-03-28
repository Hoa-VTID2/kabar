import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kabar/data/datasources/remote/models/user_info_model.dart';
import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/presentation/base/base_state.dart';
import 'package:kabar/presentation/base/page_status.dart';

part 'profile_edit_state.freezed.dart';

@freezed
abstract class ProfileEditState extends BaseState with _$ProfileEditState {
  const factory ProfileEditState({
    @Default(PageStatus.Loaded) PageStatus pageStatus,
    UserInfo? currentUser,
    UserInfoModel? currentUserModel,
  }) = _ProfileEditState;
}
