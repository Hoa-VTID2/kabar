import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:kabar/gen/assets.gen.dart';
import 'package:kabar/presentation/base/base_page.dart';
import 'package:kabar/presentation/resources/colors.dart';
import 'package:kabar/presentation/resources/locale_keys.dart';
import 'package:kabar/presentation/router/router.dart';
import 'package:kabar/presentation/views/pages/profile/profile_controller.dart';
import 'package:kabar/presentation/views/pages/profile/profile_state.dart';
import 'package:kabar/presentation/views/widgets/app_button.dart';
import 'package:kabar/presentation/views/widgets/news_card/news_card.dart';
import 'package:kabar/shared/extensions/context_extensions.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ProfilePage extends BasePage<ProfileController, ProfileState> {
  const ProfilePage({super.key});

  @override
  void onInitState(BuildContext context) {
    context.read<ProfileController>().initUserData();
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 27,
          right: 24,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.all(15),
              shape: const CircleBorder(),
            ),
            child: SvgPicture.asset(
              height: 24,
              width: 24,
              Assets.images.add.path,
              colorFilter: const ColorFilter.mode(
                AppColors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        Consumer<ProfileState>(builder: (context, state, child) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      LocaleKeys.bottom_nav_profile.tr(),
                      style: context.themeOwn().textTheme?.textMedium,
                      textAlign: TextAlign.center,
                    )),
                    InkWell(
                      child: SvgPicture.asset(Assets.icons.setting.path),
                      onTap: () =>
                          context.pushRoute(const SettingsRoute()),
                    ),
                  ],
                ),
                const Gap(13),
                Column(
                  spacing: 16,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          child: Image.asset(
                            state.currentUser?.image ??
                                Assets.images.avtPlacehoder.path,
                            height: 100,
                            width: 100,
                          ),
                        ),
                        const Gap(16),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Column(
                                spacing: 4,
                                children: [
                                  Text(
                                    state.currentUser?.follower.toString() ??
                                        'Unknown',
                                    style:
                                        context.themeOwn().textTheme?.linkMedium,
                                  ),
                                  Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    LocaleKeys.profile_follower.tr(),
                                    style: context
                                        .themeOwn()
                                        .textTheme
                                        ?.textMedium
                                        ?.copyWith(color: AppColors.subTextColor),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                spacing: 4,
                                children: [
                                  Text(
                                    state.currentUser?.following.toString() ??
                                        'Unknown',
                                    style:
                                        context.themeOwn().textTheme?.linkMedium,
                                  ),
                                  Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    LocaleKeys.profile_following.tr(),
                                    style: context
                                        .themeOwn()
                                        .textTheme
                                        ?.textMedium
                                        ?.copyWith(color: AppColors.subTextColor),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                spacing: 4,
                                children: [
                                  Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    state.userNews.length.toString(),
                                    style:
                                        context.themeOwn().textTheme?.linkMedium,
                                  ),
                                  Text(
                                    LocaleKeys.profile_news.tr(),
                                    style: context
                                        .themeOwn()
                                        .textTheme
                                        ?.textMedium
                                        ?.copyWith(color: AppColors.subTextColor),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.currentUser?.fullName ?? '',
                          style: context.themeOwn().textTheme?.linkMedium,
                        ),
                        Text(
                          state.currentUser?.about ?? '',
                          style: context
                              .themeOwn()
                              .textTheme
                              ?.textMedium
                              ?.copyWith(color: AppColors.subTextColor),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 16,
                      children: [
                        Expanded(
                          child: AppButton.primary(
                              title: LocaleKeys.profile_edit_profile.tr(),
                              titleStyle: context
                                  .themeOwn()
                                  .textTheme
                                  ?.linkMedium
                                  ?.copyWith(color: AppColors.white),
                              backgroundColor: AppColors.primaryColor,
                              borderRadius: 6,
                              minWidth: 164,
                              onPressed: () {
                                context.pushRoute(const ProfileEditRoute());
                              }),
                        ),
                        Expanded(
                          child: AppButton.primary(
                              title: LocaleKeys.profile_website.tr(),
                              titleStyle: context
                                  .themeOwn()
                                  .textTheme
                                  ?.linkMedium
                                  ?.copyWith(color: AppColors.white),
                              backgroundColor: AppColors.primaryColor,
                              borderRadius: 6,
                              minWidth: 164,
                              onPressed: () {}),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(
                          tabs: [
                            Tab(
                              text: LocaleKeys.profile_news.tr(),
                            ),
                            Tab(
                              text: LocaleKeys.profile_recent.tr(),
                            ),
                          ],
                          tabAlignment: TabAlignment.center,
                          labelPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                          dividerColor: Colors.transparent,
                          labelStyle: context.themeOwn().textTheme?.textMedium,
                          labelColor: AppColors.black,
                          indicator: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: AppColors.primaryColor, width: 4),
                            ),
                          ),
                          unselectedLabelStyle: context
                              .themeOwn()
                              .textTheme
                              ?.textMedium
                              ?.copyWith(color: AppColors.subTextColor),
                        ),
                        Expanded(
                            child: TabBarView(children: [
                          ListView.builder(
                            itemCount: state.userNews.length,
                            itemBuilder: (context, index) {
                              if (index == state.userNews.length - 1) {
                                return Column(
                                  children: [
                                    NewsCard(
                                        news: state.userNews[index],
                                        pageRouteInfo: const ProfileRoute()),
                                  ],
                                );
                              } else {
                                return Column(
                                  children: [
                                    NewsCard(
                                        news: state.userNews[index],
                                        pageRouteInfo: const ProfileRoute()),
                                    const Gap(13)
                                  ],
                                );
                              }
                            },
                          ),
                          ListView.builder(
                            itemCount: state.recentNews.length,
                            itemBuilder: (context, index) {
                              if (index == state.recentNews.length - 1) {
                                return Column(
                                  children: [
                                    NewsCard(
                                        news: state.recentNews[index],
                                        pageRouteInfo: const ProfileRoute()),
                                  ],
                                );
                              } else {
                                return Column(
                                  children: [
                                    NewsCard(
                                        news: state.recentNews[index],
                                        pageRouteInfo: const ProfileRoute()),
                                    const Gap(13)
                                  ],
                                );
                              }
                            },
                          ),
                        ])),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
