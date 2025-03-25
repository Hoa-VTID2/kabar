import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  const LoginResponseModel({
    required this.isChangedPassword,
    required this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  final bool isChangedPassword;
  final String token;

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
