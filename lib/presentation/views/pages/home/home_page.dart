import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kabar/gen/assets.gen.dart';
import 'package:kabar/presentation/base/base_page.dart';
import 'package:kabar/presentation/resources/colors.dart';
import 'package:kabar/presentation/resources/locale_keys.dart';
import 'package:kabar/presentation/router/router.dart';
import 'package:kabar/presentation/views/pages/home/home_controller.dart';
import 'package:kabar/presentation/views/pages/home/home_state.dart';
import 'package:kabar/presentation/views/widgets/app_bottom_navigation_bar.dart';
import 'package:kabar/shared/extensions/context_extensions.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomePage extends BasePage<HomeController, HomeState> {
  const HomePage({super.key});

  @override
  Widget builder(BuildContext context) {
    final navigationItems = _getNavigationItems();
    final routeList = navigationItems.map((e) => e.page).toList();
    final notificationRoutList = navigationItems.map((e) {
      if (e.label == LocaleKeys.bottom_nav_home.tr()) {
        return const HomeNotificationRoute();
      } else {
        return e.page;
      }
    }).toList();

    return Selector<HomeState, bool>(
        selector: (_, state) => state.isNotificationPage,
        builder: (_, isNotificationPage, __) {
          return AutoTabsScaffold(
            appBarBuilder: (context, tabsRouter) => PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: (!isNotificationPage || tabsRouter.activeIndex != 0)
                    ? const Header()
                    : const NotificationHeader()),
            routes: isNotificationPage ? notificationRoutList : routeList,
            bottomNavigationBuilder:
                (BuildContext context, TabsRouter tabsRouter) {
              return AppBottomNavigationBar(
                selectedTextStyle:
                    context.themeOwn().textTheme?.textSmall?.copyWith(
                          color: AppColors.primaryColor,
                        ),
                unSelectedTextStyle:
                    context.themeOwn().textTheme?.textSmall?.copyWith(
                          color: AppColors.subTextColor,
                        ),
                currentIndex: tabsRouter.activeIndex,
                onTap: tabsRouter.setActiveIndex,
                items: navigationItems,
              );
            },
          );
        });
  }

  List<AppBottomNavigationItem> _getNavigationItems() {
    return [
      AppBottomNavigationItem(
        label: LocaleKeys.bottom_nav_home.tr(),
        icon: SvgPicture.asset(
          Assets.icons.home.path,
          colorFilter:
              const ColorFilter.mode(AppColors.subTextColor, BlendMode.srcIn),
        ),
        selectedIcon: SvgPicture.asset(
          Assets.icons.home.path,
          colorFilter:
              const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
        ),
        page: const HomeTopRoute(),
      ),
      AppBottomNavigationItem(
        label: LocaleKeys.bottom_nav_explore.tr(),
        icon: SvgPicture.asset(Assets.icons.explore.path),
        selectedIcon: SvgPicture.asset(
          Assets.icons.explore.path,
          colorFilter:
              const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
        ),
        page: const HomeTopRoute(),
      ),
      AppBottomNavigationItem(
        label: LocaleKeys.bottom_nav_bookmark.tr(),
        icon: SvgPicture.asset(Assets.icons.bookmark.path),
        selectedIcon: SvgPicture.asset(
          Assets.icons.bookmark.path,
          colorFilter:
              const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
        ),
        page: const HomeTopRoute(),
      ),
      AppBottomNavigationItem(
        label: LocaleKeys.bottom_nav_profile.tr(),
        icon: SvgPicture.asset(Assets.icons.profile.path),
        selectedIcon: SvgPicture.asset(
          Assets.icons.profile.path,
          colorFilter:
              const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
        ),
        page: const HomeTopRoute(),
      ),
    ];
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: SizedBox(
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(Assets.images.logo99x30.path),
            Stack(
              children: [
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 0.5,
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: SvgPicture.asset(Assets.icons.notification.path),
                  iconSize: 20,
                  onPressed: () {
                    context.read<HomeController>().updateNotificationPage(true);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationHeader extends StatelessWidget {
  const NotificationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: SizedBox(
                height: 24,
                width: 24,
                child:
                    SvgPicture.asset(fit: BoxFit.none, Assets.icons.back.path)),
            onTap: () {
              context.read<HomeController>().updateNotificationPage(false);
            },
          ),
          Text(
            LocaleKeys.home_notification.tr(),
            style: context
                .themeOwn()
                .textTheme
                ?.linkMedium
                ?.copyWith(color: AppColors.black),
          ),
          InkWell(
            child: SvgPicture.asset(Assets.icons.more.path),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
