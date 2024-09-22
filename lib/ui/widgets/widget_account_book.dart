import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/extensions/extension_balance.dart';
import '../../core/models/model_turnover.dart';
import '../../core/resources/_r.dart';
import 'widget_graph.dart';
import 'widgets_text.dart';

class WidgetAccountBook extends StatefulWidget {
  const WidgetAccountBook({required this.title, required this.subTitle, required this.data, super.key, this.table});
  final WidgetCustomGraph? data;
  final List<ModelTurnoverItem>? table;
  final String title;
  final String subTitle;

  @override
  State<WidgetAccountBook> createState() => _WidgetAccountBookState();
}

class _WidgetAccountBookState extends State<WidgetAccountBook> {
  bool isExpanded = true;

  Widget _getWidgetList(BuildContext context) => Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: R.themeColor.border),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextBasic(
                        textAlign: TextAlign.start,
                        text: R.string.name,
                        fontFamily: R.fonts.displayMedium,
                        fontSize: 12,
                      ),
                    ),
                    Expanded(
                      child: TextBasic(
                        textAlign: TextAlign.end,
                        text: R.string.income,
                        fontFamily: R.fonts.displayMedium,
                        fontSize: 12,
                      ),
                    ),
                    Expanded(
                      child: TextBasic(
                        textAlign: TextAlign.end,
                        text: R.string.expense,
                        fontFamily: R.fonts.displayMedium,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextBasic(
                        textAlign: TextAlign.end,
                        text: R.string.total,
                        fontSize: 12,
                        fontFamily: R.fonts.displayMedium,
                      ),
                    ),
                  ],
                ),
                Divider(color: R.themeColor.borderLight),
                if (widget.table != null)
                  ListView.builder(
                    itemCount: widget.table?.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final item = widget.table?[index];
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: TextBasic(
                                  text: item?.name ?? '-',
                                  fontFamily: R.fonts.displayMedium,
                                  fontSize: 12,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 15),
                                  child: TextBasic(
                                    text: item?.credit.formatPriceWithoutCents() ?? '-',
                                    fontSize: 12,
                                    color: (item?.credit?.amount ?? 0) < 0 ? R.color.candy : R.color.river,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 15),
                                  child: TextBasic(
                                    text: item?.debit.formatPriceWithoutCents() ?? '-',
                                    fontSize: 12,
                                    color: (item?.debit?.amount ?? 0) < 0 ? R.color.candy : R.color.river,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextBasic(
                                  text: item?.total.formatPriceWithoutCents().trimRight() ?? '-',
                                  fontSize: 12,
                                  color: (item?.total?.amount ?? 0) < 0 ? R.color.candy : R.color.river,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                          if (index != (widget.table?.length ?? 0) - 1) Divider(color: R.themeColor.borderLight) else Container(),
                        ],
                      );
                    },
                  ),
              ],
            ),
          ),
          widget.data ?? Container(),
        ],
      );

  void setExpandState() {
    isExpanded = !isExpanded;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    TextBasic(
                      text: widget.title,
                      fontFamily: R.fonts.displayBold,
                      color: R.themeColor.smoke,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: R.themeColor.primaryLight,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: R.themeColor.borderLight),
                      ),
                      child: TextBasic(
                        text: widget.subTitle,
                        color: R.themeColor.primary,
                        fontFamily: R.fonts.displayMedium,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: setExpandState,
                  child: Icon(
                    isExpanded ? CupertinoIcons.minus_circle_fill : CupertinoIcons.plus,
                    color: R.themeColor.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            AnimatedSwitcher(duration: const Duration(milliseconds: 300), child: !isExpanded ? Container() : _getWidgetList(context)),
            const SizedBox(height: 20),
          ],
        ),
      );
}
