import 'model_balance.dart';

class ModelMarketPlaceAd {

  const ModelMarketPlaceAd({
    required this.explanation,
    required this.year,
    required this.km,
    required this.city,
    required this.district,
    required this.imageUrl,
    required this.price,
  });
  final String? imageUrl;
  final String explanation;
  final String year;
  final double km;
  final String city;
  final String district;
  final ModelBalance price;
}
