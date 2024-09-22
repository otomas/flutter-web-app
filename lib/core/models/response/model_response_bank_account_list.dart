import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../model_pos_devices.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponseBankAccountList extends ResponseData {

  const ModelResponseBankAccountList({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelAutoGalleryBankAccount>? data;
}
