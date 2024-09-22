import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/material.dart';
import 'model_base_dropdown.dart';
import 'model_value.dart';

@jsonSerializable
class ModelPaymentType implements BaseDropdown {

  ModelPaymentType({
    required this.id,
    this.name,
    this.itemGroupName,
    this.items,
    this.selectedItem,
    this.amountController,
  });

  factory ModelPaymentType.copyWith(ModelPaymentType type) => ModelPaymentType(
        id: type.id,
        name: type.name,
        itemGroupName: type.itemGroupName,
        items: type.items,
        selectedItem: (type.items?.isNotEmpty ?? false) ? type.items!.first : null,
        amountController: TextEditingController(),
      );
  final int id;
  final String? name;

  @JsonProperty(name: 'item_group_name')
  final String? itemGroupName;

  final List<ModelValue>? items;

  @JsonProperty(ignore: true)
  ModelValue? selectedItem;

  @JsonProperty(ignore: true)
  TextEditingController? amountController;

  @override
  String get dropdownId => id.toString();

  @override
  String get dropdownTitle => name ?? '-';
}
