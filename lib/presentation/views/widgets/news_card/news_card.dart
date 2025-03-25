import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:kabar/domain/entities/news.dart';
import 'package:kabar/gen/assets.gen.dart';
import 'package:kabar/presentation/resources/colors.dart';
import 'package:kabar/presentation/router/router.dart';
import 'package:kabar/shared/extensions/context_extensions.dart';
import 'package:kabar/shared/extensions/datetime.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.news,
    required this.pageRouteInfo,
  });
  final News news;
  final PageRouteInfo<Object?> pageRouteInfo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.replaceAll([DetailRoute(news: news,previousPage: pageRouteInfo)]);
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          spacing: 4,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                  width: 96,
                  height: 96,
                  child: FittedBox(
                      fit: BoxFit.cover, child: Image.asset(news.img))),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(news.topic,
                      style: context
                          .themeOwn()
                          .textTheme
                          ?.textXSmall
                          ?.copyWith(color: AppColors.subTextColor)),
                  Text(news.fullName,
                      style: context.themeOwn().textTheme?.textMedium,
                      maxLines: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 8,
                    children: [
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 4,
                          children: [
                            Image.asset(
                                width: 20, height: 20, news.author.image),
                            Flexible(
                              child: Text(
                                news.author.fullName,
                                style: context
                                    .themeOwn()
                                    .textTheme
                                    ?.linkXSmall
                                    ?.copyWith(color: AppColors.subTextColor),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Gap(4),
                            SvgPicture.asset(Assets.icons.clock.path),
                            Text(
                              news.time.getTimeAgo,
                              style: context
                                  .themeOwn()
                                  .textTheme
                                  ?.textXSmall
                                  ?.copyWith(color: AppColors.subTextColor),
                            ),
                          ],
                        ),
                      ),
                      SvgPicture.asset(
                        Assets.icons.etc.path,
                        alignment: Alignment.bottomRight,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
