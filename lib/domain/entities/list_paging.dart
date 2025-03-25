import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_paging.freezed.dart';

@freezed
abstract class ListPaging<T> with _$ListPaging<T> {
  const factory ListPaging({
    required int currentPage,
    required int totalItems,
    required int totalPages,
    required List<T> data,
    String? description,
    @Default(false) bool completed,
  }) = _ListPaging<T>;
}
