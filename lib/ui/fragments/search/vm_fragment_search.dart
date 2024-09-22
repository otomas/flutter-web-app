import '../../../core/services/service_api.dart';
import '../../base/base_view_model.dart';

class VmFragmentSearch extends ViewModelBase {

  VmFragmentSearch(this.serviceApi) {
    init();
  }
  final ServiceApi serviceApi;

  @override
  void init() {}
}
