import 'dart:async';

import 'package:flutter/material.dart';

import '/core/extensions/extension_date.dart';
import '/core/models/model_alert_dialog.dart';
import '/core/resources/_r.dart';
import '/core/utils/alert_utils.dart';
import '/ui/widgets/widget_textfield.dart';
import '/ui/widgets/widgets_text.dart';
import '../../core/enums/enum_app.dart';
import '../base/base_view.dart';

class WidgetDateSelection extends StatefulWidget {
  const WidgetDateSelection({
    required this.title,
    required this.bgColor,
    required this.titleColor,
    super.key,
    this.selectedStartDate,
    this.selectedEndDate,
    this.onChangedStartDate,
    this.onChangedEndDate,
    this.isPreview = false,
    this.startDateErrorText,
    this.endDateErrorText,
  });
  final String title;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final Color bgColor;
  final Color titleColor;
  final Function(DateTime)? onChangedStartDate;
  final Function(DateTime)? onChangedEndDate;
  final bool isPreview;
  final String? startDateErrorText;
  final String? endDateErrorText;

  @override
  State<WidgetDateSelection> createState() => _WidgetDateSelectionState();
}

class _WidgetDateSelectionState extends State<WidgetDateSelection> with BaseView {
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    startDate = widget.selectedStartDate;
    endDate = widget.selectedEndDate;
  }

  void onChangedStartDate(DateTime date) {
    startDate = date;
    endDate = null;
    setState(() {});
    widget.onChangedStartDate?.call(date);
  }

  void onChangedEndDate(DateTime date) {
    endDate = date;
    setState(() {});
    widget.onChangedEndDate?.call(date);
  }

  Future<void> selectStartDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().add(const Duration(days: 365 * -10)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    if (date != null) {
      onChangedStartDate(date);
    }
  }

  Future<void> selectEndDate() async {
    if (startDate == null) {
      unawaited(showPlatformAlert(context, const ModelAlertDialog(description: 'Lütfen önce başlangıç tarihi seçin', dialogType: DialogTypes.warning)));
      return;
    }
    final date = await showDatePicker(
      context: context,
      initialDate: startDate!.add(const Duration(days: 366)),
      firstDate: startDate!,
      lastDate: startDate!.add(const Duration(days: 365 * 10)),
    );
    if (date != null && date.isAfter(startDate!)) {
      onChangedEndDate(date);
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(vertical: 7.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: widget.bgColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextBasic(
              text: widget.title,
              color: widget.titleColor,
              fontFamily: R.fonts.displayBold,
              fontSize: 16,
            ),
            const SizedBox(height: 10),
            if (!widget.isPreview)
              if (isWeb(context))
                Row(
                  children: List.generate(_getSelectionField(context).length, (index) => Expanded(child: _getSelectionField(context)[index])),
                )
              else
                ..._getSelectionField(context)
            else
              ..._getPreview(context),
          ],
        ),
      );

  List<Widget> _getSelectionField(BuildContext context) => [
        GestureDetector(
          onTap: () => unawaited(selectStartDate()),
          child: TextFieldBasic(
            title: 'Başlangıç Tarihi',
            hintText: startDate == null ? 'Seçiniz' : startDate.dayMonthNameAndYear(),
            suffixIcon: Icon(Icons.date_range, color: R.themeColor.primary),
            enabled: false,
            hasError: widget.startDateErrorText != null,
            errorLabel: widget.startDateErrorText,
          ),
        ),
        if (!isWeb(context)) const SizedBox(height: 15),
        GestureDetector(
          onTap: () => unawaited(selectEndDate()),
          child: TextFieldBasic(
            title: 'Bitiş Tarihi',
            hintText: endDate == null ? 'Seçiniz' : endDate.dayMonthNameAndYear(),
            suffixIcon: Icon(Icons.date_range, color: R.themeColor.primary),
            enabled: false,
            hasError: widget.endDateErrorText != null,
            errorLabel: widget.endDateErrorText,
          ),
        ),
      ];

  List<Widget> _getPreview(BuildContext context) => [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextBasic(
                  text: 'Başlangıç Tarihi',
                  color: R.themeColor.smoke,
                  fontFamily: R.fonts.displayMedium,
                  fontSize: 12,
                ),
                const SizedBox(height: 5),
                TextBasic(
                  text: widget.selectedStartDate.dayMonthNameAndYear(),
                  color: R.themeColor.secondary,
                  fontFamily: R.fonts.displayBold,
                  fontSize: 14,
                ),
              ],
            ),
            Expanded(child: Container()),
            Icon(Icons.arrow_forward_outlined, color: R.themeColor.smoke),
            Expanded(child: Container()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextBasic(
                  text: 'Bitiş Tarihi',
                  color: R.themeColor.smoke,
                  fontFamily: R.fonts.displayMedium,
                  fontSize: 12,
                ),
                const SizedBox(height: 5),
                TextBasic(
                  text: widget.selectedEndDate.dayMonthNameAndYear(),
                  color: R.themeColor.secondary,
                  fontFamily: R.fonts.displayBold,
                  fontSize: 14,
                ),
              ],
            ),
          ],
        ),
      ];
}
