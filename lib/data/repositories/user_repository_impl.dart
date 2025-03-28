import 'package:injectable/injectable.dart';
import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/domain/repositories/user_repository.dart';
import 'package:kabar/gen/assets.gen.dart';
import 'package:kabar/shared/common/result.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  @override
  Future<Result<UserInfo>> getUserById(int id) async{
    return Result.completed(getUsersList().where((element) => element.id == id,).toList().first);
  }

  @override
  Future<Result<List<UserInfo>>> getUsers() async{
    return Result.completed(getUsersList());
  }

  List<UserInfo> getUsersList() {
    return [
      UserInfo(
        id: 1,
        fullName: 'Wilson Franci', image: Assets.images.wilson.path,
        isAuthor: true,
        follower: 2156,
        following: 567,
        about: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      ),
      UserInfo(
        id: 2,
        fullName: 'Modelyn Saris',
        image: Assets.images.saris.path,
        isAuthor: false,
        follower: 10000,
        following: 0,
      ),
      UserInfo(
        id: 3,
        fullName: 'Omar Merditz',
        image: Assets.images.omar.path,
        isAuthor: true,
        follower: 10000,
        following: 0,
      ),
      UserInfo(
        id: 4,
        fullName: 'Marley Botosh',
        image: Assets.images.marley.path,
        isAuthor: true,
        follower: 10000,
        following: 0,
      ),
      UserInfo(
        id: 5,
        fullName: 'Corey Geidt',
        image: Assets.images.corey.path,
        isAuthor: true,
        follower: 10000,
        following: 0,
      ),
      UserInfo(
        id: 6,
        fullName: 'Alfonso Septimus',
        image: Assets.images.alfonso.path,
        isAuthor: true,
        follower: 10000,
        following: 0,
      ),

    ];
  }

}