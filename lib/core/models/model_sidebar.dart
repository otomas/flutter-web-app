import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'model_balance.dart';
import 'model_base_dropdown.dart';

@jsonSerializable
class ModelSideBar implements BaseDropdown {

  const ModelSideBar({this.type, this.groupName, this.modelId, this.modelName, this.balance, this.itemName});
  final String? type;

  @JsonProperty(name: 'group_name')
  final String? groupName;

  @JsonProperty(name: 'model_name')
  final String? modelName;

  @JsonProperty(name: 'model_id')
  final num? modelId;

  @JsonProperty(name: 'item_name')
  final String? itemName;

  final ModelBalance? balance;

  @override
  String get dropdownId => modelId.toString();

  @override
  String get dropdownTitle => itemName ?? '-';
}
