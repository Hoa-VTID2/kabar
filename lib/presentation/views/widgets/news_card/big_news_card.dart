import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kabar/domain/entities/news.dart';
import 'package:kabar/gen/assets.gen.dart';
import 'package:kabar/presentation/resources/colors.dart';
import 'package:kabar/presentation/router/router.dart';
import 'package:kabar/shared/extensions/context_extensions.dart';
import 'package:kabar/shared/extensions/datetime_extensions.dart';

class BigNewsCard extends StatelessWidget {
  const BigNewsCard({
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
        context.router
            .replaceAll([DetailRoute(news: news, previousPage: pageRouteInfo)]);
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                  width: 364,
                  height: 183,
                  child: FittedBox(
                      fit: BoxFit.cover, child: Image.asset(news.img))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  news.topic,
                  style: context
                      .themeOwn()
                      .textTheme
                      ?.textXSmall
                      ?.copyWith(color: AppColors.subTextColor),
                ),
                Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    news.fullName,
                    style: context.themeOwn().textTheme?.textMedium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 8,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 4,
                        children: [
                          Image.asset(width: 20, height: 20, news.author.image),
                          Flexible(
                            child: Text(
                              maxLines: 1,
                              news.author.fullName,
                              style: context
                                  .themeOwn()
                                  .textTheme
                                  ?.linkXSmall
                                  ?.copyWith(color: AppColors.subTextColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          SvgPicture.asset(Assets.icons.clock.path),
                          Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
            )
          ],
        ),
      ),
    );
  }
}
