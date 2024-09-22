import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_accounting_book.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponseAccountingBook extends ResponseData {

  const ModelResponseAccountingBook({
    super.status = false,
    super.error,
    this.data,
  });
  final ModelAccountingBook? data;
}
