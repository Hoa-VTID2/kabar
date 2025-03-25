import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:kabar/app_controller.dart';
import 'package:kabar/app_state.dart';
import 'package:kabar/domain/entities/news.dart';
import 'package:kabar/domain/enum/category.dart';
import 'package:kabar/gen/assets.gen.dart';
import 'package:kabar/presentation/base/base_page.dart';
import 'package:kabar/presentation/resources/colors.dart';
import 'package:kabar/presentation/resources/locale_keys.dart';
import 'package:kabar/presentation/router/router.dart';
import 'package:kabar/presentation/views/pages/home_top/home_top_controller.dart';
import 'package:kabar/presentation/views/pages/home_top/home_top_state.dart';
import 'package:kabar/presentation/views/widgets/news_card/big_news_card.dart';
import 'package:kabar/presentation/views/widgets/news_card/news_card.dart';
import 'package:kabar/presentation/views/widgets/text_field/app_text_field.dart';
import 'package:kabar/shared/common/error_handler.dart';
import 'package:kabar/shared/extensions/context_extensions.dart';
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
    return Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
        child: Content(context: context));
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
    return SingleChildScrollView(
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
              BigNewsCard(news: context.read<HomeTopController>().getTrendNews(), pageRouteInfo:const HomeRoute(),),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(LocaleKeys.home_latest.tr(),
                          style: context.themeOwn().textTheme?.linkMedium),
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
                          labelPadding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          dividerColor: Colors.transparent,
                          tabs: categories
                              .map((c) => Tab(
                                    height: 34,
                                    child: Text(
                                      tr(LocaleKeys.topic, gender: c.name),
                                      style: context
                                          .themeOwn()
                                          .textTheme
                                          ?.textMedium,
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
                          indicator: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: AppColors.primaryColor, width: 2),
                            ),
                          ),
                        ),
                        const Gap(16),
                        SizedBox(
                          height: 624,
                          child: TabBarView(
                              controller: _tabController,
                              children: categories
                                  .map<Widget>(
                                    (c) => Selector<HomeTopState, List<News>>(
                                      selector: (_, state) => state.news,
                                      builder: (_, newsList, __) {
                                        final news = newsList;
                                        final displayedNews = news.length > 5
                                            ? news.sublist(0, 5)
                                            : news;
                                        return Column(
                                          spacing: 16,
                                          children: List.generate(
                                            displayedNews.length,
                                            (index) {
                                              return NewsCard(
                                                  news: displayedNews[index],
                                                pageRouteInfo: const HomeRoute(),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                  .toList()),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
