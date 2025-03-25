import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:kabar/domain/entities/notification.dart';
import 'package:kabar/domain/enum/action.dart';
import 'package:kabar/gen/assets.gen.dart';
import 'package:kabar/presentation/base/base_page.dart';
import 'package:kabar/presentation/resources/colors.dart';
import 'package:kabar/presentation/resources/locale_keys.dart';
import 'package:kabar/presentation/views/pages/home_notification/home_notification_controller.dart';
import 'package:kabar/presentation/views/pages/home_notification/home_notification_state.dart';
import 'package:kabar/presentation/views/widgets/app_button.dart';
import 'package:kabar/shared/extensions/context_extensions.dart';
import 'package:kabar/shared/extensions/datetime.dart';
import 'package:kabar/shared/extensions/string_extensions.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomeNotificationPage
    extends BasePage<HomeNotificationController, HomeNotificationState> {
  const HomeNotificationPage({super.key});

  @override
  void onInitState(BuildContext context) {
    context.read<HomeNotificationController>().initData();
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: SingleChildScrollView(
        child: Consumer<HomeNotificationState>(builder: (_, state, __) {
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
                        .read<HomeNotificationController>()
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
                      .read<HomeNotificationController>()
                      .unFollowUser(notificationItem.creator.fullName);
                },
              )
        ],
      ),
    );
  }
}
