import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/material.dart';
import '../../../ui/views/vehicle/create/vm_vehicle_create.dart';
import '../../enums/enum_api.dart';
import '../model_customer.dart';
import '../model_dropdown.dart';
import '../model_payment_type.dart';
import '../model_vehicle_body_type.dart';
import '../model_vehicle_brands.dart';
import '../model_vehicle_fuel_type.dart';
import '../model_vehicle_model.dart';
import '../model_vehicle_series.dart';
import '../model_vehicle_traction_type.dart';
import '../model_vehicle_transmission_type.dart';
import '../model_vehicle_type.dart';
import '../model_vehicle_version.dart';
import '../response/model_response_vehicle_color_flaw_groups.dart';
import '../response/model_response_vehicle_report_checklist.dart';
import 'model_request_payment_type.dart';

@jsonSerializable
class ModelRequestVehicle {
  const ModelRequestVehicle({
    required this.autoGalleryBranchId,
    required this.vehicleModelId,
    required this.vehicleBodyTypeId,
    required this.vehicleFuelTypeId,
    required this.vehicleTransmissionTypeId,
    required this.vehicleTractionTypeId,
    required this.enginePower,
    required this.modelYear,
    required this.plateNumber,
    required this.chassisNumber,
    required this.kilometer,
    required this.color,
    required this.salesPrice,
    required this.purchasedAt,
    required this.vehicleVersionId,
    this.supplierId,
    this.sellerId,
    this.buyerId,
    this.engineCapacity,
    this.price,
    this.insuranceStartDate,
    this.insuranceEndDate,
    this.inspectionStartDate,
    this.inspectionEndDate,
    this.detail,
    this.payments,
    this.colorFlaws,
  });
  @JsonProperty(name: 'auto_gallery_branch_id')
  final int autoGalleryBranchId;

  @JsonProperty(name: 'supplier_id')
  final int? supplierId;

  @JsonProperty(name: 'seller_id')
  final int? sellerId;

  @JsonProperty(name: 'buyer_id')
  final int? buyerId;

  @JsonProperty(name: 'vehicle_model_id')
  final int vehicleModelId;

  @JsonProperty(name: 'vehicle_body_type_id')
  final int vehicleBodyTypeId;

  @JsonProperty(name: 'vehicle_fuel_type_id')
  final int vehicleFuelTypeId;

  @JsonProperty(name: 'vehicle_transmission_type_id')
  final int vehicleTransmissionTypeId;

  @JsonProperty(name: 'vehicle_traction_type_id')
  final int vehicleTractionTypeId;

  @JsonProperty(name: 'vehicle_version_id')
  final int vehicleVersionId;

  @JsonProperty(name: 'engine_power')
  final int enginePower;

  @JsonProperty(name: 'engine_capacity')
  final int? engineCapacity;

  @JsonProperty(name: 'model_year')
  final int modelYear;

  @JsonProperty(name: 'plate_number')
  final String plateNumber;

  @JsonProperty(name: 'chassis_number')
  final String chassisNumber;

  final int kilometer;
  final String color;

  final String? price;

  @JsonProperty(name: 'sales_price')
  final String salesPrice;

  @JsonProperty(name: 'purchased_at', converterParams: {'format': 'yyyy-MM-dd'})
  final DateTime purchasedAt;

  @JsonProperty(name: 'insurance_start_date', converterParams: {'format': 'yyyy-MM-dd'})
  final DateTime? insuranceStartDate;

  @JsonProperty(name: 'insurance_end_date', converterParams: {'format': 'yyyy-MM-dd'})
  final DateTime? insuranceEndDate;

  @JsonProperty(name: 'inspection_start_date', converterParams: {'format': 'yyyy-MM-dd'})
  final DateTime? inspectionStartDate;

  @JsonProperty(name: 'inspection_end_date', converterParams: {'format': 'yyyy-MM-dd'})
  final DateTime? inspectionEndDate;

  final String? detail;

  final List<ModelRequestPaymentType>? payments;

  @JsonProperty(name: 'color_flaws')
  final List<ModelRequestColorFlaws>? colorFlaws;
}

