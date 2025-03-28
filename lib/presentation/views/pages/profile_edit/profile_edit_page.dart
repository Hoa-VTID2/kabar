import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kabar/gen/assets.gen.dart';
import 'package:kabar/presentation/base/base_page.dart';
import 'package:kabar/presentation/resources/locale_keys.dart';
import 'package:kabar/presentation/views/pages/profile_edit/profile_edit_controller.dart';
import 'package:kabar/presentation/views/pages/profile_edit/profile_edit_state.dart';
import 'package:kabar/presentation/views/widgets/text_field/app_text_field.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ProfileEditPage
    extends BasePage<ProfileEditController, ProfileEditState> {
  const ProfileEditPage({super.key});

  @override
  void onInitState(BuildContext context) {
    context.read<ProfileEditController>().initUserData();
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
        child: Consumer<ProfileEditState>(builder: (context, state, child) {
          return Column(
            spacing: 16,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Assets.icons.esc.svg(),
                    onTap: () {
                      context.pop();
                    },
                  ),
                  const Text(LocaleKeys.edit_profile_title).tr(),
                  InkWell(
                    child: Assets.icons.check.svg(),
                    onTap: () {
                      context.pop();
                    },
                  )
                ],
              ),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage(state.currentUser?.image ??
                        Assets.images.avtPlacehoder.path),
                  ),
                  Positioned(
                      bottom: 0, right: 17, child: Assets.icons.camera.svg()),
                ],
              ),
              Column(
                spacing: 16,
                children: [
                  AppTextField(
                    label: LocaleKeys.edit_profile_username.tr(),
                    value: state.currentUserModel?.identifierCode,
                  ),
                  AppTextField(
                    label: LocaleKeys.edit_profile_full_name.tr(),
                    value: state.currentUser?.fullName,
                  ),
                  AppTextField(
                    label: LocaleKeys.edit_profile_email.tr(),
                    value: state.currentUserModel?.email,
                    required: true,
                  ),
                  AppTextField(
                    label: LocaleKeys.edit_profile_phone_number.tr(),
                    value: state.currentUserModel?.phoneNumber,
                    required: true,
                  ),
                  AppTextField(
                    label: LocaleKeys.edit_profile_bio.tr(),
                    value: state.currentUser?.about,
                  ),
                  AppTextField(
                    label: LocaleKeys.edit_profile_website.tr(),
                  ),
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}
