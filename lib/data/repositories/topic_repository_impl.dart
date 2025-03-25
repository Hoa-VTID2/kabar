import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:kabar/domain/entities/topic.dart';
import 'package:kabar/domain/repositories/topic_repository.dart';
import 'package:kabar/gen/assets.gen.dart';
import 'package:kabar/presentation/resources/locale_keys.dart';
import 'package:kabar/shared/common/result.dart';

@Injectable(as: TopicRepository)
class TopicRepositoryImpl implements TopicRepository {
  @override
  Future<Result<List<Topic>>> getTopics({String? name}) async {
    if(name == null) {
      return Result.completed(getTopicsList());
    }
    else {
      return Result.completed(getTopicsList().where((element) => element.name.contains(name),).toList());
    }
  }
  List<Topic> getTopicsList(){
    return [
      Topic(id: 1, detail: 'View the latest health news and explore articles on...', name: LocaleKeys.topic_health.tr(), image: Assets.images.health.path),
      Topic(id: 2, detail: "The latest tech news about the world's best hardware...", name: LocaleKeys.topic_technology.tr(), image: Assets.images.technology.path),
      Topic(id: 3, detail: 'The Art Newspaper is the journal of record for...', name: LocaleKeys.topic_art.tr(), image: Assets.images.art.path, isSaved: true),
      Topic(id: 4, detail: ' opinion and analysis of American and global politi...', name: LocaleKeys.topic_politics.tr(), image: Assets.images.politics.path, isSaved: true),
      Topic(id: 5, detail: 'Sports news and live sports coverage including scores..', name: LocaleKeys.topic_sports.tr(), image: Assets.images.sport.path),
      Topic(id: 6, detail: 'The latest travel news on the most significant developm...', name: LocaleKeys.topic_travel.tr(), image: Assets.images.travel.path),
      Topic(id: 7, detail: 'The latest breaking financial news on the US and world...', name: LocaleKeys.topic_money.tr(), image: Assets.images.money.path),
    ];
  }
}
