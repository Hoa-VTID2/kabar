import 'package:kabar/domain/entities/news.dart';
import 'package:kabar/domain/enum/category.dart';
import 'package:kabar/shared/common/result.dart';

abstract interface class NewsRepository {
  Future<Result<List<News>>> getNews({Category? category});
  Future<Result<List<News>>> getNewsByName({String? name});
  Result<News> getTrendNews();
}
