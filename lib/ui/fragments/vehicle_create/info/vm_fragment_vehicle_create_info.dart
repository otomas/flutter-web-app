import 'dart:async';
import '../../../../core/constants/app_config.dart';
import '../../../../core/enums/enum_app.dart';
import '../../../../core/models/model_dropdown.dart';
import '../../../../core/models/model_vehicle_body_type.dart';
import '../../../../core/models/model_vehicle_brands.dart';
import '../../../../core/models/model_vehicle_fuel_type.dart';
import '../../../../core/models/model_vehicle_model.dart';
import '../../../../core/models/model_vehicle_model_detail.dart';
import '../../../../core/models/model_vehicle_series.dart';
import '../../../../core/models/model_vehicle_traction_type.dart';
import '../../../../core/models/model_vehicle_transmission_type.dart';
import '../../../../core/models/model_vehicle_type.dart';
import '../../../../core/models/model_vehicle_version.dart';
import '../../../../core/models/request/model_request_vehicle.dart';
import '../../../../core/services/service_api.dart';
import '../../../base/base_view_model.dart';

class VmFragmentVehicleCreateInfo extends ViewModelBase {
  VmFragmentVehicleCreateInfo(this.serviceApi, this.params) {
    unawaited(init());
  }
  final ServiceApi serviceApi;

  final ModelRequestVehicleParams params;

  ModelVehicleModelDetail? vehicleTypeInfo;

  @override
  Future<void> init() async {}

  void setSelectedVehicleType(ModelVehicleType? value, bool isAutoComplete) {
    params.vehicleType = value;

    if (!isAutoComplete) {
      params
        ..brand = null
        ..series = null
        ..model = null
        ..version = null
        ..transmissionType = null
        ..bodyType = null
        ..tractionType = null
        ..fuelType = null
        ..year = null;
    }
    notifyListeners();
  }

  void setSelectedBrand(ModelVehicleBrand? value, bool isAutoComplete) {
    params.brand = value;

    if (!isAutoComplete) {
      params
        ..series = null
        ..model = null
        ..version = null
        ..transmissionType = null
        ..bodyType = null
        ..tractionType = null
        ..fuelType = null
        ..year = null;
    }
    notifyListeners();
  }

  void setSelectedSeries(ModelVehicleSeries? value, bool isAutoComplete) {
    params.series = value;

    if (!isAutoComplete) {
      params
        ..model = null
        ..version = null
        ..transmissionType = null
        ..bodyType = null
        ..tractionType = null
        ..fuelType = null
        ..year = null;
    }

    notifyListeners();
  }

  void setSelectedModel(ModelVehicleModel? value, bool isAutoComplete) {
    params.model = value;

    if (!isAutoComplete) {
      params
        ..version = null
        ..transmissionType = null
        ..bodyType = null
        ..tractionType = null
        ..fuelType = null
        ..year = null;
    }
    unawaited(getVehicleModelDetail());
  }

  void setSelectedVersion(ModelVehicleVersion? value, bool isAutoComplete) {
    params.version = value;
    notifyListeners();
  }

  void onChangedTranmissionType(ModelVehicleTransmissionType? value, bool isAutoComplete) {
    params.transmissionType = value;
  }

  void onChangedBodyType(ModelVehicleBodyType? value, bool isAutoComplete) {
    params.bodyType = value;
  }

  void onChangedTractionType(ModelVehicleTractionType? value, bool isAutoComplete) {
    params.tractionType = value;
  }

  void onChangedFuelType(ModelVehicleFuelType? value, bool isAutoComplete) {
    params.fuelType = value;
  }

  void onChangedYear(ModelDropdown? value, bool isAutoComplete) {
    params.year = value;
  }

  void onChangedInsuranceStartDate(DateTime? value) {
    params.insuranceStartDate = value;
  }

  void onChangedInsuranceEndDate(DateTime? value) {
    params.insuranceEndDate = value;
  }

  void onChangedInspectionStartDate(DateTime? value) {
    params.inspectionStartDate = value;
  }

  void onChangedInspectionEndDate(DateTime? value) {
    params.inspectionEndDate = value;
  }

  Future<void> getVehicleModelDetail() async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.getVehicleModelDetail(params.model!.id).then(
      (response) {
        vehicleTypeInfo = response.data;
      },
      onError: (error) {
        params
          ..model = null
          ..version = null;
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
  }

  bool checkFields() {
    isDetectError = true;
    errorFields.clear();
    notifyListeners();

    if (params.vehicleType == null) {
      errorFields.addAll({'vehicle_type': 'Araç tipi alanı zorunludur'});
    }
    if (params.brand == null) {
      errorFields.addAll({'brand': 'Marka alanı zorunludur'});
    }
    if (params.series == null) {
      errorFields.addAll({'series': 'Seri alanı zorunludur'});
    }
    if (params.model == null) {
      errorFields.addAll({'vehicle_model_id': 'Model alanı zorunludur'});
    }
    if (params.version == null) {
      errorFields.addAll({'vehicle_version_id': 'Versiyon alanı zorunludur'});
    }
    if (params.year == null) {
      errorFields.addAll({'model_year': 'Model yılı alanı zorunludur'});
    }
    if (params.fuelType == null) {
      errorFields.addAll({'vehicle_fuel_type_id': 'Yakıt tipi alanı zorunludur'});
    }
    if (params.bodyType == null) {
      errorFields.addAll({'vehicle_body_type_id': 'Kasa Tipi alanı zorunludur'});
    }
    if (params.transmissionType == null) {
      errorFields.addAll({'vehicle_transmission_type_id': 'Şanzıman Tipi alanı zorunludur'});
    }
    if (params.tractionType == null) {
      errorFields.addAll({'vehicle_traction_type_id': 'Çekiş Tipi alanı zorunludur'});
    }
    if (params.chassisNumberController.text.length < 17) {
      errorFields.addAll({'chassis_number': 'Şasi numarası minimum 17 karakter olmalıdır'});
    }
    if (params.enginePowerController.text.isEmpty || (double.tryParse(params.enginePowerController.text.replaceAll('.', '')) ?? 0) == 0) {
      errorFields.addAll({'engine_power': 'Motor gücü alanı doğru formatta değil'});
    }
    if (params.kilometerController.text.isEmpty || (double.tryParse(params.kilometerController.text.replaceAll('.', '')) ?? 0) == 0) {
      errorFields.addAll({'kilometer': 'Kilometre alanı doğru formatta değil'});
    }
    if (!plakaRegex.hasMatch(params.plateNumberController.text)) {
      errorFields.addAll({'plate_number': 'Geçersiz plaka numarası'});
    }
    // if (params.color == null) {
    //   errorFields.addAll({'color': 'Renk alanı boş bırakılamaz'});
    // }

    if (errorFields.isEmpty) {
      return true;
    } else {
      errorObserver.message = 'Lütfen tüm alanları kontrol edin';
      return false;
    }
  }
}
