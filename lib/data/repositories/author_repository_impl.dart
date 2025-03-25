import 'package:injectable/injectable.dart';
import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/domain/repositories/author_repository.dart';
import 'package:kabar/gen/assets.gen.dart';
import 'package:kabar/shared/common/result.dart';

@Injectable(as: AuthorRepository)
class AuthorRepositoryImpl implements AuthorRepository {
  @override
  Future<Result<List<UserInfo>>> getAuthors({String? name}) async {
    final List<UserInfo> authors = [
      UserInfo(
        id: 1,
        fullName: 'BBC News',
        image: Assets.images.bbc.path,
        isAuthor: true,
        follower: 1200000,
        followed: true,
        following: 0,
        newsNumber: 0,
      ),
      UserInfo(
        id: 2,
        fullName: 'CNN',
        image: Assets.images.cnn.path,
        isAuthor: true,
        follower: 959000,
        following: 0,
        newsNumber: 0,
      ),
      UserInfo(
        id: 3,
        fullName: 'Vox',
        image: Assets.images.vox.path,
        isAuthor: true,
        follower: 452000,
        followed: true,
        following: 0,
        newsNumber: 0,
      ),
      UserInfo(
        id: 4,
        fullName: 'USA Today',
        image: Assets.images.usaToday.path,
        isAuthor: true,
        follower: 325000,
        followed: true,
        following: 0,
        newsNumber: 0,
      ),
      UserInfo(
        id: 5,
        fullName: 'CNBC',
        image: Assets.images.cnbc.path,
        isAuthor: true,
        follower: 21000,
        following: 0,
        newsNumber: 0,
      ),
      UserInfo(
        id: 6,
        fullName: 'CNET',
        image: Assets.images.cnet.path,
        isAuthor: true,
        follower: 18000,
        following: 0,
        newsNumber: 0,
      ),
      UserInfo(
        id: 7,
        fullName: 'MSN',
        image: Assets.images.msn.path,
        isAuthor: true,
        follower: 15000,
        following: 0,
        newsNumber: 0,
      ),
    ];
    if (name == null) {
      return Result.completed(authors);
    } else {
      return Result.completed(
          authors.where((element) => element.fullName.contains(name)).toList());
    }
  }
}
