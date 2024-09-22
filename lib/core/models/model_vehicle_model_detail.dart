import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'model_dropdown.dart';
import 'model_vehicle_body_type.dart';
import 'model_vehicle_fuel_type.dart';
import 'model_vehicle_transmission_type.dart';

@jsonSerializable
class ModelVehicleModelDetail {
  const ModelVehicleModelDetail({
    this.modelYear,
    this.vehicleTransmissionType,
    this.vehicleFuelType,
    this.vehicleBodyType,
  });
  @JsonProperty(name: 'model_year')
  final ModelYear? modelYear;

  @JsonProperty(name: 'vehicle_transmission_type')
  final List<ModelVehicleTransmissionType>? vehicleTransmissionType;

  @JsonProperty(name: 'vehicle_fuel_type')
  final List<ModelVehicleFuelType>? vehicleFuelType;

  @JsonProperty(name: 'vehicle_body_type')
  final List<ModelVehicleBodyType>? vehicleBodyType;
}

@jsonSerializable
class ModelYear {
  const ModelYear({
    this.start,
    this.end,
  });
  final String? start;
  final String? end;

  List<ModelDropdown> get years {
    final years = <ModelDropdown>[];
    for (var i = int.tryParse(start ?? '1967') ?? 1967; i <= (int.tryParse(end ?? DateTime.now().year.toString()) ?? DateTime.now().year); i++) {
      years.add(ModelDropdown(id: i, title: i.toString()));
    }
    return years.reversed.toList();
  }
}
