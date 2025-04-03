import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:kabar/app_controller.dart';
import 'package:kabar/app_state.dart';
import 'package:kabar/gen/assets.gen.dart';
import 'package:kabar/presentation/base/base_page.dart';
import 'package:kabar/presentation/resources/colors.dart';
import 'package:kabar/presentation/resources/locale_keys.dart';
import 'package:kabar/presentation/router/router.dart';
import 'package:kabar/presentation/views/pages/login/login_controller.dart';
import 'package:kabar/presentation/views/pages/login/login_state.dart';
import 'package:kabar/presentation/views/widgets/app_button.dart';
import 'package:kabar/presentation/views/widgets/text_field/app_secure_text_field.dart';
import 'package:kabar/presentation/views/widgets/text_field/app_text_field.dart';
import 'package:kabar/shared/common/error_handler.dart';
import 'package:kabar/shared/extensions/context_extensions.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

@RoutePage()
class LoginPage extends BasePage<LoginController, LoginState> {
  const LoginPage({super.key});

  @override
  Future<void> onInitState(BuildContext context) async {
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
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: _buildLoginForm(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    final passwordKey = GlobalKey();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: [
        SizedBox(
          height: 240,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.login_hello.tr(),
                style: context.themeOwn().textTheme?.displayLargeBold,
              ),
              Text(
                LocaleKeys.login_again.tr(),
                style: context
                    .themeOwn()
                    .textTheme
                    ?.displayLargeBold
                    ?.copyWith(color: AppColors.primaryColor),
              ),
              const Gap(4),
              Text(LocaleKeys.login_welcome.tr(),
                style: context
                    .themeOwn()
                    .textTheme
                    ?.textLarge
                    ?.copyWith(color: AppColors.subTextColor),
              ),
            ],
          ),
        ),
        Selector<LoginState, Tuple2<String, String?>>(
          selector: (_, loginState) =>
              Tuple2(loginState.username, loginState.usernameError),
          builder: (_, data, __) {
            return AppTextField(
              required: true,
              key: passwordKey,
              label: LocaleKeys.login_user_name_label.tr(),
              value: data.item1,
              hint: LocaleKeys.login_user_name_hint.tr(),
              error: data.item2,
              onChanged: context.read<LoginController>().updateUsername,
              textInputAction: TextInputAction.next,
            );
          },
        ),
        Column(
          spacing: 8,
          children: [
            Selector<LoginState, Tuple2<String, String?>>(
              selector: (_, loginState) =>
                  Tuple2(loginState.password, loginState.passwordError),
              builder: (_, data, __) {
                return AppSecureTextField(
                  required: true,
                  label: LocaleKeys.login_password_label.tr(),
                  value: data.item1,
                  hint: LocaleKeys.login_password_hint.tr(),
                  error: data.item2,
                  onChanged: context.read<LoginController>().updatePassword,
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Selector<LoginState, bool>(
                        selector: (_, loginState) => loginState.remember,
                        builder: (context, remember, child) {
                          return SizedBox(
                            height: 24,
                            width: 24,
                            child: Checkbox(
                              value: remember,
                              onChanged: (value) {
                                context
                                    .read<LoginController>()
                                    .updateRemember(value ?? true);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(3), // Bo góc 3px
                              ),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          );
                        },
                      ),
                      Expanded(
                        child: Text(
                          LocaleKeys.login_remember_me.tr(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context
                              .themeOwn()
                              .textTheme
                              ?.textSmall
                              ?.copyWith(color: AppColors.subTextColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                          LocaleKeys.login_forgot_the_passwords.tr(),
                          style: context
                              .themeOwn()
                              .textTheme
                              ?.textSmall
                              ?.copyWith(color: AppColors.primaryColor),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
        Selector<LoginState, bool>(
          selector: (_, state) => state.isEnableLoginButton,
          builder: (_, isEnableLoginButton, __) => AppButton.primary(
            enable: isEnableLoginButton,
            borderRadius: 6,
            onPressed: () async {
              final result = await context.read<LoginController>().login();
              if (context.mounted) {
                if (result) {
                  context.router.replaceAll([const HomeRoute()]);
                }
              }
            },
            title: LocaleKeys.login_login_button.tr(),
            titleStyle: context.themeOwn().textTheme?.linkMedium?.copyWith(color: AppColors.white),
          ),
        ),
        Text(
          LocaleKeys.login_continue.tr(),
          style: context
              .themeOwn()
              .textTheme
              ?.textSmall
              ?.copyWith(color: AppColors.subTextColor),
          textAlign: TextAlign.center,
        ),
        Row(
          children: [
            Expanded(
              child: AppButton.primary(
                  minWidth: 145,
                  title: LocaleKeys.login_facebook.tr(),
                  onPressed:() {},
                  borderRadius: 6,
                  backgroundColor: AppColors.subButtonColor,
                  icon: SvgPicture.asset(Assets.icons.facebook.path),
                titleStyle: context.themeOwn().textTheme?.linkMedium?.copyWith(color: AppColors.subButtonTitleColor),
              ),
            ),
            const Gap(31),
            Expanded(
              child: AppButton.primary(
                minWidth: 145,
                title: LocaleKeys.login_google.tr(),
                onPressed:() {},
                borderRadius: 6,
                backgroundColor: AppColors.subButtonColor,
                icon: SvgPicture.asset(Assets.icons.google.path),
                titleStyle: context.themeOwn().textTheme?.linkMedium?.copyWith(color: AppColors.subButtonTitleColor),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(LocaleKeys.login_do_not_have_account.tr(), style: context.themeOwn().textTheme?.textSmall?.copyWith(color: AppColors.subButtonTitleColor),),
            TextButton(
              onPressed: () {
                context.router.replaceAll([const SignupRoute()]);
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                LocaleKeys.login_signup.tr(),
                style: context
                    .themeOwn()
                    .textTheme
                    ?.linkSmall
                    ?.copyWith(color: AppColors.primaryColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
