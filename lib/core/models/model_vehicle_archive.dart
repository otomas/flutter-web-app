import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ModelVehicleArchive {

  const ModelVehicleArchive({
    required this.id,
    required this.plate, required this.brand, required this.model, required this.supplier, required this.seller, required this.balance, required this.balanceCurrency, this.imageUrl,
  });
  final int id;
  final String? imageUrl;
  final String plate;
  final String brand;
  final String model;
  final String supplier;
  final String seller;
  final num balance;
  final String balanceCurrency;
}
