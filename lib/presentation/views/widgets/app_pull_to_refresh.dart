import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:kabar/presentation/resources/colors.dart';
import 'package:kabar/presentation/resources/locale_keys.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppPullToRefresh extends StatelessWidget {
  const AppPullToRefresh({
    super.key,
    required this.refreshController,
    required this.child,
    this.enablePullDown = true,
    this.enablePullUp = true,
    this.header,
    this.onRefresh,
    this.onLoadMore,
    this.scrollController,
  });

  final RefreshController refreshController;
  final ScrollController? scrollController;
  final bool enablePullDown;
  final bool enablePullUp;
  final Widget? header;
  final Widget child;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoadMore;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      physics: const ClampingScrollPhysics(),
      controller: refreshController,
      enablePullDown: enablePullDown,
      enablePullUp: enablePullUp,
      scrollController: scrollController,
      header: header ??
          WaterDropHeader(
            waterDropColor: AppColors.primaryColor,
            complete: Text(LocaleKeys.list_view_refresh_complete.tr()),
            failed: Text(LocaleKeys.list_view_refresh_fail.tr()),
          ),
      footer: CustomFooter(
        builder: (context, mode) {
          Widget body;
          if (mode != LoadStatus.noMore) {
            body = const CupertinoActivityIndicator();
          } else {
            body = const SizedBox();
          }
          return SizedBox(
            height: 55.0,
            child: Center(
              child: body,
            ),
          );
        },
      ),
      onRefresh: onRefresh,
      onLoading: onLoadMore,
      child: child,
    );
  }
}