@jsonSerializable
class ModelRequestColorFlaws {
  const ModelRequestColorFlaws({required this.colorReportChecklistId, required this.colorFlawGroupId, this.isDent = 0, this.isScratch = 0});

  @JsonProperty(name: 'color_report_checklist_id')
  final int colorReportChecklistId;

  @JsonProperty(name: 'color_flaw_group_id')
  final int colorFlawGroupId;

  @JsonProperty(name: 'is_dent')
  final int isDent;

  @JsonProperty(name: 'is_scratch')
  final int isScratch;
}

class ModelRequestVehicleParams {
  ModelRequestVehicleParams(this.vmVehicleCreate, this.branchId);

  VmVehicleCreate vmVehicleCreate;
  int branchId;

  ModelCustomer? supplier;
  ModelCustomer? seller;
  ModelCustomer? buyer;

  ModelVehicleType? vehicleType;
  ModelVehicleBrand? brand;
  ModelVehicleSeries? series;
  ModelVehicleModel? model;
  ModelVehicleVersion? version;

  ModelVehicleTransmissionType? transmissionType;
  ModelVehicleBodyType? bodyType;
  ModelVehicleTractionType? tractionType;
  ModelVehicleFuelType? fuelType;
  ModelDropdown? year;

  TextEditingController kilometerController = TextEditingController();
  TextEditingController enginePowerController = TextEditingController();
  TextEditingController engineCapacity = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();
  TextEditingController chassisNumberController = TextEditingController();

  DateTime? insuranceStartDate;
  DateTime? insuranceEndDate;

  DateTime? inspectionStartDate;
  DateTime? inspectionEndDate;

  Map<ModelVehicleReportChecklist, ModelVehicleColorFlawGroup> selectedExpertiseItems = {};

  DateTime? buyingDate;
  TextEditingController buyingPriceController = TextEditingController();
  TextEditingController sellingPriceController = TextEditingController();
  List<ModelPaymentType> paymentTypes = [];

  ModelRequestVehicle get vehicleRequestModel => ModelRequestVehicle(
        autoGalleryBranchId: branchId,
        vehicleModelId: model!.id,
        vehicleBodyTypeId: bodyType!.id,
        vehicleFuelTypeId: fuelType!.id,
        vehicleTransmissionTypeId: transmissionType!.id,
        vehicleTractionTypeId: tractionType!.id,
        vehicleVersionId: version!.id,
        enginePower: (double.tryParse(enginePowerController.text.replaceAll('.', '')) ?? 0).toInt(),
        modelYear: int.tryParse(year!.title) ?? 0,
        plateNumber: plateNumberController.text,
        chassisNumber: chassisNumberController.text,
        kilometer: (double.tryParse(kilometerController.text.replaceAll('.', '')) ?? 0).toInt(),
        price: (double.tryParse(buyingPriceController.text.replaceAll('.', '')) ?? 0).toInt().toString(),
        salesPrice: (double.tryParse(sellingPriceController.text.replaceAll('.', '')) ?? 0).toInt().toString(),
        purchasedAt: buyingDate!,
        buyerId: buyer?.id,
        sellerId: seller?.id,
        supplierId: supplier?.id,
        engineCapacity: (double.tryParse(engineCapacity.text.replaceAll('.', '')) ?? 0).toInt(),
        inspectionStartDate: inspectionStartDate,
        inspectionEndDate: inspectionEndDate,
        insuranceStartDate: insuranceStartDate,
        insuranceEndDate: insuranceEndDate,
        detail: '',
        color: 'Beyaz',
        payments: paymentTypes.map(
          (e) {
            final paymentType = PaymentType.fromId(e.id);
            return ModelRequestPaymentType(
              paymentTypeId: e.id,
              amount: int.tryParse(e.amountController!.text.replaceAll('.', '')) ?? 0,
              bankAccountId: paymentType == PaymentType.bankTransfer ? e.selectedItem?.id : null,
              branchPosDeviceId: paymentType == PaymentType.creditCard ? e.selectedItem?.id : null,
            );
          },
        ).toList(),
        colorFlaws: selectedExpertiseItems.entries
            .map(
              (e) => ModelRequestColorFlaws(
                colorReportChecklistId: e.key.id,
                colorFlawGroupId: e.value.id,
              ),
            )
            .toList(),
      );
}
