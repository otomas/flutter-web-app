import 'dart:async';
import '../../../../core/enums/enum_app.dart';
import '../../../../core/models/model_vehicle_detail.dart';
import '../../../../core/services/service_api.dart';
import '../../../base/base_view_model.dart';

class VmFragmentVehicleDetailInfoCard extends ViewModelBase {
  VmFragmentVehicleDetailInfoCard(this.serviceApi, this.id) {
    unawaited(init());
  }
  final ServiceApi serviceApi;

  final int id;

  ModelVehicleDetail? data;

  @override
  Future<void> init() async {
    unawaited(getData());
  }

  Future<void> getData() async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.getVehicleDetail(id).then(
      (response) {
        data = response.data;
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
  }
}
