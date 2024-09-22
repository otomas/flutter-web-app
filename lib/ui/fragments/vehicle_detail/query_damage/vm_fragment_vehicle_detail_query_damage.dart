import 'dart:async';
import '../../../../core/enums/enum_api.dart';
import '../../../../core/enums/enum_app.dart';
import '../../../../core/models/model_dropdown.dart';
import '../../../../core/models/model_query.dart';
import '../../../../core/models/model_vehicle_detail.dart';
import '../../../../core/services/service_api.dart';
import '../../../base/base_view_model.dart';

class VmFragmentVehicleDetailQueryDamage extends ViewModelBase {
  VmFragmentVehicleDetailQueryDamage(this.serviceApi, this.vehicleId) {
    selectedQueryType = queryTypes.first;
    unawaited(init());
  }
  final ServiceApi serviceApi;
  final int vehicleId;

  ModelVehicleDetail? vehicleData;

  List<ModelQuery> data = [];

  ModelDropdown? selectedQueryType;
  List<ModelDropdown> queryTypes = [
    ModelDropdown(id: QueryType.plate.id, title: 'Plaka ile sorgula'),
    ModelDropdown(id: QueryType.chassis.id, title: 'Şasi numarası ile sorgula'),
  ];

  @override
  Future<void> init() async {
    setActivityState(ActivityState.isLoading);
    await getVehicleData();
    await getData();
    setActivityState(ActivityState.isLoaded);
  }

  void setSelectedQueryType(ModelDropdown item) {
    selectedQueryType = item;
    notifyListeners();
  }

  Future<void> getVehicleData() async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.getVehicleDetail(vehicleId).then(
      (response) {
        vehicleData = response.data;
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
  }


  Future<void> getData() async {
    await serviceApi.client.getVehicleDamageRecords(vehicleId).then(
      (response) {
        data = response.data ?? [];
      },
      onError: (error) {
        handleApiError(error);
      },
    );
  }

  Future<void> createQuery() async {
    setActivityState(ActivityState.isLoading);

    setActivityState(ActivityState.isLoaded);
  }
}
