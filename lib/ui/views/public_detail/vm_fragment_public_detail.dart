import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/enums/enum_app.dart';
import '../../../core/models/model_public_vehicle_list.dart';
import '../../../core/models/model_vehicle_equipment.dart';
import '../../../core/models/response/model_response_vehicle_color_flaw_groups.dart';
import '../../../core/models/response/model_response_vehicle_report_checklist.dart';
import '../../../core/services/service_api.dart';
import '../../base/base_view_model.dart';

class VmPublicDetail extends ViewModelBase {
  VmPublicDetail(this.vehicleId, this.serviceApi) {
    unawaited(init());
  }
  final ServiceApi serviceApi;
  final int vehicleId;

  List<ModelVehicleColorFlawGroup> colorFlawGroups = [];
  Map<ModelVehicleReportChecklist, ModelVehicleColorFlawGroup> expertiseItems = {};
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  bool isExpertiseContainerVisible = true;
  bool isInternalEquipmentVisible = true;
  bool isExternalEquipmentVisible = true;
  bool isMultimediaEquipmentVisible = true;
  bool isSecurityEquipmentVisible = true;
  bool isGeneralScreenTypeSelected = true;
  bool isVehicleInfoVisible = true;

  Map<String, List<ModelVehicleEquipment>> vehicleEquipments = {};

  ModelVehicleResponse? data;

  @override
  Future<void> init() async {
    unawaited(getData(vehicleId));
  }

  Future<void> getData(int vehicleId) async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.getPublicVehicleDetail(vehicleId).then(
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
          vehicleEquipments['internal'] = data?.vehicleInteriorEquipments?.map((element) => ModelVehicleEquipment(name: element.name)).toList() ?? [];
          vehicleEquipments['external'] = data?.vehicleExteriorEquipments?.map((element) => ModelVehicleEquipment(name: element.name)).toList() ?? [];
          vehicleEquipments['multimedia'] = data?.vehicleMultimedias?.map((element) => ModelVehicleEquipment(name: element.name)).toList() ?? [];
          vehicleEquipments['security'] = data?.vehicleSecurityEquipments?.map((element) => ModelVehicleEquipment(name: element.name)).toList() ?? [];
          notifyListeners();
        }
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
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

  void changeisVehicleInfoVisible() {
    isVehicleInfoVisible = !isVehicleInfoVisible;
    notifyListeners();
  }

  void changeisGeneralScreenTypeSelected() {
    isGeneralScreenTypeSelected = !isGeneralScreenTypeSelected;
    notifyListeners();
  }

  void changeisMultimediaEquipmentVisible() {
    isMultimediaEquipmentVisible = !isMultimediaEquipmentVisible;
    notifyListeners();
  }

  void changeisSecurityEquipmentVisible() {
    isSecurityEquipmentVisible = !isSecurityEquipmentVisible;
    notifyListeners();
  }
}
