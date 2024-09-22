// ignore_for_file: prefer_expression_function_bodies

import 'package:flutter/material.dart';
import '../../core/models/model_base_dropdown.dart';
import '../../core/resources/_r.dart';
import '../../ui/base/base_view.dart';
import '../../ui/widgets/widget_scroll.dart';
import '../../ui/widgets/widgets_text.dart';
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
    return Column(
      children: [
        Container(
          width: size(context).width,
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: R.themeColor.secondaryLight.withOpacity(0.2)))),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.clear, color: R.color.transparent),
              Expanded(
                child: TextBasic(
                  text: widget.title ?? '',
                  color: R.color.black,
                  fontFamily: R.fonts.displayBold,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.clear, color: R.themeColor.secondaryLight),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(18),
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
                      Navigator.pop(context);
                      widget.onChanged(v);
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
