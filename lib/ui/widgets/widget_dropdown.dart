import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/enums/enum_app.dart';
import '../../core/extensions/extension_iterable.dart';
import '../../core/extensions/extension_string.dart';
import '../../core/models/model_base_dropdown.dart';
import '../../core/models/model_vehicle_fuel_type.dart';
import '../../core/resources/_r.dart';
import '../base/base_view.dart';
import '../base/base_view_model.dart';
import '../bs/bs_dropdown.dart';
import 'activity_indicator.dart';
import 'widget_textfield.dart';

class DropdownBasic<T extends BaseDropdown> extends StatefulWidget {
  const DropdownBasic({
    required this.onChanged,
    super.key,
    this.selectedItem,
    this.items,
    this.callback,
    this.title,
    this.isActiveTitle = true,
    this.hint,
    this.onRemove,
    this.enabled = true,
    this.isRequired = false,
    this.child,
    this.suffixIcon,
    this.prefixIcon,
    this.isActiveSuffixIcon = true,
    this.isActivePrefixIcon = true,
    this.hasError = false,
    this.errorLabel,
    this.color,
    this.isActiveSort = true,
    this.isCustomPagination = false,
    this.isActiveDescription = false,
    this.customOnTap,
  });
  final T? selectedItem;
  final List<T>? items;
  final String? title;
  final bool isActiveTitle;
  final String? hint;
  final Future Function()? callback;
  final Function()? onRemove;
  final Function(T?, bool isAutoComplete) onChanged;
  final bool enabled;
  final bool isRequired;
  final Widget? child;
  final bool hasError;
  final String? errorLabel;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isActiveSuffixIcon;
  final bool isActivePrefixIcon;
  final Color? color;
  final bool isActiveSort;
  final bool isCustomPagination;
  final bool isActiveDescription;
  final Function()? customOnTap;

  @override
  State<DropdownBasic> createState() => _DropdownBasicState<T>();
}

class _DropdownBasicState<T extends BaseDropdown> extends WidgetBaseStatefull<DropdownBasic<T>, VmDropdownBasic> {
  @override
  VmDropdownBasic<T> createViewModel(BuildContext context) => VmDropdownBasic<T>(widget.selectedItem, widget.items, widget.callback, widget.isCustomPagination, widget.onChanged);

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  void initState() {
    super.initState();
    isActiveLoadingIndicator = false;
  }

  @override
  Widget buildWidgetForWeb(BuildContext context, VmDropdownBasic<BaseDropdown> viewModel) => _getBody(context, viewModel);

  @override
  Widget buildWidget(BuildContext context, VmDropdownBasic<BaseDropdown> viewModel) => _getBody(context, viewModel);

  Widget _getBody(BuildContext context, VmDropdownBasic viewModel) => GestureDetector(
        onTap: widget.customOnTap ?? (widget.enabled && !viewModel.isLoading() ? () => showBottomSheet(context, viewModel) : null),
        child: Row(
          children: [
            widget.child ??
                Expanded(
                  child: TextFieldBasic(
                    enabled: false,
                    hasError: widget.hasError,
                    errorLabel: widget.errorLabel,
                    isRequired: widget.isRequired,
                    fillColor: widget.color,
                    controller: viewModel.itemController,
                    title: widget.isActiveTitle ? widget.title : null,
                    hintText: widget.hint,
                    suffixIcon: widget.isActiveSuffixIcon ? (viewModel.isLoading() ? const IOSIndicator() : const Icon(Icons.keyboard_arrow_down)) : widget.suffixIcon,
                    prefixIcon: widget.isActivePrefixIcon ? widget.prefixIcon ?? (widget.callback == null ? null : widget.suffixIcon ?? const Icon(Icons.search)) : null,
                  ),
                ),
            if (widget.onRemove != null && viewModel.selectedItem != null)
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  viewModel.onChanged(null);
                  widget.onRemove!();
                },
                icon: Icon(Icons.clear, color: R.themeColor.primary),
              ),
          ],
        ),
      );

  void showBottomSheet(BuildContext context, VmDropdownBasic viewModel) {
    unawaited(
      router(context).showBaseBottomSheet(
        context,
        BottomSheetDropdown<T>(
          title: widget.title,
          onChanged: (item) {
            viewModel.onChanged(item);
          },
          list: viewModel.items as List<T>,
          selectedItem: viewModel.selectedItem as T?,
        ),
      ),
    );
  }
}

class VmDropdownBasic<T extends BaseDropdown> extends ViewModelBase {
  VmDropdownBasic(this.selectedItem, List<T>? items, this.callback, this.isCustomPagination, this.widgetOnChanged) {
    if (items != null) {
      this.items = items;
      if (selectedItem is ModelVehicleFuelType) {
        log('message');
      }
      if (selectedItem != null && selectedItem!.dropdownTitle.isNullOrEmpty()) {
        final itemInList = items.firstWhereOrNull((e) => e.dropdownId == selectedItem?.dropdownId);
        if (itemInList != null) {
          onChanged(itemInList);
        }
      } else {
        onChanged(selectedItem, false);
      }
    } else if (callback != null) {
      unawaited(initList());
    }
  }

  final Function(T?, bool isAutoComplete) widgetOnChanged;
  final TextEditingController itemController = TextEditingController();
  final bool isCustomPagination;
  ActivityState loadingState = ActivityState.isLoading;
  T? selectedItem;
  List<T> items = [];
  List<dynamic>? paginationMap;

  final Future Function()? callback;

  @override
  void init() {}

  void notify() {
    notifyListeners();
  }

  Future<void> initList() async {
    itemController.text = selectedItem?.dropdownTitle ?? '';
    setActivityState(ActivityState.isLoading);
    if (callback != null) {
      await callback!.call().then(
        (response) {
          items = response.data;
          if (selectedItem?.dropdownId != null && (selectedItem != null && selectedItem!.dropdownTitle.isNullOrEmpty())) {
            final item = items.firstWhereOrNull((element) => element.dropdownId == selectedItem?.dropdownId);
            if (item != null) {
              onChanged(item);
            }
          }
          setActivityState(ActivityState.isLoaded);
        },
        onError: (error) {
          setActivityState(ActivityState.isError);
        },
      );
    }
  }

  void onChanged(T? item, [bool isNotiftyView = true]) {
    final isAutoComplete = selectedItem?.dropdownId != null && (selectedItem != null && selectedItem!.dropdownTitle.isNullOrEmpty());
    selectedItem = item;
    itemController.text = item == null ? '' : item.dropdownTitle;
    if (isNotiftyView) {
      widgetOnChanged.call(selectedItem, isAutoComplete);
    }
    notifyListeners();
  }
}
