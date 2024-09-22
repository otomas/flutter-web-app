import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_neighborhood.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponseNeighbourhoodList extends ResponseData {

  const ModelResponseNeighbourhoodList({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelNeighborhood>? data;
}
