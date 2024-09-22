import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_base_dropdown.dart';

@jsonSerializable
class ModelTransactionCategories implements BaseDropdown {

  const ModelTransactionCategories({
    required this.id,
    this.name,
  });
  final num id;
  final String? name;
  
 @override
  String get dropdownId => id.toString();

  @override
  String get dropdownTitle => name ?? '-';
}
