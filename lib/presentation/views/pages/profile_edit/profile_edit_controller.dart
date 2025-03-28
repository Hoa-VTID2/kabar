import 'package:injectable/injectable.dart';
import 'package:kabar/data/datasources/remote/auth_remote_data_source.dart';
import 'package:kabar/data/datasources/remote/models/user_info_model.dart';
import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/domain/repositories/auth_repository.dart';
import 'package:kabar/presentation/base/base_controller.dart';
import 'package:kabar/presentation/views/pages/profile_edit/profile_edit_state.dart';

@injectable
class ProfileEditController extends BaseController<ProfileEditState> {
  ProfileEditController(this.authRepository, this._authRemoteDataSource) : super(const ProfileEditState());

  final AuthRepository authRepository;
  final AuthRemoteDataSource _authRemoteDataSource;

  @override
  ProfileEditState createEmptyState() {
    return const ProfileEditState();
  }

  Future<void> initUserData() async {
    final UserInfo? user = (await authRepository.getUserInfo()).data;
    final UserInfoModel model = await _authRemoteDataSource.getUserInfo();
    if(user != null) {
      state = state.copyWith(currentUser: user,currentUserModel: model);
    }
  }

  void saveInfor(String username) {
    authRepository.saveUsername(username);
  }

  Future<String> getUsername() async{
    return (await authRepository.getUsername()).data ?? '';
  }

}
