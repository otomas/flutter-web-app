import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/models/model_expandable_item.dart';
import '../../core/resources/_r.dart';
import 'widget_button.dart';
import 'widgets_text.dart';

class WidgetExpandableListView extends StatefulWidget {
  const WidgetExpandableListView({
    required this.title,
    required this.onPressedItem,
    this.items = const [],
    super.key,
    this.isPremium = false,
    this.icon, // Made icon nullable
    this.isSelected = false,
  });
  final String title;
  final String? icon; // Changed to nullable string
  final List<ModelExpandableListItem> items;
  final Function()? onPressedItem;
  final bool isPremium;
  final bool isSelected;

  @override
  State<WidgetExpandableListView> createState() => _WidgetExpandableListViewState();
}

class _WidgetExpandableListViewState extends State<WidgetExpandableListView> {
  bool isExpanded = false;
  bool get shouldShowIcon => widget.icon != null;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.isSelected || widget.items.any((e) => e.isSelected);
  }

  void setExpandState() {
    if (widget.items.isNotEmpty) {
      isExpanded = !isExpanded;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          InkWell(
            onTap: () {
              setExpandState();
              widget.onPressedItem?.call();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              decoration: BoxDecoration(
                color: isExpanded ? R.themeColor.primaryLight : R.themeColor.viewBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  if (shouldShowIcon)
                    SvgPicture.asset(
                      widget.icon!,
                      height: 20,
                      width: 20,
                      colorFilter: ColorFilter.mode(isExpanded ? R.themeColor.primary : R.themeColor.smokeDark, BlendMode.srcIn),
                    ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextBasic(
                      text: widget.title,
                      color: isExpanded ? R.themeColor.primary : R.themeColor.smokeDark,
                      fontFamily: R.fonts.displayBold,
                      fontSize: 14,
                    ),
                  ),
                  if (widget.items.isNotEmpty)
                    Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: isExpanded ? R.themeColor.smokeDark : R.themeColor.smokeDark,
                    ),
                  if (widget.isPremium) const ButtonPremium(),
                ],
              ),
            ),
          ),
          if (isExpanded) const SizedBox(height: 5),
          if (widget.items.isNotEmpty && isExpanded)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: R.themeColor.primaryLight,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  final item = widget.items[index];
                  return InkWell(
                    onTap: item.onTap,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        border: index == widget.items.length - 1 ? null : Border(bottom: BorderSide(color: R.themeColor.boxBg)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextBasic(
                              text: item.title,
                              color: item.isSelected ? R.themeColor.primary : R.themeColor.smokeDark,
                              fontFamily: item.isSelected ? R.fonts.displayBold : R.fonts.displayMedium,
                              fontSize: 14,
                            ),
                          ),
                          if (item.isNew)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: R.themeColor.success,
                              ),
                              child: TextBasic(
                                text: R.string.textNew.toUpperCase(),
                                color: R.themeColor.viewBg,
                                fontFamily: R.fonts.displayBold,
                                fontSize: 10,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          if (isExpanded) const SizedBox(height: 5),
        ],
      );
}
