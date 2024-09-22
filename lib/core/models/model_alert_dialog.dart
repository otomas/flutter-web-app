import 'dart:ui';

import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../enums/enum_app.dart';

@jsonSerializable
class ModelAlertDialog {
  const ModelAlertDialog({
    required this.description,
    required this.dialogType,
    this.title,
    this.isDismissible = true,
    this.isActiveCancelButton = false,
    this.onPressedButton, 
    this.buttonText,
    this.buttonColor,
    this.textColor,
  });
  final String? title;
  final String? buttonText;
  final String description;
  final bool isDismissible;
  final bool isActiveCancelButton;
  final DialogTypes? dialogType;
  final Function()? onPressedButton;
  final Color? buttonColor;
  final Color? textColor;
}
