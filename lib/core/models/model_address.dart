import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ModelAddress {

  const ModelAddress({
    this.address,
    this.neighborhood,
    this.district,
    this.province,
    this.region,
    this.country,
  });
  final String? address;
  final String? neighborhood;
  final String? district;
  final String? province;
  final String? region;
  final String? country;
}
