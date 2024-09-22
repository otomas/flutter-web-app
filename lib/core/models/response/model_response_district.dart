import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_district.dart';

import '../response_data.dart';

@jsonSerializable
class ModelResponseDistrictList extends ResponseData {
  const ModelResponseDistrictList({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelDistrict>? data;
}
