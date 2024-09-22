import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/enums/enum_app.dart';
import '../../core/extensions/extension_date.dart';
import '../../core/extensions/extension_string.dart';
import '../../core/models/response/model_response_insurance_completion.dart';
import '../../core/resources/_r.dart';
import '../../core/services/service_api.dart';
import '../base/base_view.dart';
import '../base/base_view_model.dart';
import 'widgets_text.dart';

class WidgetForMeInsuranceDate extends WidgetBase<VmWidgetForMeInsuranceDates> {
  const WidgetForMeInsuranceDate({
    super.key,
    super.isActiveLoadingIndicator = true,
  });

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  VmWidgetForMeInsuranceDates createViewModel(BuildContext context) => VmWidgetForMeInsuranceDates(apiService(context));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmWidgetForMeInsuranceDates viewModel) => buildWidget(context, viewModel);

  @override
  Widget buildWidget(BuildContext context, VmWidgetForMeInsuranceDates viewModel) => viewModel.isLoading()
      ? const SizedBox(width: double.infinity, height: 200)
      : Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: R.themeColor.infoLight,
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
                      R.themeColor.info,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextBasic(
                      text: 'Araç Sigorta Geçmiş & Yaklaşan Tarihler',
                      color: R.themeColor.info,
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
                        '${item.plateNumber} plakalı aracınızın sigorta bitiş tarihi ${item.insuranceEndDate.dayMonthNameAndYear()} tarihi itibariyle geçmiştir.'
                            .highlightOccurrences(
                      item.plateNumber,
                      textColor: R.themeColor.secondaryHover,
                      boldTextColor: R.themeColor.info,
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
                        '${item.plateNumber} plakalı aracınızın sigorta bitiş tarihi yaklaşıyor. Sigorta tarihi: ${item.insuranceEndDate.dayMonthNameAndYear()}'
                            .highlightOccurrences(
                      item.plateNumber,
                      textColor: R.themeColor.secondaryHover,
                      boldTextColor: R.themeColor.info,
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
                        color: R.themeColor.info,
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

class VmWidgetForMeInsuranceDates extends ViewModelBase {
  VmWidgetForMeInsuranceDates(this.serviceApi) {
    init();
  }

  final ServiceApi serviceApi;

  ModelInsuranceCompletionResponse? data;

  @override
  void init() {
    unawaited(getData());
  }

  Future<void> getData() async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.getInsuranceCompletion().then(
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
