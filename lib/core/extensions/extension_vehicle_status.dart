import '../enums/enum_api.dart';

extension ExtensionVehicleStatus on VehicleStatus? {

  bool get isPublishable => this == VehicleStatus.readyForPublication || this == VehicleStatus.discontinuePublication || this == VehicleStatus.rejected || this == VehicleStatus.consignee || this == VehicleStatus.inventory;
  
  bool get isNotPublishable => this == VehicleStatus.archived || this == VehicleStatus.sold;
}
