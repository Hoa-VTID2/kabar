import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:kabar/app_controller.dart';
import 'package:kabar/app_state.dart';
import 'package:kabar/domain/entities/news.dart';
import 'package:kabar/domain/entities/notification.dart';
import 'package:kabar/domain/enum/action.dart';
import 'package:kabar/domain/enum/category.dart';
import 'package:kabar/gen/assets.gen.dart';
import 'package:kabar/presentation/base/base_page.dart';
import 'package:kabar/presentation/resources/colors.dart';
import 'package:kabar/presentation/resources/locale_keys.dart';
import 'package:kabar/presentation/router/router.dart';
import 'package:kabar/presentation/views/pages/home_top/home_top_controller.dart';
import 'package:kabar/presentation/views/pages/home_top/home_top_state.dart';
import 'package:kabar/presentation/views/widgets/app_button.dart';
import 'package:kabar/presentation/views/widgets/news_card/big_news_card.dart';
import 'package:kabar/presentation/views/widgets/news_card/news_card.dart';
import 'package:kabar/presentation/views/widgets/text_field/app_text_field.dart';
import 'package:kabar/shared/common/error_handler.dart';
import 'package:kabar/shared/extensions/context_extensions.dart';
import 'package:kabar/shared/extensions/datetime_extensions.dart';
import 'package:kabar/shared/extensions/string_extensions.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomeTopPage extends BasePage<HomeTopController, HomeTopState> {
  const HomeTopPage({super.key});

  @override
  void onInitState(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Show error when init app
      final failureGetInitData = context.read<AppState>().failureGetInitData;
      if (failureGetInitData != null) {
        ErrorHandler.showError(context, failureGetInitData);
        context.read<AppController>().removeErrorInitDataApp();
      }
    });
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return Selector<HomeTopState, bool>(
        selector: (_, state) => state.isNotificationPage,
        builder: (context, isNotificationPage, child) {
          return Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: isNotificationPage
                  ? const Notification()
                  : Content(context: context));
        });
  }
}

class Content extends StatefulWidget {
  const Content({super.key, required this.context});

  final BuildContext context;

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Category> categories;

  List<Category> _getCategoies() {
    const List<Category> categories = Category.values;
    return categories;
  }

  @override
  void initState() {
    super.initState();
    categories = _getCategoies();
    _tabController = TabController(length: categories.length, vsync: this);
    _tabController.addListener(_onTabChanged);
    context.read<HomeTopController>().getTopicNews();
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      return;
    }

    final selectedCategory = categories[_tabController.index];

