import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_balance.dart';

import '../response_data.dart';

@jsonSerializable
class ModelResponseTillReport extends ResponseData {

  const ModelResponseTillReport({
    super.status = false,
    super.error,
    this.data,
  });
  final ModelTillReport? data;
}


@jsonSerializable
class ModelTillReport {

  const ModelTillReport({
    this.bank,
    this.posDevice,
    this.user,
    this.branch,
    this.vehicle,
    this.balance,
  });
  final ModelBalance? bank;
  final ModelBalance? posDevice;
  final ModelBalance? user;
  final ModelBalance? branch;
  final ModelBalance? vehicle;
  final ModelBalance? balance;
}
