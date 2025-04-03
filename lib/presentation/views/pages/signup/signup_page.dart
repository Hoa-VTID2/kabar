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
import 'package:kabar/presentation/views/pages/signup/signup_controller.dart';
import 'package:kabar/presentation/views/pages/signup/signup_state.dart';
import 'package:kabar/presentation/views/widgets/app_button.dart';
import 'package:kabar/presentation/views/widgets/text_field/app_secure_text_field.dart';
import 'package:kabar/presentation/views/widgets/text_field/app_text_field.dart';
import 'package:kabar/shared/common/error_handler.dart';
import 'package:kabar/shared/extensions/context_extensions.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

@RoutePage()
class SignupPage extends BasePage<SignupController, SignupState> {
  const SignupPage({super.key});

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
              child: _buildSignupForm(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupForm(BuildContext context) {
    final passwordKey = GlobalKey();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: [
        SizedBox(
          height: 155,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${LocaleKeys.login_hello.tr()}!',
                style: context
                    .themeOwn()
                    .textTheme
                    ?.displayLargeBold
                    ?.copyWith(color: AppColors.primaryColor),
              ),
              const Gap(4),
              Text(LocaleKeys.login_signup_sub_title.tr(),
                style: context
                    .themeOwn()
                    .textTheme
                    ?.textLarge
                    ?.copyWith(color: AppColors.subTextColor),
              ),
            ],
          ),
        ),
        Selector<SignupState, Tuple2<String, String?>>(
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
              onChanged: context.read<SignupController>().updateUserName,
              textInputAction: TextInputAction.next,
            );
          },
        ),
        Column(
          spacing: 8,
          children: [
            Selector<SignupState, Tuple2<String, String?>>(
              selector: (_, loginState) =>
                  Tuple2(loginState.password, loginState.passwordError),
              builder: (_, data, __) {
                return AppSecureTextField(
                  required: true,
                  label: LocaleKeys.login_password_label.tr(),
                  value: data.item1,
                  hint: LocaleKeys.login_password_hint.tr(),
                  error: data.item2,
                  onChanged: context.read<SignupController>().updatePassword,
                );
              },
            ),
            Row(
              children: [
                Selector<SignupState, bool>(
                  selector: (_, loginState) => loginState.remember,
                  builder: (context, remember, child) {
                    return SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        value: remember,
                        onChanged: (value) {
                          context
                              .read<SignupController>()
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
                Text(
                  LocaleKeys.login_remember_me.tr(),
                  style: context
                      .themeOwn()
                      .textTheme
                      ?.textSmall
                      ?.copyWith(color: AppColors.subTextColor),
                ),
              ],
            ),
          ],
        ),
        AppButton.primary(
          borderRadius: 6,
          onPressed: () async {
            final result = await context.read<SignupController>().signup();
            if (context.mounted) {
              if (result) {
                context.router.replaceAll([const HomeRoute()]);
              }
            }
          },
          title: LocaleKeys.login_login_button.tr(),
          titleStyle: context.themeOwn().textTheme?.linkMedium?.copyWith(color: AppColors.white),
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
            Text(LocaleKeys.login_already_have_an_account.tr(), style: context.themeOwn().textTheme?.textSmall?.copyWith(color: AppColors.subButtonTitleColor),),
            TextButton(
              onPressed: () {
                context.router.replaceAll([const LoginRoute()]);
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                LocaleKeys.login_login_title.tr(),
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
