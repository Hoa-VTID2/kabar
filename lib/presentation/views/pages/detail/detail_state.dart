import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kabar/domain/entities/news.dart';
import 'package:kabar/presentation/base/base_state.dart';
import 'package:kabar/presentation/base/page_status.dart';

part 'detail_state.freezed.dart';

@freezed
abstract class DetailState extends BaseState with _$DetailState {
  const factory DetailState({
    @Default(PageStatus.Loaded) PageStatus pageStatus,
    News? news,
  }) = _DetailState;
}
