import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:gap/gap.dart';
import 'package:kabar/app_state.dart';
import 'package:kabar/di/di.dart';
import 'package:kabar/presentation/base/base_controller.dart';
import 'package:kabar/presentation/base/base_state.dart';
import 'package:kabar/presentation/base/page_status.dart';
import 'package:kabar/presentation/resources/locale_keys.dart';
import 'package:kabar/presentation/views/widgets/safe_click_widget.dart';
import 'package:kabar/shared/extensions/context_extensions.dart';
import 'package:provider/provider.dart';

abstract class BasePage<C extends BaseController<S>, S extends BaseState>
    extends StatefulWidget implements AutoRouteWrapper {
  const BasePage({super.key});

  Widget builder(BuildContext context);

  PreferredSizeWidget? appBarBuilder(BuildContext context) => null;

  Widget? pageBuilder(BuildContext context, Widget body) => null;

  void onInitState(BuildContext context) {}

  void onDispose() {}

  C buildController(BuildContext context) => getIt<C>();

  @override
  Widget wrappedRoute(BuildContext context) {
    return StateNotifierProvider<C, S>(
      create: (BuildContext context) => buildController(context),
      child: this,
    );
  }

  @override
  State<BasePage<C, S>> createState() => BasePageState<C, S>();

  void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

class BasePageState<C extends BaseController<S>, S extends BaseState>
    extends State<BasePage<C, S>> {
  @override
  void initState() {
    context.read<C>().initData();
    widget.onInitState(context);
    super.initState();
  }

  @override
  void dispose() {
    widget.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('BasePage:build');
    }
    return Selector<S, PageStatus>(
      shouldRebuild: (previous, next) {
        if (kDebugMode) {
          print(
              'pre: $previous, next: $next --> should rebuild: ${previous != next}');
        }
        return previous != next;
      },
      builder: (_, pageStatus, __) {
        final contentWidget = switch (pageStatus) {
          PageStatus.Uninitialized => const _LoadingPage(),
          PageStatus.Loaded => GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: widget.builder(context),
            ),
          PageStatus.Error => _ErrorPage(
              onRetry: () {
                context.read<C>().retry();
              },
            ),
        };

        return Selector<AppState, bool>(
          selector: (_, state) => state.isLoading,
          builder: (_, isLoading, child) {
            return PopScope(
              canPop: !isLoading,
              child: child ?? const SizedBox(),
            );
          },
          child: widget.pageBuilder(context, contentWidget) ??
              Scaffold(
                  appBar: widget.appBarBuilder(context), body: contentWidget),
        );
      },
      selector: (_, state) => state.pageStatus,
    );
  }
}

class _ErrorPage<C extends BaseController> extends StatelessWidget {
  const _ErrorPage({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colorSchema = context.themeOwn().colorSchema;

    return Center(
      child: SafeClickWidget(
        onPressed: () {
          onRetry.call();
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.refresh,
              size: 48,
              color: colorSchema?.primary,
            ),
            const Gap(8),
            Text(
              LocaleKeys.common_reload.tr(),
              style: context
                  .themeOwn()
                  .textTheme
                  ?.textLarge
                  ?.copyWith(color: colorSchema?.primary),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingPage extends StatelessWidget {
  const _LoadingPage();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
