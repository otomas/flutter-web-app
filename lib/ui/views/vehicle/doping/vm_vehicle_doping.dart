import '../../../../core/services/service_api.dart';
import '../../../base/base_view_model.dart';

class VmVehicleDoping extends ViewModelBase {
  VmVehicleDoping(this.serviceApi, this.vehicleId, this.branchId) {
    init();
  }

  final ServiceApi serviceApi;
  final int vehicleId;
  final int? branchId;

  @override
  void init() {}
}
