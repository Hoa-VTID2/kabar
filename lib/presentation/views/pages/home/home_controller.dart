import 'package:injectable/injectable.dart';
import 'package:kabar/presentation/base/base_controller.dart';
import 'package:kabar/presentation/views/pages/home/home_state.dart';

@injectable
class HomeController extends BaseController<HomeState> {
  HomeController() : super(const HomeState());

  @override
  HomeState createEmptyState() {
    return const HomeState();
  }

  void updateNotificationPage(bool isNotificationPage){
    state = state.copyWith(isNotificationPage: isNotificationPage);
  }
}
