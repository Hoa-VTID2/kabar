import 'package:kabar/domain/repositories/auth_repository.dart';
import 'package:kabar/domain/usecases/use_case.dart';
import 'package:kabar/shared/common/result.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoveAccessTokenUseCase extends UseCase<void, void> {
  RemoveAccessTokenUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Result<void>> invoke(void param) async {
    final result = await _authRepository.removeAccessToken();
    return result;
  }
}
