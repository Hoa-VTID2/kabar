import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:kabar/domain/entities/news.dart';
import 'package:kabar/presentation/views/pages/comment/comment_page.dart';
import 'package:kabar/presentation/views/pages/detail/detail_page.dart';
import 'package:kabar/presentation/views/pages/home/home_page.dart';
import 'package:kabar/presentation/views/pages/home_top/home_top_page.dart';
import 'package:kabar/presentation/views/pages/login/login_page.dart';
import 'package:kabar/presentation/views/pages/profile/profile_page.dart';
import 'package:kabar/presentation/views/pages/profile_edit/profile_edit_page.dart';
import 'package:kabar/presentation/views/pages/search/search_page.dart';
import 'package:kabar/presentation/views/pages/settings/settings_page.dart';
import 'package:kabar/presentation/views/pages/signup/signup_page.dart';

part 'router.gr.dart';

@singleton
@AutoRouterConfig(replaceInRouteName: 'Page|Dialog|Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: SignupRoute.page),
        AutoRoute(page: SearchRoute.page),
        AutoRoute(page: DetailRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: ProfileEditRoute.page),
        AutoRoute(page: CommentRoute.page),
        AutoRoute(
          page: HomeRoute.page,
          children: [
            AutoRoute(page: HomeTopRoute.page),
            AutoRoute(page: ProfileRoute.page),
          ],
        ),
      ];
}
