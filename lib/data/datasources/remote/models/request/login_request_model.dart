import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request_model.g.dart';

@JsonSerializable()
class LoginRequestModel {
  const LoginRequestModel({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}
