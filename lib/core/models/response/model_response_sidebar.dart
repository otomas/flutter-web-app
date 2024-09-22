import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_sidebar.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponseSideBar extends ResponseData {

  const ModelResponseSideBar({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelSideBar>? data;
}
