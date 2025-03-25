import 'package:injectable/injectable.dart';
import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/domain/repositories/auth_repository.dart';
import 'package:kabar/presentation/base/base_controller.dart';
import 'package:kabar/presentation/views/pages/profile/profile_state.dart';

@injectable
class ProfileController extends BaseController<ProfileState> {
  ProfileController(this.authRepository) : super(const ProfileState());
  final AuthRepository authRepository;

  @override
  ProfileState createEmptyState() {
    return const ProfileState();
  }

  Future<void> initUser() async{
    final UserInfo? user = (await authRepository.getUserInfo()).data;
    if(user != null) {
      state = state.copyWith(currentUser: user);
    }
  }
}
