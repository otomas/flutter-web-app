import 'dart:async';

import '../../../../core/enums/enum_app.dart';
import '../../../../core/extensions/extension_iterable.dart';
import '../../../../core/models/request/model_request_vehicle.dart';
import '../../../../core/models/response/model_response_vehicle_color_flaw_groups.dart';
import '../../../../core/models/response/model_response_vehicle_report_checklist.dart';
import '../../../../core/services/service_api.dart';
import '../../../base/base_view_model.dart';

class VmFragmentVehicleCreateExpertise extends ViewModelBase {
  VmFragmentVehicleCreateExpertise(this.serviceApi, this.params) {
    unawaited(init());
  }
  final ServiceApi serviceApi;

  final ModelRequestVehicleParams params;

  List<ModelVehicleReportChecklist> reportChecklist = [];
  List<ModelVehicleColorFlawGroup> _vehicleColorFlawGroups = [];
  List<ModelVehicleColorFlawGroup> get vehicleColorFlawGroups => _vehicleColorFlawGroups.where((e) => e.isVisible).toList();

  bool isSelectedAllByItem(ModelVehicleColorFlawGroup item) {
    final items = params.selectedExpertiseItems.values.where((e) => e.id == item.id).toList();
    return params.selectedExpertiseItems.isNotEmpty && items.length == params.selectedExpertiseItems.length && items.length == reportChecklist.length;
  }

  @override
  Future<void> init() async {
    setActivityState(ActivityState.isLoading);
    await getVehicleReportChecklist();
    await getVehicleColorFlawGroups();
    setActivityState(ActivityState.isLoaded);
  }

  bool checkFields() {
    isDetectError = true;
    errorFields.clear();
    notifyListeners();
    return true;
  }

  Future<void> getVehicleReportChecklist() async {
    await serviceApi.client.getVehicleReportChecklist().then(
      (response) {
        reportChecklist = response.data ?? [];
      },
      onError: (error) {
        handleApiError(error);
      },
    );
  }

  Future<void> getVehicleColorFlawGroups() async {
    await serviceApi.client.getVehicleColorFlawGroups().then(
      (response) {
        _vehicleColorFlawGroups = response.data ?? [];
      },
      onError: (error) {
        handleApiError(error);
      },
    );
  }

  void updateSelectedList(ModelVehicleReportChecklist item, ModelVehicleColorFlawGroup group) {
    final v = params.selectedExpertiseItems.entries.firstWhereOrNull((e) => e.key.id == item.id);
    if (v != null) {
      params.selectedExpertiseItems.remove(v.key);
    }
    params.selectedExpertiseItems.addAll({item: group});
    notifyListeners();
  }

  void selectAll(ModelVehicleColorFlawGroup selectedItem, bool value) {
    params.selectedExpertiseItems.clear();
    if (value) {
      for (final element in reportChecklist) {
        params.selectedExpertiseItems.addAll({element: selectedItem});
      }
    }
    notifyListeners();
  }
}
