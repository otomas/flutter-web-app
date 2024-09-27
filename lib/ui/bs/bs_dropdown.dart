// ignore_for_file: prefer_expression_function_bodies

import 'package:flutter/material.dart';
import '../../core/models/model_base_dropdown.dart';
import '../../core/resources/_r.dart';
import '../../ui/base/base_view.dart';
import '../../ui/widgets/widget_scroll.dart';
import '../widgets/widget_button.dart';
import '../widgets/widget_textfield.dart';

class BottomSheetDropdown<T extends BaseDropdown> extends StatefulWidget {
  const BottomSheetDropdown({required this.list, required this.onChanged, super.key, this.title, this.selectedItem, this.isActiveSort = true});
  final String? title;
  final List<T> list;
  final T? selectedItem;
  final Function(T) onChanged;
  final bool isActiveSort;

  @override
  State<BottomSheetDropdown> createState() => _BottomSheetDropdownState<T>();
}

class _BottomSheetDropdownState<T extends BaseDropdown> extends State<BottomSheetDropdown<T>> with BaseView {
  List<T> list = [];
  List<T> _filtredList = [];
  T? selectedItem;

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    list = widget.list;
    _filtredList = widget.list;
    selectedItem = widget.selectedItem;
    filterList();

    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        _filtredList = list;
        setState(() {});
        filterList();
      } else {
        _filtredList = list.where((element) => element.dropdownTitle.toLowerCase().contains(searchController.text.toLowerCase())).toList();
        filterList();
        setState(() {});
      }
    });
  }

  void filterList() {
    if (widget.isActiveSort) {
      _filtredList.sort((a, b) => a.dropdownTitle.compareTo(b.dropdownTitle));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: R.themeColor.viewBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(blurRadius: 24, color: R.themeColor.viewText.withOpacity(0.15)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: TextFieldBasic(
                controller: searchController,
                hintText: 'Aramak için bir şeyler girin',
                suffixIcon: const Icon(Icons.search),
              ),
            ),
            Expanded(
              child: ScrollWithNoGlowWidget(
                child: Wrap(
                  children: List.generate(
                    _filtredList.length,
                    (index) {
                      final item = _filtredList[index];
                      return DropdownButtonBasic<T>(
                        item: item,
                        itemTitle: item.dropdownTitle,
                        isSelected: selectedItem?.dropdownId == item.dropdownId,
                        isActiveBorder: index != _filtredList.length - 1,
                        onSelected: (v) {
                          widget.onChanged(v);
                        },
                      );
                    },
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
