import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info.freezed.dart';

@freezed
abstract class UserInfo with _$UserInfo {
  const factory UserInfo({
    required int id,
    required String fullName,
    required String image,
    required bool isAuthor,
    required int follower,
    required int following,
    String? about,
    @Default(false) bool followed,
  }) = _UserInfo;
}
