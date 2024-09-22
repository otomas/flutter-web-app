import 'package:flutter/material.dart';

class ModelExpandableListItem {

  const ModelExpandableListItem({required this.title, required this.onTap, this.isNew = false, this.isSelected = false});
  final String title;
  final VoidCallback onTap;
  final bool isNew;
  final bool isSelected;
}
