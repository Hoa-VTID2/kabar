import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_model.g.dart';

@JsonSerializable()
class UserInfoModel {
  UserInfoModel({
    required this.userId,
    required this.address,
    required this.dateOfBirth,
    required this.email,
    required this.gender,
    required this.identifierCode,
    required this.name,
    required this.phoneNumber,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);

  final int userId;
  final String? address;
  final String dateOfBirth;
  final String email;
  final String gender;
  final String identifierCode;
  final String name;
  final String phoneNumber;

  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);
}
