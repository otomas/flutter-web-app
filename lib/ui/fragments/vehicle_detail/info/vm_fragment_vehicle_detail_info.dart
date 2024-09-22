import 'dart:async';
import 'dart:convert';

import '../../../../core/enums/enum_app.dart';
import '../../../../core/models/model_file.dart';
import '../../../../core/models/model_photo.dart';
import '../../../../core/models/model_vehicle_detail.dart';
import '../../../../core/models/request/model_request_add_photo.dart';
import '../../../../core/models/response/model_response_vehicle_color_flaw_groups.dart';
import '../../../../core/models/response/model_response_vehicle_report_checklist.dart';
import '../../../../core/services/service_api.dart';
import '../../../base/base_view_model.dart';

class VmFragmentVehicleDetailInfo extends ViewModelBase {
  VmFragmentVehicleDetailInfo(this.serviceApi, this.id) {
    unawaited(init());
  }
  final ServiceApi serviceApi;

  final int id;

  ModelVehicleDetail? data;

  List<ModelVehicleColorFlawGroup> colorFlawGroups = [];
  Map<ModelVehicleReportChecklist, ModelVehicleColorFlawGroup> expertiseItems = {};

  List<ModelPhoto> photos = [];
  
  @override
  Future<void> init() async {
    setActivityState(ActivityState.isLoading);
    await getData();
    await getPhotos();
    setActivityState(ActivityState.isLoaded);
  }

  Future<void> getData() async {
    await serviceApi.client.getVehicleDetail(id).then(
      (response) {
        data = response.data;

        if (data != null) {
          data?.colorFlaws?.forEach(
            (element) {
              expertiseItems.addAll({element.colorReportChecklist: element.colorFlawGroup});
              if (!colorFlawGroups.any((e) => e.id == element.colorFlawGroup.id)) {
                colorFlawGroups.add(element.colorFlawGroup);
              }
            },
          );
        }
      },
      onError: (error) {
        handleApiError(error);
      },
    );
  }

  Future<void> getPhotos() async {
    await serviceApi.client.getVehiclePhotos(id).then(
      (response) {
        photos = response.data?.photos ?? [];
      },
      onError: (error) {
        handleApiError(error);
      },
    );
  }

  ModelPhoto? coverPhoto() {
    final index = photos.indexWhere((element) => element.isCover ?? false);
    if (index != -1) {
      return photos[index];
    }
    return null;
  }

  Future<bool> setCoverPhoto(ModelPhoto item) async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.makeCoverPhoto(id, item.id ?? -1).then(
      (response) {
        errorObserver.message = 'Fotoğraf başarıyla değiştirildi';
        photos.firstWhere((element) => element.id == item.id).isCover = true;
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
    return false;
  }

  Future<bool> deletePhoto(ModelPhoto item) async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.deletePhoto(id, item.id ?? -1).then(
      (response) {
        errorObserver.message = 'Fotoğraf başarıyla silindi';
        photos.removeWhere((element) => element.id == item.id);
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
    return false;
  }

  Future<void> addPhoto(List<ModelFile> files) async {
    isDetectError = true;
    setActivityState(ActivityState.isLoading);
    final f = files.map((e) => base64Encode(e.byte!.toList())).toList();
    await serviceApi.client.addPhoto(id, ModelRequestAddPhoto(f)).then(
      (response) {
        if (response.data != null) {
          photos = response.data?.photos ?? [];
        }
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
  }
}
