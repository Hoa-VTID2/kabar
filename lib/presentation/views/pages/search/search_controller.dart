import 'package:injectable/injectable.dart';
import 'package:kabar/domain/entities/news.dart';
import 'package:kabar/domain/entities/topic.dart';
import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/domain/repositories/author_repository.dart';
import 'package:kabar/domain/repositories/news_repository.dart';
import 'package:kabar/domain/repositories/topic_repository.dart';
import 'package:kabar/presentation/base/base_controller.dart';
import 'package:kabar/presentation/base/page_status.dart';
import 'package:kabar/presentation/views/pages/search/search_state.dart';

@injectable
class SearchController extends BaseController<SearchState> {
  SearchController(this.newsRepository, this.topicRepository, this.authorRepository) : super( const SearchState());
  final NewsRepository newsRepository;
  final TopicRepository topicRepository;
  final AuthorRepository authorRepository;

  @override
  Future<void> initData() async {
    final List<News> news= (await newsRepository.getNews()).data ?? [];
    final List<Topic> topics = (await topicRepository.getTopics()).data ?? [];
    final List<UserInfo> author = (await authorRepository.getAuthors()).data ?? [];
    state = state.copyWith(pageStatus: PageStatus.Loaded, news: news, authors: author, topics: topics);
  }

  @override
  SearchState createEmptyState() {
    return const SearchState();
  }
  Future<void> find(String name) async {
    state = state.copyWith(
      topics: (await topicRepository.getTopics(name: name)).data ?? [],
      authors: (await authorRepository.getAuthors(name: name)).data ?? [],
      news: (await newsRepository.getNewsByName(name: name)).data ?? [],
    );
  }

  void saveTopic(int index) {
    final List<Topic> topics = List<Topic>.from(state.topics);
    topics[index] = topics[index].copyWith(isSaved: true);
    state = state.copyWith(topics: topics);
  }
  void unSaveTopic(int index) {
    final List<Topic> topics = List<Topic>.from(state.topics);
    topics[index] = topics[index].copyWith(isSaved: false);
    state = state.copyWith(topics: topics);
  }

  void followAuthor(int index) {
    final List<UserInfo> authors = List<UserInfo>.from(state.authors);
    authors[index] = authors[index].copyWith(followed: true);
    state = state.copyWith(authors: authors);
  }
  void unFollowAuthor(int index) {
    final List<UserInfo> authors = List<UserInfo>.from(state.authors);
    authors[index] = authors[index].copyWith(followed: false);
    state = state.copyWith(authors: authors);
  }
}
