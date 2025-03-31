import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:kabar/app_controller.dart';
import 'package:kabar/gen/assets.gen.dart';
import 'package:kabar/presentation/base/base_page.dart';
import 'package:kabar/presentation/resources/colors.dart';
import 'package:kabar/presentation/resources/locale_keys.dart';
import 'package:kabar/presentation/resources/themes.dart';
import 'package:kabar/presentation/router/router.dart';
import 'package:kabar/presentation/views/pages/settings/settings_controller.dart';
import 'package:kabar/presentation/views/pages/settings/settings_state.dart';
import 'package:kabar/shared/extensions/context_extensions.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SettingsPage extends BasePage<SettingsController, SettingsState> {
  const SettingsPage({super.key});

  @override
  Widget builder(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                child: SvgPicture.asset(Assets.icons.back.path),
                onTap: () => context.pop(),
              ),
              Expanded(
                  child: Center(
                child: Text(
                  LocaleKeys.profile_settings.tr(),
                  style: context.themeOwn().textTheme?.textMedium,
                ),
              )),
            ],
          ),
          const Gap(16),
          Column(
            spacing: 48,
            children: [
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
                      child: SvgPicture.asset(Assets.icons.notification.path),
                    ),
                    const Gap(4),
                    Text(
                      LocaleKeys.settings_notification.tr(),
                      style: context.themeOwn().textTheme?.textMedium,
                    ),
                    const Expanded(child: Gap(0)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(9, 8, 9, 8),
                      child: SvgPicture.asset(Assets.icons.next.path),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
                      child: SvgPicture.asset(Assets.icons.secure.path),
                    ),
                    const Gap(4),
                    Text(
                      LocaleKeys.settings_security.tr(),
                      style: context.themeOwn().textTheme?.textMedium,
                    ),
                    const Expanded(child: Gap(0)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(9, 8, 9, 8),
                      child: SvgPicture.asset(Assets.icons.next.path),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
                      child: SvgPicture.asset(Assets.icons.help.path),
                    ),
                    const Gap(4),
                    Text(
                      LocaleKeys.settings_help.tr(),
                      style: context.themeOwn().textTheme?.textMedium,
                    ),
                    const Expanded(child: Gap(0)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(9, 8, 9, 8),
                      child: SvgPicture.asset(Assets.icons.next.path),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
                        child: SvgPicture.asset(Assets.icons.moon.path),
                      ),
                      const Gap(4),
                      Text(
                        LocaleKeys.settings_dark_mode.tr(),
                        style: context.themeOwn().textTheme?.textMedium,
                      ),
                      const Expanded(child: Gap(0)),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: Selector<SettingsState, bool>(
                      selector: (p0, state) => state.darkMode,
                      builder: (context, darkMode, child) {
                        return Transform.scale(
                          scale: 0.6,
                          child: Switch(
                            value: darkMode,
                            inactiveThumbColor: AppColors.white,
                            trackOutlineColor: const WidgetStatePropertyAll(
                                Colors.transparent),
                            padding: EdgeInsets.zero,
                            onChanged: (value) {
                              context
                                  .read<SettingsController>()
                                  .changeMode(value);
                              context.read<AppController>().updateTheme(!value);
                            } ,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  context.read<AppController>().logout();
                  context.router.replaceAll([const LoginRoute()]);
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
                      child: SvgPicture.asset(Assets.icons.logout.path),
                    ),
                    const Gap(4),
                    Text(
                      LocaleKeys.settings_logout.tr(),
                      style: context.themeOwn().textTheme?.textMedium,
                    ),
                    const Expanded(child: Gap(0)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(9, 8, 9, 8),
                      child: SvgPicture.asset(Assets.icons.next.path),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
