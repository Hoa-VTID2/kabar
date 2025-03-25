import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/domain/repositories/auth_repository.dart';
import 'package:kabar/domain/usecases/use_case.dart';
import 'package:kabar/shared/common/result.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase extends UseCase<UserInfo, LoginParam> {
  LoginUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Result<UserInfo>> invoke(LoginParam param) async {
    final result = await _authRepository.login(
      username: param.username,
      password: param.password,
    );
    return result;
  }
}

class LoginParam {
  LoginParam({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}
