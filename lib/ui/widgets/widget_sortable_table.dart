import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/resources/_r.dart';
import '../base/base_view.dart';
import 'widget_scroll.dart';
import 'widgets_text.dart';

class WidgetSortableTable extends StatefulWidget {
  const WidgetSortableTable({required this.items, required this.titles, this.onPressedItem, super.key});

  final List<String> titles;
  final List<List<String>> items;
  final Function(int rowIndex, int columnIndex)? onPressedItem;

  @override
  State<WidgetSortableTable> createState() => _WidgetSortableTableState();
}

class _WidgetSortableTableState extends State<WidgetSortableTable> with BaseView {
  List<String> titles = [];
  List<List<String>> items = [];

  List<int> indexs = [];

  @override
  void initState() {
    super.initState();
    titles = widget.titles;
    items = widget.items;
  }

  void sortList(int index) {
    final list = indexs.where((element) => element == index).toList();
    final isReverse = list.length.isOdd;
    indexs.add(index);

    if (isReverse) {
      items.sort((b, a) => a[index].compareTo(b[index]));
    } else {
      items.sort((a, b) => a[index].compareTo(b[index]));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final rowWidth = (size(context).width - size(context).width * 0.06 - 56) / (titles.length < 4 ? titles.length : 4);
    return ScrollWithNoGlowWidget(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      child: ScrollWithNoGlowWidget(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: List.generate(
                titles.length,
                (index) => GestureDetector(
                  onTap: () => sortList(index),
                  child: Container(
                    width: rowWidth,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    child: Row(
                      children: [
                        TextBasic(
                          text: titles[index],
                          color: R.themeColor.secondary,
                          fontFamily: R.fonts.displayMedium,
                          fontSize: 12,
                          maxLines: 1,
                        ),
                        SvgPicture.asset(R.drawable.svg.iconSortArrow),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            IntrinsicHeight(
              child: Row(
                children: List.generate(
                  titles.length,
                  (rowIndex) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      items.length,
                      (index) => InkWell(
                        onTap: () => widget.onPressedItem?.call(rowIndex, index),
                        child: Container(
                          width: rowWidth,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: index.isEven ? R.themeColor.boxBg : R.color.transparent,
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(rowIndex == 0 ? 12 : 0),
                              right: Radius.circular(rowIndex == titles.length - 1 ? 12 : 0),
                            ),
                          ),
                          child: TextBasic(
                            text: items[index][rowIndex],
                            color: R.themeColor.secondary,
                            fontSize: 12,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
