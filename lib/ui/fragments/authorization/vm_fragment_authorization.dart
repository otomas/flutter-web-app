import 'dart:async';

import '../../../core/services/service_api.dart';
import '../../base/base_view_model.dart';

class VmFragmentAuthorization extends ViewModelBase {
  VmFragmentAuthorization(this.serviceApi) {
    unawaited(init());
  }
  final ServiceApi serviceApi;

  @override
  Future<void> init() async {}
}
