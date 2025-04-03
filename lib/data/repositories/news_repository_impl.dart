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
        detail: r'''
Ukrainian President Volodymyr Zelensky has accused European countries that continue to buy Russian oil of "earning their money in other people's blood".

In an interview with the BBC, President Zelensky singled out Germany and Hungary, accusing them of blocking efforts to embargo energy sales, from which Russia stands to make up to £250bn ($326bn) this year.

There has been a growing frustration among Ukraine's leadership with Berlin, which has backed some sanctions against Russia but so far resisted calls to back tougher action on oil sales.''',
        author: getBBC(),
        time: DateTime.now().subtract(const Duration(days: 1)),
        category: Category.sports,
        likes: 3000000,
        comments: 1500000,
        saved: true,
        liked: true,
      ),
      News(
        id: 2,
        img: Assets.images.business.path,
        topic: 'Business',
        fullName: '5 things to know before the stock market opens MondayMondayMondayMondayMondayMondayMondayMondayMondayMondayMondayMondayMonday',
        detail: r'''
Ukrainian President Volodymyr Zelensky has accused European countries that continue to buy Russian oil of "earning their money in other people's blood".

In an interview with the BBC, President Zelensky singled out Germany and Hungary, accusing them of blocking efforts to embargo energy sales, from which Russia stands to make up to £250bn ($326bn) this year.

There has been a growing frustration among Ukraine's leadership with Berlin, which has backed some sanctions against Russia but so far resisted calls to back tougher action on oil sales.''',
        author: getWilson(),
        time: DateTime.now().subtract(const Duration(hours: 1)),
        category: Category.bussiness,
        likes: 24,
        comments: 10,
        saved: true,
        liked: false,
      ),
      News(
        id: 3,
        img: Assets.images.landscape.path,
        topic: 'Europe',
        fullName: 'Russian warship: Moskva sinks in Black Sea',
        detail: r'''
Ukrainian President Volodymyr Zelensky has accused European countries that continue to buy Russian oil of "earning their money in other people's blood".

In an interview with the BBC, President Zelensky singled out Germany and Hungary, accusing them of blocking efforts to embargo energy sales, from which Russia stands to make up to £250bn ($326bn) this year.

There has been a growing frustration among Ukraine's leadership with Berlin, which has backed some sanctions against Russia but so far resisted calls to back tougher action on oil sales.''',
        author: getBBC(),
        time: DateTime.now().subtract(const Duration(hours: 1)),
        category: Category.fashion,
        likes: 24500,
        comments: 1000,
        saved: true,
        liked: true,
      ),
      News(
        id: 4,
        img: Assets.images.healthy.path,
        topic: 'Health',
        fullName: 'Healthy Living: Diet and Exercise Tips & Tools for Success.',
        detail: r'''
Ukrainian President Volodymyr Zelensky has accused European countries that continue to buy Russian oil of "earning their money in other people's blood".

In an interview with the BBC, President Zelensky singled out Germany and Hungary, accusing them of blocking efforts to embargo energy sales, from which Russia stands to make up to £250bn ($326bn) this year.

There has been a growing frustration among Ukraine's leadership with Berlin, which has backed some sanctions against Russia but so far resisted calls to back tougher action on oil sales.''',
        author: getWilson(),
        time: DateTime.now().subtract(const Duration(hours: 4)),
        category: Category.health,
        likes: 24500,
        comments: 1000,
        saved: true,
        liked: true,
      ),
      News(
        id: 5,
        img: Assets.images.landscape.path,
        topic: 'Europe',
        fullName: 'Russian warship: Moskva sinks in Black Sea',
        detail: r'''
Ukrainian President Volodymyr Zelensky has accused European countries that continue to buy Russian oil of "earning their money in other people's blood".

In an interview with the BBC, President Zelensky singled out Germany and Hungary, accusing them of blocking efforts to embargo energy sales, from which Russia stands to make up to £250bn ($326bn) this year.

There has been a growing frustration among Ukraine's leadership with Berlin, which has backed some sanctions against Russia but so far resisted calls to back tougher action on oil sales.''',
        author: getBBC(),
        time: DateTime.now().subtract(const Duration(hours: 1)),
        category: Category.politics,
        likes: 24500,
        comments: 1000,
        saved: true,
        liked: true,
      ),
      News(
        id: 6,
        img: Assets.images.bali.path,
        topic: 'Travel',
        fullName: 'Bali plans to reopen to international tourists in September',
        detail: r'''
Ukrainian President Volodymyr Zelensky has accused European countries that continue to buy Russian oil of "earning their money in other people's blood".

In an interview with the BBC, President Zelensky singled out Germany and Hungary, accusing them of blocking efforts to embargo energy sales, from which Russia stands to make up to £250bn ($326bn) this year.

There has been a growing frustration among Ukraine's leadership with Berlin, which has backed some sanctions against Russia but so far resisted calls to back tougher action on oil sales.''',
        author: getWilson(),
        time: DateTime.now().subtract(const Duration(days: 7)),
        category: Category.travel,
        likes: 24500,
        comments: 1000,
        saved: true,
        liked: true,
      ),
      News(
        id: 7,
        img: Assets.images.landscape.path,
        topic: 'Europe',
        fullName: 'Russian warship: Moskva sinks in Black Sea',
        detail:
            '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus nec venenatis lectus, et dapibus eros. Praesent id magna quis purus pharetra scelerisque ut quis felis. Duis dictum efficitur purus et blandit. Duis vel consequat dui. Nullam euismod, nisl eu fermentum convallis, arcu lectus sagittis ipsum, in elementum tortor purus vitae ligula. Mauris at enim elementum, laoreet metus sit amet, cursus orci. Sed nec elit libero. In accumsan mi non sollicitudin tincidunt. Proin molestie orci id pulvinar placerat.''',
        author: getBBC(),
        time: DateTime.now().subtract(const Duration(hours: 1)),
        category: Category.science,
        likes: 24500,
        comments: 1000,
        saved: true,
        liked: true,
      ),
      News(
        id: 8,
        img: Assets.images.nfts.path,
        topic: 'NFTs',
        fullName: 'Minting Your First NFT: A Beginner’s Guide to Creating NFT',
        detail:
            '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus nec venenatis lectus, et dapibus eros. Praesent id magna quis purus pharetra scelerisque ut quis felis. Duis dictum efficitur purus et blandit. Duis vel consequat dui. Nullam euismod, nisl eu fermentum convallis, arcu lectus sagittis ipsum, in elementum tortor purus vitae ligula. Mauris at enim elementum, laoreet metus sit amet, cursus orci. Sed nec elit libero. In accumsan mi non sollicitudin tincidunt. Proin molestie orci id pulvinar placerat.''',
        author: getWilson(),
        time: DateTime.now().subtract(const Duration(hours: 15)),
        category: Category.science,
        likes: 24500,
        comments: 1000,
        saved: true,
        liked: true,
      ),
    ];
  }

  UserInfo getBBC() {
    return UserInfo(
      id: 1,
      fullName: 'BBC News',
      image: Assets.images.bbc.path,
      isAuthor: true,
      follower: 1200000,
      followed: true,
      following: 0,
    );
  }

  UserInfo getWilson() {
    return UserInfo(
      id: 2,
      fullName: 'Wilson Franci',
      image: Assets.images.wilson.path,
      isAuthor: true,
      follower: 2156,
      followed: true,
      following: 567,
    );
  }
}
