import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kabar/domain/entities/user_info.dart';
import 'package:kabar/gen/assets.gen.dart';
import 'package:kabar/presentation/base/base_page.dart';
import 'package:kabar/presentation/resources/locale_keys.dart';
import 'package:kabar/presentation/views/pages/profile/profile_controller.dart';
import 'package:kabar/presentation/views/pages/profile/profile_state.dart';
import 'package:kabar/shared/extensions/context_extensions.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ProfilePage extends BasePage<ProfileController, ProfileState> {
  const ProfilePage({super.key});

  @override
  void onInitState(BuildContext context) {
    context.read<ProfileController>().initUser();
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return Selector<ProfileState,UserInfo>(
      selector: (p0, p1) => p1.currentUser ?? const UserInfo(
          id: 0,
          fullName: '',
          image: '',
          isAuthor: true,
          follower: 0,
          following: 0,
          newsNumber: 0),
      builder: (context, user, child) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            spacing: 13,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(
                    LocaleKeys.bottom_nav_profile.tr(),
                    style: context.themeOwn().textTheme?.textMedium,
                    textAlign: TextAlign.center,
                  )),
                  SvgPicture.asset(Assets.icons.setting.path),
                ],
              ),
              Column(
                spacing: 16,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        child: Image.asset(user.image,height: 100,width: 100,),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }
    );
  }
}
