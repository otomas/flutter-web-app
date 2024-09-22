import 'dart:async';

import '../../../core/enums/enum_app.dart';
import '../../../core/models/model_public_vehicle_list.dart';
import '../../../core/models/model_vehicle_equipment.dart';
import '../../../core/models/response/model_response_vehicle_color_flaw_groups.dart';
import '../../../core/models/response/model_response_vehicle_report_checklist.dart';
import '../../../core/services/service_api.dart';
import '../../base/base_view_model.dart';

class VmPublicDetail extends ViewModelBase {
  VmPublicDetail(this.serviceApi) {
    unawaited(init());
  }
  final ServiceApi serviceApi;

  List<ModelVehicleColorFlawGroup> colorFlawGroups = [];
  Map<ModelVehicleReportChecklist, ModelVehicleColorFlawGroup> expertiseItems = {};

  bool isExpertiseContainerVisible = true;
  bool isInternalEquipmentVisible = true;
  bool isExternalEquipmentVisible = true;
  bool isGeneralScreenTypeSelected = true;

  Map<String, List<ModelVehicleEquipment>> vehicleEquipments = {};

  ModelVehicleResponse? data;

  @override
  Future<void> init() async {
    setActivityState(ActivityState.isLoading);
    unawaited(getData());
    setActivityState(ActivityState.isLoaded);
  }

  Future<void> getData() async {
    await serviceApi.client.getPublicVehicleDetail(12).then(
      (response) {
        if (response.data != null) {
          data = response.data;
          data?.colorFlaws?.forEach(
            (element) {
              expertiseItems.addAll({element.colorReportChecklist: element.colorFlawGroup});
              if (!colorFlawGroups.any((e) => e.id == element.colorFlawGroup.id)) {
                colorFlawGroups.add(element.colorFlawGroup);
              }
            },
          );
          vehicleEquipments['internal'] = [
            data?.vehicleInteriorEquipments?.forEach((element) {
              ModelVehicleEquipment(name: element.name);
            }) as ModelVehicleEquipment,
          ];
          vehicleEquipments['external'] = [
            data?.vehicleExteriorEquipments?.forEach((element) {
              ModelVehicleEquipment(name: element.name);
            }) as ModelVehicleEquipment,
          ];
          vehicleEquipments['multimedia'] = [
            data?.vehicleMultimedias?.forEach((element) {
              ModelVehicleEquipment(name: element.name);
            }) as ModelVehicleEquipment,
          ];
          vehicleEquipments['security'] = [
            data?.vehicleSecurityEquipments?.forEach((element) {
              ModelVehicleEquipment(name: element.name);
            }) as ModelVehicleEquipment,
          ];
          notifyListeners();
        }
      },
      onError: (error) {
        handleApiError(error);
      },
    );
  }

  void changeisExpertiseContainerVisible() {
    isExpertiseContainerVisible = !isExpertiseContainerVisible;
    notifyListeners();
  }

  void changeisInternalEquipmentVisible() {
    isInternalEquipmentVisible = !isInternalEquipmentVisible;
    notifyListeners();
  }

  void changeisExternalEquipmentVisible() {
    isExternalEquipmentVisible = !isExternalEquipmentVisible;
    notifyListeners();
  }

  void changeisGeneralScreenTypeSelected() {
    isGeneralScreenTypeSelected = !isGeneralScreenTypeSelected;
    notifyListeners();
  }
}
