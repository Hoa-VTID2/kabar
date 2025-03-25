import 'package:kabar/shared/common/result.dart';

abstract class UseCase<ReturnType, Param> {
  Future<Result<ReturnType>> invoke(Param param);
}
