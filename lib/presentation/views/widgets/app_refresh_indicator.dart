import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kabar/presentation/resources/colors.dart';
import 'package:kabar/shared/extensions/context_extensions.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppRefreshIndicator extends StatefulWidget {
  const AppRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  final Widget child;
  final Future<void> Function() onRefresh;

  @override
  State<AppRefreshIndicator> createState() => _AppRefreshIndicatorState();
}

class _AppRefreshIndicatorState extends State<AppRefreshIndicator> {
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      header: WaterDropHeader(
        waterDropColor: context.colorOwn()?.primary ?? AppColors.primaryColor,
        complete: const SizedBox(),
        completeDuration: Duration.zero,
      ),
      controller: _refreshController,
      onRefresh: () async {
        await widget.onRefresh();
        _refreshController.refreshCompleted();
      },
      child: widget.child,
    );
  }
}
