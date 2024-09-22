import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../core/enums/enum_app.dart';
import '../../core/extensions/extension_date.dart';
import '../../core/extensions/extension_num.dart';
import '../../core/models/model_account_book_list.dart';
import '../../core/resources/_r.dart';
import '../../core/services/service_route.dart';
import '../bs/bs_accounting_report.dart';
import 'widget_button.dart';
import 'widgets_text.dart';

class WidgetAccountBookDetail extends StatefulWidget {
  const WidgetAccountBookDetail({super.key, this.data});
  final ModelAccountBookList? data;

  @override
  State<WidgetAccountBookDetail> createState() => _WidgetAccountBookDetailState();
}

class _WidgetAccountBookDetailState extends State<WidgetAccountBookDetail> {
  bool isExpanded = false;

  void setExpandState() {
    isExpanded = !isExpanded;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          GestureDetector(
            onTap: setExpandState,
            child: Row(
              children: [
                Icon(
                  isExpanded ? CupertinoIcons.minus_circle : CupertinoIcons.plus_circle_fill,
                  color: !isExpanded ? R.themeColor.primary : R.themeColor.secondary,
                ),
                const SizedBox(width: 5),
                Expanded(
                  flex: 2,
                  child: TextBasic(
                    text: '${widget.data?.description?.category ?? ''}*${widget.data?.description?.description ?? ''}',
                    fontSize: 14,
                    color: R.themeColor.secondary,
                    fontFamily: R.fonts.displayBold,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextBasic(
                    text: widget.data!.transactionDate.dayNameMonthNameAndHour(),
                    fontSize: 14,
                    color: R.themeColor.secondary,
                    fontFamily: R.fonts.displayBold,
                  ),
                ),
                Expanded(
                  child: TextBasic(
                    text: widget.data?.amount!.amount.formatPrice() ?? '',
                    fontSize: 14,
                    color: (widget.data?.amount?.amount ?? -1) > 0 ? R.themeColor.success : R.themeColor.error,
                    fontFamily: R.fonts.displayBold,
                  ),
                ),
                Expanded(
                  child: TextBasic(
                    text: widget.data?.balance?.amount.formatPrice() ?? '',
                    fontSize: 14,
                    color: (widget.data?.balance?.amount ?? -1) > 0 ? R.themeColor.success : R.themeColor.error,
                    fontFamily: R.fonts.displayBold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          AnimatedSwitcher(duration: const Duration(milliseconds: 300), child: !isExpanded ? Container() : _getExpandedWidget(context)),
        ],
      );

  Widget _getExpandedWidget(BuildContext context) => Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: R.themeColor.border),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextBasic(
                      text: 'İşlemi Yapan',
                      fontSize: 10,
                      color: R.themeColor.secondaryHover,
                    ),
                  ),
                  Expanded(
                    child: TextBasic(
                      text: widget.data?.causer ?? '',
                      fontSize: 18,
                      color: widget.data?.causer == 'Sistem' ? R.themeColor.warning : R.themeColor.infoHover,
                    ),
                  ),
                ],
              ),
            ),
            if (widget.data?.causer != 'Sistem')
              ButtonBasic(
                text: R.string.update,
                bgColor: R.themeColor.primaryLight,
                textColor: R.themeColor.primary,
                onPressed: () async {
                  unawaited(
                    Provider.of<ServiceRoute>(context, listen: false).showBaseBottomSheet(
                      context,
                      isDismissible: false,
                      BsAccountingReport(
                        type: AccountBookProcessType.create,
                        transactionType: widget.data?.accountTransactionCategoryId ?? -1,
                      ),
                    ),
                  );
                },
              ),
            const SizedBox(width: 10),
            if (widget.data?.causer != 'Sistem')
              ButtonBasic(
                text: R.string.delete,
                bgColor: R.themeColor.errorLight,
                textColor: R.themeColor.error,
                onPressed: () {},
              ),
          ],
        ),
      );
}
