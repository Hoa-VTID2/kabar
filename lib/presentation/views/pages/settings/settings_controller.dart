import 'package:injectable/injectable.dart';
import 'package:kabar/presentation/base/base_controller.dart';
import 'package:kabar/presentation/views/pages/settings/settings_state.dart';

@injectable
class SettingsController extends BaseController<SettingsState> {
  SettingsController(): super(const SettingsState());

  @override
  SettingsState createEmptyState() {
    return const SettingsState();
  }

  @override
  Future<void> initData() {
    state = state.copyWith(darkMode: false);
    return super.initData();
  }

  void changeMode(bool darkMode) {
    state = state.copyWith(darkMode: darkMode);
  }

}
