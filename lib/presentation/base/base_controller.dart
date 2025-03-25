import 'package:kabar/presentation/base/base_state.dart';
import 'package:state_notifier/state_notifier.dart';

abstract class BaseController<S extends BaseState> extends StateNotifier<S> {
  BaseController(super.state);

  Future<dynamic> initData() async {}

  Future<dynamic> retry() async {
    await initData();
  }

  S createEmptyState();

  @override
  S get state {
    if (mounted) {
      return super.state;
    } else {
      return createEmptyState();
    }
  }

  @override
  set state(S value) {
    if (mounted) {
      super.state = value;
    }
  }
}