    if (selectedCategory == Category.all) {
      context.read<HomeTopController>().getTopicNews();
    } else {
      context
          .read<HomeTopController>()
          .getTopicNews(category: selectedCategory);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async {
        await Future.delayed(const Duration(milliseconds: 500));
        context.read<HomeTopController>().getTopicNews();
      },
      child: Stack(
        children: [
          const Positioned(top: 0, left: 0, right: 0, child: Header()),
          Positioned(
            top: 72,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Column(
                spacing: 16,
                children: [
                  AppTextField(
                    onTap: () {
                      context.router.replaceAll([const SearchRoute()]);
                    },
                    hint: LocaleKeys.home_search.tr(),
                    prefixIcon: SvgPicture.asset(Assets.icons.search.path),
                    suffixIcon: InkWell(
                      child: SvgPicture.asset(Assets.icons.customize.path),
                      onTap: () {
                        context.router.replaceAll([const SearchRoute()]);
                      },
                    ),
                  ),
                  Column(
                    spacing: 16,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(LocaleKeys.home_trending.tr(),
                              style: context.themeOwn().textTheme?.linkMedium),
                          Text(LocaleKeys.home_see_all.tr(),
                              style: context
                                  .themeOwn()
                                  .textTheme
                                  ?.textSmall
                                  ?.copyWith(color: AppColors.subTextColor))
                        ],
                      ),
                      BigNewsCard(
                        news: context.read<HomeTopController>().getTrendNews(),
                        pageRouteInfo: const HomeRoute(),
                      ),
                      Column(
                        spacing: 16,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(LocaleKeys.home_latest.tr(),
                                  style:
                                      context.themeOwn().textTheme?.linkMedium),
                              Text(LocaleKeys.home_see_all.tr(),
                                  style: context
                                      .themeOwn()
                                      .textTheme
                                      ?.textSmall
                                      ?.copyWith(color: AppColors.subTextColor))
                            ],
                          ),
                          DefaultTabController(
                            length: categories.length,
                            child: Column(
                              children: [
                                TabBar(
                                  controller: _tabController,
                                  tabAlignment: TabAlignment.start,
                                  isScrollable: true,
                                  padding: EdgeInsets.zero,
                                  labelPadding:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  dividerColor: Colors.transparent,
                                  tabs: categories
                                      .map((c) => Tab(
                                            height: 34,
                                            child: Text(
                                              tr(LocaleKeys.topic,
                                                  gender: c.name),
                                            ),
                                          ))
                                      .toList(),
                                  labelStyle: context
                                      .themeOwn()
                                      .textTheme
                                      ?.textMedium
                                      ?.copyWith(color: AppColors.black),
                                  labelColor: AppColors.black,
                                  unselectedLabelStyle: context
                                      .themeOwn()
                                      .textTheme
                                      ?.textMedium
                                      ?.copyWith(color: AppColors.subTextColor),
                                  unselectedLabelColor: AppColors.subTextColor,
                                  indicator: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: AppColors.primaryColor,
                                          width: 2),
                                    ),
                                  ),
                                ),
                                const Gap(16),
                                Selector<HomeTopState, List<News>>(
                                    selector: (_, state) => state.news,
                                    builder: (_, newsList, __) {
                                      final news = newsList;
                                      final displayedNews = news.length > 5
                                          ? news.sublist(0, 5)
                                          : news;
                                      return SizedBox(
                                        height: (displayedNews.length+1)*(96+16)-48,
                                        child: TabBarView(
                                            controller: _tabController,
                                            children: categories
                                                .map<Widget>((c) => Column(
                                                      spacing: 16,
                                                      children: List.generate(
                                                        displayedNews.length,
                                                        (index) {
                                                          return NewsCard(
                                                            news: displayedNews[
                                                                index],
                                                            pageRouteInfo:
                                                                const HomeRoute(),
                                                          );
                                                        },
                                                      ),
                                                    ))
                                                .toList()),
                                      );
                                    }),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Notification extends StatefulWidget {
  const Notification({super.key});

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async {
        await Future.delayed(const Duration(milliseconds: 500));
        context.read<HomeTopController>().getAllNotifications();
      },
      child: Stack(
        children: [
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NotificationHeader(),
          ),
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Consumer<HomeTopState>(builder: (_, state, __) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    for (final day in state.sendTimes) ...[
                      Text(
                        day.formatLocalized(context: context),
                        style: context.themeOwn().textTheme?.linkMedium,
                      ),
                      ...state.notifications
                          .where((n) => n.sendAt.dateOnly == day.dateOnly)
                          .map((n) => normalNotification(n, context)),
                    ],
                    const Gap(16),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget normalNotification(
      NotificationItem notificationItem, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.secondaryBackgroundColors,
      ),
      padding: const EdgeInsets.fromLTRB(8, 14, 8, 14),
      child: Row(
        spacing: 16,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(70),
            child: Image.asset(
                height: 70,
                width: 70,
                fit: BoxFit.none,
                notificationItem.creator.image),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 3,
              children: [
                RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: notificationItem.creator.fullName,
                        style: context.themeOwn().textTheme?.linkMedium,
                      ),
                      TextSpan(
                        text:
                            '''${ActionDetail[notificationItem.action]}${notificationItem.newsTopic ?? ''} ${notificationItem.newsName.quoted() ?? ''}''',
                        style: context.themeOwn().textTheme?.textMedium,
                      )
                    ],
                  ),
                ),
                Text(
                  notificationItem.sendAt.getTimeAgo,
                  style: context
                      .themeOwn()
                      .textTheme
                      ?.textXSmall
                      ?.copyWith(color: AppColors.subTextColor),
                )
              ],
            ),
          ),
          if (notificationItem.action == UserAction.follow)
            if (!notificationItem.creator.followed)
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    padding: const EdgeInsets.fromLTRB(8, 4, 7, 4),
                    side: const BorderSide(color: AppColors.primaryColor),
                  ),
                  onPressed: () {
                    context
                        .read<HomeTopController>()
                        .followUser(notificationItem.creator.fullName);
                  },
                  child: Row(
                    spacing: 4,
                    children: [
                      SvgPicture.asset(Assets.icons.plus.path),
                      Text(
                        LocaleKeys.search_follow.tr(),
                        style: context
                            .themeOwn()
                            .textTheme
                            ?.linkMedium
                            ?.copyWith(color: AppColors.primaryColor),
                      )
                    ],
                  ))
            else
              AppButton(
                padding: const EdgeInsets.fromLTRB(13, 5, 13, 5),
                backgroundColor: AppColors.primaryColor,
                child: Text(
                  LocaleKeys.search_following.tr(),
                  style: context
                      .themeOwn()
                      .textTheme
                      ?.linkMedium
                      ?.copyWith(color: AppColors.white),
                ),
                onPressed: () {
                  context
                      .read<HomeTopController>()
                      .unFollowUser(notificationItem.creator.fullName);
                },
              )
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(Assets.images.logo99x30.path),
          InkWell(
            child: Container(
              padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Assets.icons.notification.svg(
                height: 22,
                width: 18,
              ),
            ),
            // iconSize: 20,
            onTap: () {
              context.read<HomeTopController>().updateNotificationPage(true);
            },
          ),
        ],
      ),
    );
  }
}

class NotificationHeader extends StatelessWidget {
  const NotificationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          child: SizedBox(
              height: 24,
              width: 24,
              child:
                  SvgPicture.asset(fit: BoxFit.none, Assets.icons.back.path)),
          onTap: () {
            context.read<HomeTopController>().updateNotificationPage(false);
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
    );
  }
}
