import 'package:kabar/domain/entities/topic.dart';
import 'package:kabar/shared/common/result.dart';

abstract interface class TopicRepository {
  Future<Result<List<Topic>>> getTopics({String? name});
}
