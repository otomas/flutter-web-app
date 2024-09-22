import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paged_datatable/paged_datatable.dart';
import '../../core/constants/app_config.dart';
import '../../core/models/model_data_table_column.dart';
import '../../core/resources/_r.dart';
import 'widgets_text.dart';

class WidgetDataTable extends StatelessWidget {
  const WidgetDataTable({
    required this.data,
    required this.tableController,
    required this.take,
    required this.fetcher,
    required this.onTapCellItem,
    this.rowHeight = 160,
    super.key,
  });
  final List<ModelDataTableColumn> data;
  final PagedDataTableController<String, Widget> tableController;
  final int take;
  final FutureOr<(List<Widget>, String?)> Function(int, SortModel?, FilterModel, String?) fetcher;
  final Function(int index) onTapCellItem;
  final double rowHeight;

  @override
  Widget build(BuildContext context) => PagedDataTableTheme(
        data: PagedDataTableThemeData(
          rowColor: (index) => index.isEven ? R.themeColor.boxBg : R.color.transparent,
          rowHeight: rowHeight,
          horizontalScrollbarVisibility: false,
          cellPadding: const EdgeInsets.symmetric(vertical: 10),
          borderRadius: BorderRadius.circular(12),
          filterBarHeight: 0,
        ),
        child: PagedDataTable<String, Widget>(
          controller: tableController,
          initialPageSize: take,
          pageSizes: pageSizeList,
          fetcher: fetcher,
          fixedColumnCount: 2,
          columns: List.generate(
            data.length,
            (rowIndex) => TableColumn(
              title: Row(
                children: [
                  TextBasic(
                    text: data[rowIndex].title,
                    color: R.themeColor.secondaryHover,
                    fontFamily: R.fonts.displayMedium,
                    fontWeight: FontWeight.normal,
                  ),
                  if (data[rowIndex].sortable) SvgPicture.asset(R.drawable.svg.iconSortArrow),
                ],
              ),
              cellBuilder: (context, item, index) => InkWell(onTap: () => onTapCellItem(index), child: data[rowIndex].widgets[index]),
              sortable: data[rowIndex].sortable,
              id: data[rowIndex].id,
              size: data[rowIndex].size,
            ),
          ),
        ),
      );
}
