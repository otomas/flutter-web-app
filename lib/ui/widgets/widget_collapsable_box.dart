import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/enums/enum_app.dart';
import '../../core/models/model_base_dropdown.dart';
import '../../core/resources/_r.dart';
import '../base/base_view.dart';
import '../base/base_view_model.dart';
import 'activity_indicator.dart';
import 'widgets_text.dart';

class WidgetCollapsableBox<T extends BaseDropdown> extends WidgetBase<VmWidgetCollapsableBox> {
  const WidgetCollapsableBox({
    required this.title,
    required this.onChanged,
    this.selectedItems,
    this.items,
    this.callback,
    super.key,
    super.isActiveLoadingIndicator = false,
  });

  final String title;
  final List<T>? items;
  final List<T>? selectedItems;
  final Future Function()? callback;
  final Function(List<T> items) onChanged;

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  VmWidgetCollapsableBox<T> createViewModel(BuildContext context) => VmWidgetCollapsableBox<T>(selectedItems, items, callback, onChanged);

  @override
  Widget buildWidgetForWeb(BuildContext context, VmWidgetCollapsableBox viewModel) => Column(
        children: [
          GestureDetector(
            onTap: () {
              if (!viewModel.isLoading()) {
                viewModel.setIsExpanded();
              } else {}
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(child: TextBasic(text: title, color: R.themeColor.secondaryHover, fontFamily: R.fonts.displayMedium, fontSize: 14)),
                  const SizedBox(width: 4),
                  if (viewModel.isLoading()) const IOSIndicator() else Icon(viewModel.isExpanded ? Icons.remove : Icons.add, color: R.themeColor.primary),
                ],
              ),
            ),
          ),
          if (viewModel.isLoaded())
            AnimatedContainer(
              height: viewModel.isExpanded ? null : 0,
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: R.themeColor.primaryLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: List.generate(viewModel.items.length, (index) {
                  final item = viewModel.items[index];
                  return GestureDetector(
                    onTap: () => viewModel.onChanged(item),
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          padding: const EdgeInsets.all(4),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: viewModel.selectedItems.any((e) => e.dropdownId == item.dropdownId) ? R.themeColor.primary : R.themeColor.viewBg,
                          ),
                          child: Center(child: Icon(Icons.check, color: R.themeColor.viewBg, size: 12)),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: TextBasic(
                            text: item.dropdownTitle,
                            color: viewModel.selectedItems.any((e) => e.dropdownId == item.dropdownId) ? R.themeColor.primary : R.themeColor.secondary,
                            fontFamily: R.fonts.displayMedium,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
        ],
      );

  @override
  Widget buildWidget(BuildContext context, VmWidgetCollapsableBox viewModel) => buildWidgetForWeb(context, viewModel);
}

class VmWidgetCollapsableBox<T extends BaseDropdown> extends ViewModelBase {
  VmWidgetCollapsableBox(List<T>? selectedItems, List<T>? items, this.callback, this.widgetOnChanged) {
    if (selectedItems != null) {
      this.selectedItems = selectedItems;
    }
    if (items != null) {
      this.items = items;
    } else if (callback != null) {
      unawaited(initList());
    }
  }

  bool isExpanded = false;

  final Function(List<T> items) widgetOnChanged;
  ActivityState loadingState = ActivityState.isLoading;
  List<T> selectedItems = [];
  List<T> items = [];

  final Future Function()? callback;

  @override
  void init() {}

  void setIsExpanded([bool? isExpanded]) {
    this.isExpanded = isExpanded ?? !this.isExpanded;
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }

  Future<void> initList() async {
    setActivityState(ActivityState.isLoading);
    if (callback != null) {
      await callback!.call().then(
        (response) {
          items = response.data;
          setActivityState(ActivityState.isLoaded);
        },
        onError: (error) {
          setActivityState(ActivityState.isError);
        },
      );
    }
  }

  void onChanged(T item, [bool isNotiftyView = true]) {
    final isAdded = selectedItems.any((e) => e.dropdownId == item.dropdownId);
    if (isAdded) {
      selectedItems.removeWhere((e) => e.dropdownId == item.dropdownId);
    } else {
      selectedItems.add(item);
    }
    if (isNotiftyView) {
      widgetOnChanged.call(selectedItems);
    }
    notifyListeners();
  }
}
