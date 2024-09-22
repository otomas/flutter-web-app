import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_query.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponseQuery extends ResponseData {
  const ModelResponseQuery({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelQuery>? data;
}

@jsonSerializable
class ModelResponseQueryDetail extends ResponseData {
  const ModelResponseQueryDetail({
    super.status = false,
    super.error,
    this.data,
  });
  final ModelQuery? data;
}
