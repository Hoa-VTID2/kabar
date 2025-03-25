import 'package:freezed_annotation/freezed_annotation.dart';

part 'topic.freezed.dart';

@freezed
abstract class Topic with _$Topic{
  const factory Topic({
    required int id,
    required String name,
    required String detail,
    required String image,
    @Default(false) bool isSaved,
  }) = _Topic;
}
