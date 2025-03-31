import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kabar/app_state.dart';
import 'package:kabar/di/di.dart';
import 'package:kabar/presentation/resources/colors.dart';
import 'package:kabar/presentation/resources/themes.dart';
import 'package:kabar/presentation/router/router.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isLogined = context.read<AppState>().userInfo != null;
      if (isLogined) {
          getIt<AppRouter>().replaceAll([const HomeRoute()]);
      }
      else {
          getIt<AppRouter>().replaceAll([const LoginRoute()]);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp.router(
        routerConfig: getIt<AppRouter>().config(),
        title: 'Flutter Demo',
        theme: context.watch<AppState>().lightTheme ?AppTheme.lightTheme : AppTheme.darkTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        builder: (ctx, child) => FToastBuilder().call(
          ctx,
          SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                  child: child ?? const SizedBox(),
                ),
                Positioned.fill(
                  child: Selector<AppState, bool>(
                    selector: (_, state) => state.isLoading,
                    builder: (_, isLoading, ___) {
                      return isLoading ? _buildLoadingWidget() : const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return ColoredBox(
      color: AppColors.black.withAlpha((255.0 * 0.8).round()),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
