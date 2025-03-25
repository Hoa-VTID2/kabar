import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/domain/enum/category.dart';

part 'news.freezed.dart';

@freezed
abstract class News with _$News{
  const factory News({
    required int id,
    required String img,
    required String topic,
    required String fullName,
    required String detail,
    required UserInfo author,
    required DateTime time,
    required Category category,
  }) = _News;
}
