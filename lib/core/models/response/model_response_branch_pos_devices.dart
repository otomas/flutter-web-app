import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_pos_devices.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponseBranchPosDevices extends ResponseData {
  const ModelResponseBranchPosDevices({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelBranchPosDevice>? data;
}
