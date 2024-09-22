import 'model_balance.dart';

class ModelCarCard {

  const ModelCarCard({required this.imageUrl, required this.brand, required this.model, required this.price, required this.gearType, required this.fuelType});
  final String? imageUrl;
  final String brand;
  final String model;
  final ModelBalance price;
  final String gearType;
  final String fuelType;
}
