import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_account_book_list.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponseAccountBookList extends ResponseData {

  const ModelResponseAccountBookList({
    super.status = false,
    super.error,
    this.data,
  });
  final List<ModelAccountBookList>? data;
}
