import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/shared/common/result.dart';

abstract interface class AuthorRepository {
  Future<Result<List<UserInfo>>> getAuthors({String? name});
}
