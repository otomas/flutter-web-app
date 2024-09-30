import 'package:flutter/material.dart';
import '../../core/models/model_base_dropdown.dart';
import '../../core/resources/_r.dart';
import 'widgets_text.dart';

class CheckboxBasic<T extends BaseDropdown> extends StatefulWidget {
  const CheckboxBasic({
    required this.onChanged,
    required this.item,
    required this.value,
    super.key,
    this.isRadioButton = false,
    this.isInnerScroll = false,
    this.fontSize = 14,
    this.iconSize = 24,
  });
  final T item;
  final bool value;
  final bool isRadioButton;
  final bool isInnerScroll;
  final Function(bool) onChanged;
  final double fontSize;
  final double iconSize;

  @override
  State<CheckboxBasic> createState() => _CheckboxBasicState();
}

class _CheckboxBasicState extends State<CheckboxBasic> {
  late bool value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  void onChanged() {
    value = !value;
    widget.onChanged(value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onChanged,
        child: ColoredBox(
          color: R.color.transparent,
          child: Row(
            children: [
              Container(
                height: widget.iconSize,
                width: widget.iconSize,
                padding: EdgeInsets.all(widget.iconSize / 6),
                decoration: BoxDecoration(
                  border: widget.isRadioButton
                      ? Border.all(width: value ? 5.0 : 1.0, color: value ? R.themeColor.primary : R.color.gray)
                      : value
                          ? null
                          : Border.all(color: R.color.gray),
                  shape: widget.isRadioButton ? BoxShape.circle : BoxShape.rectangle,
                  borderRadius: widget.isRadioButton ? null : BorderRadius.circular(8),
                ),
                child: widget.isRadioButton ? Container(decoration: BoxDecoration(shape: BoxShape.circle, color: value ? R.themeColor.primary : R.themeColor.viewBg)) : Center(child: Icon(Icons.check, color: R.color.white, size: 16)),
              ),
              const SizedBox(width: 10),
              if (!widget.isInnerScroll) Expanded(child: _getTitle()) else _getTitle(),
            ],
          ),
        ),
      );

  Widget _getTitle() => TextBasic(
        text: widget.item.dropdownTitle,
        color: value ? R.color.midnight : R.color.gray,
        fontSize: widget.iconSize,
        fontFamily: !value ? null : R.fonts.displayBold,
        fontWeight: value ? FontWeight.w600 : FontWeight.w400,
      );
}
