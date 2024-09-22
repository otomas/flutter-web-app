import 'package:flutter/material.dart';
import 'package:paged_datatable/paged_datatable.dart';

class ModelDataTableColumn {
  ModelDataTableColumn({
    required this.id,
    required this.title,
    this.widgets = const [],
    this.size = const FractionalColumnSize(0.1),
    this.sortable = true,
  });
  final String id;
  final String title;
  List<Widget> widgets;
  ColumnSize size;
  bool sortable;

  void addWidget(Widget widget) {
    widgets.add(widget);
  }
}
