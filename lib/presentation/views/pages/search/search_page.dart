import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:kabar/gen/assets.gen.dart';
import 'package:kabar/presentation/base/base_page.dart';
import 'package:kabar/presentation/resources/colors.dart';
import 'package:kabar/presentation/resources/locale_keys.dart';
import 'package:kabar/presentation/router/router.dart';
import 'package:kabar/presentation/views/pages/search/search_controller.dart'
    as my_search;
import 'package:kabar/presentation/views/pages/search/search_state.dart';
import 'package:kabar/presentation/views/widgets/app_button.dart';
import 'package:kabar/presentation/views/widgets/news_card/news_card.dart';
import 'package:kabar/presentation/views/widgets/text_field/app_text_field.dart';
import 'package:kabar/shared/extensions/context_extensions.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SearchPage extends BasePage<my_search.SearchController, SearchState> {
  const SearchPage({super.key});

  @override
  Widget builder(BuildContext context) {
    final List<Tab> tabs = _getTabs();
    return Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
              child: Column(
                spacing: 16,
                children: [
                  AppTextField(
                    hint: LocaleKeys.home_search.tr(),
                    prefixIcon: SvgPicture.asset(Assets.icons.search.path),
                    onChanged: (value) {
                      context.read<my_search.SearchController>().find(value);
                    },
                    suffixIcon: InkWell(
                      child: SvgPicture.asset(Assets.icons.esc.path),
                      onTap: () {
                        context.router.replaceAll([const HomeRoute()]);
                      },
                    ),
                  ),
                  DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        TabBar(
                          tabAlignment: TabAlignment.center,
                          isScrollable: true,
                          padding: EdgeInsets.zero,
                          labelPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                          dividerColor: Colors.transparent,
                          tabs: tabs,
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
                              bottom:
                              BorderSide(color: AppColors.primaryColor, width: 4),
                            ),
                          ),
                        ),
                        const Gap(16),
                        SizedBox(
                          height: 700,
                          child: Consumer<SearchState>(
                            builder: (_, state, __) {
                              return TabBarView(children: [
                                ListView(
                                  children: List.generate(
                                    state.news.length,
                                        (index) {
                                      return Column(
                                        children: [
                                          NewsCard(
                                            news: state.news[index],
                                            pageRouteInfo: const SearchRoute(),
                                          ),
                                          const Gap(16),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                ListView(
                                  children: List.generate(
                                    state.topics.length,
                                        (index) {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              spacing: 8,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(8),
                                                  child: SizedBox(
                                                      width: 70,
                                                      height: 70,
                                                      child: FittedBox(
                                                          fit: BoxFit.cover,
                                                          child: Image.asset(state
                                                              .topics[index].image))),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    spacing: 4,
                                                    children: [
                                                      Text(
                                                        state.topics[index].name,
                                                        style: context
                                                            .themeOwn()
                                                            .textTheme
                                                            ?.textMedium,
                                                      ),
                                                      Text(
                                                        maxLines: 2,
                                                        state.topics[index].detail,
                                                        style: context
                                                            .themeOwn()
                                                            .textTheme
                                                            ?.textXSmall
                                                            ?.copyWith(
                                                            color: AppColors
                                                                .subTextColor),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (state.topics[index].isSaved)
                                                  AppButton(
                                                    padding: const EdgeInsets.fromLTRB(
                                                        13, 5, 13, 5),
                                                    backgroundColor:
                                                    AppColors.primaryColor,
                                                    child: Text(
                                                      tr(LocaleKeys.search,
                                                          gender: 'saved'),
                                                      style: context
                                                          .themeOwn()
                                                          .textTheme
                                                          ?.linkMedium
                                                          ?.copyWith(
                                                          color: AppColors.white),
                                                    ),
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                          my_search
                                                              .SearchController>()
                                                          .unSaveTopic(index);
                                                    },
                                                  )
                                                else
                                                  AppButton(
                                                    borderColor: AppColors.primaryColor,
                                                    padding: const EdgeInsets.fromLTRB(
                                                        13, 5, 13, 5),
                                                    backgroundColor: Colors.white,
                                                    child: Text(
                                                      tr(LocaleKeys.search,
                                                          gender: 'save'),
                                                      style: context
                                                          .themeOwn()
                                                          .textTheme
                                                          ?.linkMedium
                                                          ?.copyWith(
                                                          color: AppColors
                                                              .primaryColor),
                                                    ),
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                          my_search
                                                              .SearchController>()
                                                          .saveTopic(index);
                                                    },
                                                  )
                                              ],
                                            ),
                                          ),
                                          const Gap(16),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                ListView(
                                  children: List.generate(
                                    state.authors.length,
                                        (index) {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              spacing: 8,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(70),
                                                  child: SizedBox(
                                                      width: 70,
                                                      height: 70,
                                                      child: FittedBox(
                                                          fit: BoxFit.cover,
                                                          child: Image.asset(state
                                                              .authors[index].image))),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    spacing: 4,
                                                    children: [
                                                      Text(
                                                        state.authors[index].fullName,
                                                        style: context
                                                            .themeOwn()
                                                            .textTheme
                                                            ?.textMedium,
                                                      ),
                                                      Text(
                                                        '${shortNumber(state.authors[index].follower)} Followers',
                                                        style: context
                                                            .themeOwn()
                                                            .textTheme
                                                            ?.textXSmall
                                                            ?.copyWith(
                                                            color: AppColors
                                                                .subTextColor),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (state.authors[index].followed)
                                                  AppButton(
                                                    padding: const EdgeInsets.fromLTRB(
                                                        13, 5, 13, 5),
                                                    backgroundColor:
                                                    AppColors.primaryColor,
                                                    child: Text(
                                                      LocaleKeys.search_following.tr(),
                                                      style: context
                                                          .themeOwn()
                                                          .textTheme
                                                          ?.linkMedium
                                                          ?.copyWith(
                                                          color: AppColors.white),
                                                    ),
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                          my_search
                                                              .SearchController>()
                                                          .unFollowAuthor(index);
                                                    },
                                                  )
                                                else
                                                  OutlinedButton(
                                                      style: OutlinedButton.styleFrom(
                                                        minimumSize: Size.zero,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                6)),
                                                        padding:
                                                        const EdgeInsets.fromLTRB(
                                                            8, 4, 7, 4),
                                                        side: const BorderSide(
                                                            color:
                                                            AppColors.primaryColor),
                                                      ),
                                                      onPressed: () {
                                                        context
                                                            .read<
                                                            my_search
                                                                .SearchController>()
                                                            .followAuthor(index);
                                                      },
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        spacing: 4,
                                                        children: [
                                                          SvgPicture.asset(
                                                              width: 24,
                                                              height: 24,
                                                              Assets.icons.plus.path),
                                                          Text(
                                                            LocaleKeys.search_follow
                                                                .tr(),
                                                            style: context
                                                                .themeOwn()
                                                                .textTheme
                                                                ?.linkMedium
                                                                ?.copyWith(
                                                                color: AppColors
                                                                    .primaryColor),
                                                          )
                                                        ],
                                                      ))
                                              ],
                                            ),
                                          ),
                                          const Gap(16),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ]);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]
      );
  }

  List<Tab> _getTabs() {
    return [
      Tab(
        text: LocaleKeys.search_news.tr(),
      ),
      Tab(
        text: LocaleKeys.search_topics.tr(),
      ),
      Tab(
        text: LocaleKeys.search_author.tr(),
      ),
    ];
  }

  String shortNumber(int value) {
    if (value < 1000) {
      return value.toString();
    } else if (value < 1000000) {
      return '${(value / 1000).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '')}K';
    } else if (value < 1000000000) {
      return '${(value / 1000000).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '')}M';
    } else {
      return '${(value / 1000000000).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '')}B';
    }
  }
}
