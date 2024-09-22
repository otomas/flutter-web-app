import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/enums/enum_app.dart';
import '../../core/extensions/extension_date.dart';
import '../../core/extensions/extension_string.dart';
import '../../core/models/response/model_response_inspection_completion.dart';
import '../../core/resources/_r.dart';
import '../../core/services/service_api.dart';
import '../base/base_view.dart';
import '../base/base_view_model.dart';
import 'widgets_text.dart';

class WidgetForMeInspectionDate extends WidgetBase<VmWidgetForMeInspectionDate> {
  const WidgetForMeInspectionDate({
    super.key,
    super.isActiveLoadingIndicator = true,
  });

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  VmWidgetForMeInspectionDate createViewModel(BuildContext context) => VmWidgetForMeInspectionDate(apiService(context));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmWidgetForMeInspectionDate viewModel) => buildWidget(context, viewModel);

  @override
  Widget buildWidget(BuildContext context, VmWidgetForMeInspectionDate viewModel) => viewModel.isLoading()
      ? const SizedBox(width: double.infinity, height: 200)
      : Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: R.themeColor.errorLight,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    R.drawable.svg.iconNotification,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      R.themeColor.error,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextBasic(
                      text: 'Araç Muayene Geçmiş & Yaklaşan Tarihler',
                      color: R.themeColor.error,
                      fontFamily: R.fonts.displayBold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ...List.generate(
                min(viewModel.data?.expired.length ?? 0, 1),
                (index) {
                  final item = viewModel.data!.expired[index];
                  return RichTextBasic(
                    textAlign: TextAlign.start,
                    texts:
                        '${item.plateNumber} plakalı aracınızın muayene bitiş tarihi ${item.inspectionEndDate.dayMonthNameAndYear()} tarihi itibariyle geçmiştir.'
                            .highlightOccurrences(
                      item.plateNumber,
                      textColor: R.themeColor.secondaryHover,
                      boldTextColor: R.themeColor.error,
                      fontSize: 14,
                      boldFontSize: 14,
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              ...List.generate(
                min(viewModel.data?.upcoming.length ?? 0, 1),
                (index) {
                  final item = viewModel.data!.upcoming[index];
                  return RichTextBasic(
                    textAlign: TextAlign.start,
                    texts:
                        '${item.plateNumber} plakalı aracınızın muayene bitiş tarihi yaklaşıyor. Muayene tarihi: ${item.inspectionEndDate.dayMonthNameAndYear()}'
                            .highlightOccurrences(
                      item.plateNumber,
                      textColor: R.themeColor.secondaryHover,
                      boldTextColor: R.themeColor.error,
                      fontSize: 14,
                      boldFontSize: 14,
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(child: Container()),
                    InkWell(
                      onTap: () {},
                      hoverColor: R.color.transparent,
                      focusColor: R.color.transparent,
                      splashColor: R.color.transparent,
                      highlightColor: R.color.transparent,
                      child: TextBasic(
                        text: 'Tümünü Gör',
                        color: R.themeColor.error,
                        fontFamily: R.fonts.displayBold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
}

class VmWidgetForMeInspectionDate extends ViewModelBase {
  VmWidgetForMeInspectionDate(this.serviceApi) {
    init();
  }

  final ServiceApi serviceApi;

  ModelInspectionCompletionResponse? data;

  @override
  void init() {
    unawaited(getData());
  }

  Future<void> getData() async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.getInspectionCompletion().then(
      (response) {
        data = response.data;
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
  }
}
