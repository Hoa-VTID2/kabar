import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/domain/repositories/auth_repository.dart';
import 'package:kabar/domain/usecases/use_case.dart';
import 'package:kabar/shared/common/result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserInfoUseCase extends UseCase<UserInfo, void> {
  GetUserInfoUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Result<UserInfo>> invoke(void param) async {
    final result = await _authRepository.getUserInfo();
    return result;
  }
}
