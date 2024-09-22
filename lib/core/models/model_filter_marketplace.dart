import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/material.dart';

import 'model_value_label.dart';
import 'model_vehicle_body_type.dart';
import 'model_vehicle_brands.dart';
import 'model_vehicle_fuel_type.dart';
import 'model_vehicle_model.dart';
import 'model_vehicle_series.dart';
import 'model_vehicle_traction_type.dart';
import 'model_vehicle_transmission_type.dart';
import 'model_vehicle_type.dart';
import 'model_vehicle_version.dart';
import 'response/model_response_city.dart';
import 'response/model_response_country.dart';

@jsonSerializable
class ModelFilterMarketplace {
  ModelFilterMarketplace();

  ModelVehicleType? vehicleType;
  ModelVehicleBrand? brand;
  ModelVehicleModel? model;
  ModelVehicleVersion? version;
  ModelVehicleSeries? serie;

  ModelCountry? country;
  ModelCity? city;

  int? minYear;
  int? maxYear;


  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();

  TextEditingController minKilometerController = TextEditingController();
  TextEditingController maxKilometerController = TextEditingController();

  final TextEditingController minDateController = TextEditingController();
  final TextEditingController maxDateController = TextEditingController();
  DateTime? minDate;
  DateTime? maxDate;

  List<ModelVehicleFuelType> fuelTypes = [];
  List<ModelVehicleTransmissionType> transmissionTypes = [];
  List<ModelVehicleBodyType> bodyTypes = [];
  List<ModelValueLabel> enginePowers = [];
  List<ModelValueLabel> engineCapacity = [];
  List<ModelVehicleTractionType> tractionTypes = [];
  List<ModelValueLabel> dates = [];

  void setVehicleType(ModelVehicleType? vehicleType) {
    this.vehicleType = vehicleType;
  }

  void setBrand(ModelVehicleBrand? brand) {
    this.brand = brand;
  }

  void setModel(ModelVehicleModel? model) {
    this.model = model;
  }

  void setVersion(ModelVehicleVersion? version) {
    this.version = version;
  }

  void setSerie(ModelVehicleSeries? serie) {
    this.serie = serie;
  }

  void setCountry(ModelCountry? country) {
    this.country = country;
  }

  void setCity(ModelCity? city, bool isAutoComplete) {
    this.city = city;
  }

  void setMinYear(int minYear) {
    this.minYear = minYear;
  }

  void setMaxYear(int maxYear) {
    this.maxYear = maxYear;
  }

  int getMinKilometer() => int.tryParse(minKilometerController.text.replaceAll('.', '')) ?? -1;
  int getMaxKilometer() => int.tryParse(maxKilometerController.text.replaceAll('.', '')) ?? -1;

  int getMinPrice() => int.tryParse(minPriceController.text.replaceAll('.', '')) ?? -1;
  int getMaxPrice() => int.tryParse(maxPriceController.text.replaceAll('.', '')) ?? -1;

}
