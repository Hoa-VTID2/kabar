import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kabar/domain/enum/fetch_status.dart';
import 'package:kabar/presentation/resources/locale_keys.dart';
import 'package:kabar/presentation/views/widgets/app_pull_to_refresh.dart';
import 'package:kabar/shared/extensions/widget_extensions.dart';
import 'package:gap/gap.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppListView<T> extends StatefulWidget {
  const AppListView({
    super.key,
    required this.data,
    this.padding = EdgeInsets.zero,
    this.refreshController,
    this.onRefresh,
    this.onLoadMore,
    this.emptyMessage,
    required this.builder,
    this.separatorBuilder,
    this.enablePullDown = true,
    this.enablePullUp = true,
    this.paddingLoadingView = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 24,
    ),
    this.fetchStatus = FetchStatus.initing,
    this.controller,
  });

  final List<T> data;
  final EdgeInsets padding;
  final RefreshController? refreshController;
  final ScrollController? controller;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoadMore;
  final String? emptyMessage;
  final Widget Function(T data, int index) builder;
  final IndexedWidgetBuilder? separatorBuilder;
  final bool enablePullDown;
  final bool enablePullUp;
  final EdgeInsets paddingLoadingView;
  final FetchStatus fetchStatus;

  @override
  State<AppListView<T>> createState() => _AppListViewState<T>();
}

class _AppListViewState<T> extends State<AppListView<T>> {
  late RefreshController _refreshController;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = widget.controller ?? ScrollController();
    _refreshController = widget.refreshController ?? RefreshController();
    _refreshController.refresh(widget.fetchStatus);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AppListView<T> oldWidget) {
    if (oldWidget.fetchStatus != widget.fetchStatus) {
      _refreshController.refresh(widget.fetchStatus);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      child: AppPullToRefresh(
        refreshController: _refreshController,
        onRefresh: widget.onRefresh,
        onLoadMore: widget.onLoadMore,
        enablePullUp: widget.enablePullUp,
        enablePullDown: widget.enablePullDown,
        scrollController: _scrollController,
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (widget.fetchStatus == FetchStatus.initing) {
      return const Padding(
        padding: EdgeInsets.only(top: 24),
        child: CupertinoActivityIndicator(),
      );
    } else if ((widget.fetchStatus == FetchStatus.noMoreData ||
            widget.fetchStatus == FetchStatus.refreshCompleted ||
            widget.fetchStatus == FetchStatus.refreshFailed) &&
        widget.data.isEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(40),
          Text(widget.emptyMessage ?? LocaleKeys.list_view_no_data.tr()),
        ],
      );
    }
    return ListView.separated(
      controller: _scrollController,
      itemCount: widget.data.length,
      padding: widget.padding,
      separatorBuilder:
          widget.separatorBuilder ?? (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return widget.builder(widget.data[index], index);
      },
    );
  }
}
