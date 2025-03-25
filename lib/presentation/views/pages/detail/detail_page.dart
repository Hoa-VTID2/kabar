import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:kabar/domain/entities/news.dart';
import 'package:kabar/gen/assets.gen.dart';
import 'package:kabar/presentation/base/base_page.dart';
import 'package:kabar/presentation/resources/colors.dart';
import 'package:kabar/presentation/resources/locale_keys.dart';
import 'package:kabar/presentation/views/pages/detail/detail_controller.dart';
import 'package:kabar/presentation/views/pages/detail/detail_state.dart';
import 'package:kabar/presentation/views/widgets/app_button.dart';
import 'package:kabar/shared/extensions/context_extensions.dart';
import 'package:kabar/shared/extensions/datetime.dart';
import 'package:provider/provider.dart';

@RoutePage()
class DetailPage extends BasePage<DetailController, DetailState> {
  const DetailPage(this.previousPage, {super.key, required this.news});
  final News news;
  final PageRouteInfo<Object?> previousPage;

  @override
  void onInitState(BuildContext context) {
    context.read<DetailController>().iniNews(news);
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    child: SizedBox(
                        height: 24,
                        width: 24,
                        child: SvgPicture.asset(
                            fit: BoxFit.none, Assets.icons.back.path)),
                    onTap: () {
                      context.router.replaceAll([previousPage]);
                    },
                  ),
                  const Expanded(child: Gap(0)),
                  SizedBox(
                      height: 24,
                      width: 24,
                      child: SvgPicture.asset(
                          fit: BoxFit.none, Assets.icons.share.path)),
                  SizedBox(
                      height: 24,
                      width: 24,
                      child: SvgPicture.asset(
                          fit: BoxFit.none, Assets.icons.more.path)),
                ],
              ),
              const Gap(16),
              Expanded(
                child: SingleChildScrollView(
                  child: Selector<DetailState, News>(
                    selector: (_, state) => state.news ?? news,
                    builder: (context, stateNews, child) => Column(
                      spacing: 16,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                stateNews.author.image,
                                width: 50,
                                height: 50,
                              ),
                            ),
                            const Gap(4),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  stateNews.author.fullName,
                                  style:
                                      context.themeOwn().textTheme?.linkMedium,
                                ),
                                Text(
                                  stateNews.time.getTimeAgo,
                                  style: context
                                      .themeOwn()
                                      .textTheme
                                      ?.textSmall
                                      ?.copyWith(color: AppColors.subTextColor),
                                )
                              ],
                            ),
                            const Expanded(child: Gap(0)),
                            if (stateNews.author.followed)
                              AppButton(
                                padding:
                                    const EdgeInsets.fromLTRB(13, 5, 13, 5),
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
                                      .read<DetailController>()
                                      .unFollowAuthor();
                                },
                              )
                            else
                              OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: Size.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 4, 7, 4),
                                    side: const BorderSide(
                                        color: AppColors.primaryColor),
                                  ),
                                  onPressed: () {
                                    context
                                        .read<DetailController>()
                                        .followAuthor();
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
                                        LocaleKeys.search_follow.tr(),
                                        style: context
                                            .themeOwn()
                                            .textTheme
                                            ?.linkMedium
                                            ?.copyWith(
                                                color: AppColors.primaryColor),
                                      )
                                    ],
                                  ))
                          ],
                        ),
                        Image.asset(
                          stateNews.img,
                          height: 248,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stateNews.category.name,
                              style: context
                                  .themeOwn()
                                  .textTheme
                                  ?.textSmall
                                  ?.copyWith(color: AppColors.buttonTextColor),
                            ),
                            Text(
                              stateNews.fullName,
                              style: context.themeOwn().textTheme?.displaySmall,
                            ),
                          ],
                        ),
                        Text(
                          stateNews.detail,
                          style: context
                              .themeOwn()
                              .textTheme
                              ?.textMedium
                              ?.copyWith(color: AppColors.subTextColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 34, 24, 34),
              decoration: const BoxDecoration(
                color: AppColors.white,
                border: Border(
                  top: BorderSide(
                    color: Colors.transparent,
                  )
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(128, 128, 128, 0.2),
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(0, -1),
                  ),
                ]
              ),
              child: Row(
                children: [
                  InkWell(
                    child: Row(
                      children: [

                      ],
                    ),
                  )
                ],
              ),
            ),
        )
      ],
    );
  }
}
