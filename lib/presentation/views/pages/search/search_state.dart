import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kabar/domain/entities/news.dart';
import 'package:kabar/domain/entities/topic.dart';
import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/presentation/base/base_state.dart';
import 'package:kabar/presentation/base/page_status.dart';

part 'search_state.freezed.dart';

@freezed
abstract class SearchState extends BaseState with _$SearchState {
  const factory SearchState({
    @Default(PageStatus.Loaded) PageStatus pageStatus,
    @Default([]) List<News> news,
    @Default([]) List<Topic> topics,
    @Default([]) List<UserInfo> authors,
  }) = _SearchState;

}
