import 'package:injectable/injectable.dart';
import 'package:kabar/domain/entities/news.dart';
import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/domain/enum/category.dart';
import 'package:kabar/domain/repositories/news_repository.dart';
import 'package:kabar/gen/assets.gen.dart';
import 'package:kabar/shared/common/result.dart';

@Injectable(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  @override
  Future<Result<List<News>>> getNews({Category? category}) async {
    if (category == null) {
      return Result.completed(getNewsList());
    } else {
      return Result.completed(
          getNewsList().where((n) => n.category == category).toList());
    }
  }

  @override
  Future<Result<List<News>>> getNewsByName({String? name}) async {
    if (name == null) {
      return Result.completed(getNewsList());
    } else {
      return Result.completed(
          getNewsList().where((n) => n.fullName.contains(name)).toList());
    }
  }

  @override
  Result<News> getTrendNews() {
    return Result.completed(getNewsList().first);
  }

  List<News> getNewsList() {
    return [
      News(
        id: 1,
        img: Assets.images.landscape.path,
        topic: 'Europe',
        fullName: 'Russian warship: Moskva sinks in Black Sea',
        detail:
            r'''
Ukrainian President Volodymyr Zelensky has accused European countries that continue to buy Russian oil of "earning their money in other people's blood".

In an interview with the BBC, President Zelensky singled out Germany and Hungary, accusing them of blocking efforts to embargo energy sales, from which Russia stands to make up to £250bn ($326bn) this year.

There has been a growing frustration among Ukraine's leadership with Berlin, which has backed some sanctions against Russia but so far resisted calls to back tougher action on oil sales.''',
        author: getBBC(),
        time: DateTime.now().subtract(const Duration(days: 1)),
        category: Category.sports,
      ),
      News(
        id: 1,
        img: Assets.images.landscape.path,
        topic: 'Europe',
        fullName: 'Russian warship: Moskva sinks in Black Sea',
        detail:
            r'''
Ukrainian President Volodymyr Zelensky has accused European countries that continue to buy Russian oil of "earning their money in other people's blood".

In an interview with the BBC, President Zelensky singled out Germany and Hungary, accusing them of blocking efforts to embargo energy sales, from which Russia stands to make up to £250bn ($326bn) this year.

There has been a growing frustration among Ukraine's leadership with Berlin, which has backed some sanctions against Russia but so far resisted calls to back tougher action on oil sales.''',
        author: getBBC(),
        time: DateTime.now().subtract(const Duration(minutes: 14)),
        category: Category.bussiness,
      ),
      News(
        id: 1,
        img: Assets.images.landscape.path,
        topic: 'Europe',
        fullName: 'Russian warship: Moskva sinks in Black Sea',
        detail:
            r'''
Ukrainian President Volodymyr Zelensky has accused European countries that continue to buy Russian oil of "earning their money in other people's blood".

In an interview with the BBC, President Zelensky singled out Germany and Hungary, accusing them of blocking efforts to embargo energy sales, from which Russia stands to make up to £250bn ($326bn) this year.

There has been a growing frustration among Ukraine's leadership with Berlin, which has backed some sanctions against Russia but so far resisted calls to back tougher action on oil sales.''',
        author: getBBC(),
        time: DateTime.now().subtract(const Duration(hours: 1)),
        category: Category.fashion,
      ),
      News(
        id: 1,
        img: Assets.images.landscape.path,
        topic: 'Europe',
        fullName: 'Russian warship: Moskva sinks in Black Sea',
        detail:
            r'''
Ukrainian President Volodymyr Zelensky has accused European countries that continue to buy Russian oil of "earning their money in other people's blood".

In an interview with the BBC, President Zelensky singled out Germany and Hungary, accusing them of blocking efforts to embargo energy sales, from which Russia stands to make up to £250bn ($326bn) this year.

There has been a growing frustration among Ukraine's leadership with Berlin, which has backed some sanctions against Russia but so far resisted calls to back tougher action on oil sales.''',
        author: getBBC(),
        time: DateTime.now().subtract(const Duration(hours: 1)),
        category: Category.health,
      ),
      News(
        id: 1,
        img: Assets.images.landscape.path,
        topic: 'Europe',
        fullName: 'Russian warship: Moskva sinks in Black Sea',
        detail:
            r'''
Ukrainian President Volodymyr Zelensky has accused European countries that continue to buy Russian oil of "earning their money in other people's blood".

In an interview with the BBC, President Zelensky singled out Germany and Hungary, accusing them of blocking efforts to embargo energy sales, from which Russia stands to make up to £250bn ($326bn) this year.

There has been a growing frustration among Ukraine's leadership with Berlin, which has backed some sanctions against Russia but so far resisted calls to back tougher action on oil sales.''',
        author: getBBC(),
        time: DateTime.now().subtract(const Duration(hours: 1)),
        category: Category.politics,
      ),
      News(
        id: 1,
        img: Assets.images.landscape.path,
        topic: 'Europe',
        fullName: 'Russian warship: Moskva sinks in Black Sea',
        detail:
            r'''
Ukrainian President Volodymyr Zelensky has accused European countries that continue to buy Russian oil of "earning their money in other people's blood".

In an interview with the BBC, President Zelensky singled out Germany and Hungary, accusing them of blocking efforts to embargo energy sales, from which Russia stands to make up to £250bn ($326bn) this year.

There has been a growing frustration among Ukraine's leadership with Berlin, which has backed some sanctions against Russia but so far resisted calls to back tougher action on oil sales.''',
        author: getBBC(),
        time: DateTime.now().subtract(const Duration(hours: 1)),
        category: Category.travel,
      ),
      News(
        id: 1,
        img: Assets.images.landscape.path,
        topic: 'Europe',
        fullName: 'Russian warship: Moskva sinks in Black Sea',
        detail: '''''',
        author: getBBC(),
        time: DateTime.now().subtract(const Duration(hours: 1)),
        category: Category.science,
      ),
    ];
  }

  UserInfo getBBC() {
    return UserInfo(
        id: 1,
        fullName: 'BBC News',
        image: Assets.images.bbc.path,
        isAuthor: true,
        follower: 10000,
        followed: true,
        following: 0,
        newsNumber: 0,
    );
  }
}
