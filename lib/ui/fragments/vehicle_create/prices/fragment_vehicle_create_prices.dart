import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/ui_brightness_style.dart';
import '../../../../core/extensions/extension_date.dart';
import '../../../../core/models/request/model_request_vehicle.dart';
import '../../../../core/resources/_r.dart';
import '../../../../core/utils/alert_utils.dart';
import '../../../../core/utils/formatters.dart';
import '../../../base/base_view.dart';
import '../../../bs/bs_dropdown.dart';
import '../../../widgets/widget_payment_card.dart';
import '../../../widgets/widget_scroll.dart';
import '../../../widgets/widget_textfield.dart';
import '../../../widgets/widget_vehicle_create_fragment_base.dart';
import '../../../widgets/widgets_text.dart';
import 'vm_fragment_vehicle_create_prices.dart';

@RoutePage()
class FragmentVehicleCreatePrices extends StatefulWidget {
  const FragmentVehicleCreatePrices({
    required this.params,
    required this.onPressedPreviousButton,
    required this.onPressedNextButton,
    super.key,
  });

  final ModelRequestVehicleParams params;
  final Function() onPressedPreviousButton;
  final Function(ModelRequestVehicleParams newParams) onPressedNextButton;

  @override
  State<FragmentVehicleCreatePrices> createState() => _FragmentVehicleCreatePricesState();
}

class _FragmentVehicleCreatePricesState extends WidgetBaseStatefull<FragmentVehicleCreatePrices, VmFragmentVehicleCreatePrices> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentVehicleCreatePrices createViewModel(BuildContext context) => VmFragmentVehicleCreatePrices(apiService(context), widget.params);

  @override
  Widget buildWidget(BuildContext context, VmFragmentVehicleCreatePrices viewModel) {
    final fields = _getForm(context, viewModel);
    return _getBase(
      context,
      viewModel,
      ScrollWithNoGlowWidget(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getTitle(context, viewModel),
            const SizedBox(height: 20),
            ...List.generate(
              fields.length,
              (index) => Column(
                children: [
                  ...List.generate(
                    fields[index].length,
                    (i) {
                      final item = fields[index][i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: item,
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Divider(color: R.themeColor.border),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentVehicleCreatePrices viewModel) {
    final fields = _getForm(context, viewModel);
    return _getBase(
      context,
      viewModel,
      ScrollWithNoGlowWidget(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getTitle(context, viewModel),
            const SizedBox(height: 20),
            ...List.generate(
              fields.length,
              (index) => Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: List.generate(
                        fields[index].length,
                        (i) {
                          final item = fields[index][i];
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: item,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Divider(color: R.themeColor.border),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBase(BuildContext context, VmFragmentVehicleCreatePrices viewModel, Widget child) => WidgetVehicleCreateFragmentBase(
        nextButtonText: 'Kaydet',
        onPressedNextButton: () {
          if (viewModel.checkFields()) {
            widget.onPressedNextButton(viewModel.params);
          }
        },
        onPressedPreviousButton: widget.onPressedPreviousButton,
        previousButtonText: 'Önceki Adım',
        stepTitle: '4. Adım',
        title: 'Araç Fiyat Bilgileri',
        child: child,
      );

  Widget _getTitle(BuildContext context, VmFragmentVehicleCreatePrices viewModel) => TextBasic(
        text: 'Aracınızın Özellikleri',
        color: R.themeColor.primary,
        fontFamily: R.fonts.displayMedium,
        fontSize: 16,
      );

  List<List<Widget>> _getForm(BuildContext context, VmFragmentVehicleCreatePrices viewModel) => [
        [
          GestureDetector(
            onTap: () async {
              await showCustomDatePicker(
                context,
                initial: viewModel.params.buyingDate,
                min: DateTime.now().add(const Duration(days: 365 * -10)),
                max: DateTime.now(),
                onConfirm: (date, _) {
                  viewModel.params.buyingDate = date;
                  setState(() {});
                },
              );
            },
            child: TextFieldBasic(
              title: 'Satın Alınma Tarihi',
              hintText: viewModel.params.buyingDate.dayMonthNameAndYear(),
              suffixIcon: Icon(Icons.date_range, color: R.themeColor.primary),
              enabled: false,
              hasError: viewModel.isDetectError && viewModel.checkErrorByField('purchased_at') || viewModel.params.vmVehicleCreate.checkErrorByField('purchased_at'),
              errorLabel: viewModel.getErrorMsg('purchased_at') ?? viewModel.params.vmVehicleCreate.getErrorMsg('purchased_at'),
            ),
          ),
          TextFieldBasic(
            controller: viewModel.params.buyingPriceController,
            titleAlign: TextAlign.end,
            textAlign: TextAlign.end,
            title: 'Aracın Alış Fiyatı',
            keyboardType: TextInputType.number,
            fontFamily: R.fonts.displayBold,
            textColor: R.themeColor.error,
            inputFormatters: [DecimalFormatter()],
            hasError: viewModel.isDetectError && viewModel.checkErrorByField('price') || viewModel.params.vmVehicleCreate.checkErrorByField('price'),
            errorLabel: viewModel.getErrorMsg('price') ?? viewModel.params.vmVehicleCreate.getErrorMsg('price'),
            hintText: '0.00',
            labelTextColor: R.themeColor.error,
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextBasic(
                text: '₺',
                fontFamily: R.fonts.displayBold,
                color: R.themeColor.error,
              ),
            ),
          ),
          TextFieldBasic(
            controller: viewModel.params.sellingPriceController,
            titleAlign: TextAlign.end,
            textAlign: TextAlign.end,
            title: 'Aracın Satış Fiyatı',
            keyboardType: TextInputType.number,
            fontFamily: R.fonts.displayBold,
            textColor: R.themeColor.success,
            inputFormatters: [DecimalFormatter()],
            hasError: viewModel.isDetectError && viewModel.checkErrorByField('sales_price') || viewModel.params.vmVehicleCreate.checkErrorByField('sales_price'),
            errorLabel: viewModel.getErrorMsg('sales_price') ?? viewModel.params.vmVehicleCreate.getErrorMsg('sales_price'),
            hintText: '0.00',
            labelTextColor: R.themeColor.success,
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextBasic(
                text: '₺',
                fontFamily: R.fonts.displayBold,
                color: R.themeColor.success,
              ),
            ),
          ),
        ],
        [
          Row(
            children: [
              Expanded(
                child: TextBasic(
                  text: 'Araç için ödeme yöntemi ekleyiniz',
                  color: R.themeColor.primary,
                  fontFamily: R.fonts.displayMedium,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  final value = double.tryParse(viewModel.params.buyingPriceController.text.replaceAll('.', ''));
                  if (viewModel.params.buyingPriceController.text.isEmpty) {
                    viewModel.errorObserver.message = 'Ödeme yöntemi eklemek için aracın alış fiyatı girilmelidir.';
                    return;
                  } else if (value == null) {
                    viewModel.errorObserver.message = 'Aracın alış fiyatı sadece tutar olarak girilmelidir.';
                    return;
                  }
                  unawaited(
                    router(context).showBaseBottomSheet(
                      context,
                      BottomSheetDropdown(
                        list: viewModel.paymentTypes,
                        onChanged: viewModel.addPaymentType,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: R.themeColor.primary,
                  ),
                  child: Icon(Icons.add, color: R.color.white),
                ),
              ),
            ],
          ),
        ],
        [
          if (viewModel.isDetectError && viewModel.checkErrorByField('payments') || viewModel.params.vmVehicleCreate.checkErrorByField('payments'))
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextBasic(
                text: viewModel.getErrorMsg('payments') ?? viewModel.params.vmVehicleCreate.getErrorMsg('payments') ?? '',
                color: R.color.candy,
                fontFamily: R.fonts.displayBold,
                fontSize: 16,
              ),
            ),
        ],
        [
          ...List.generate(
            viewModel.params.paymentTypes.length,
            (index) {
              final item = viewModel.params.paymentTypes[index];
              return WidgetPaymentCard(
                selectedPaymentType: item,
                onChangedPaymentType: (v, isAutoComplete) => viewModel.setSelectedPaymentType(index, v),
                onChangedAccountType: (v, isAutoComplete) => viewModel.setSelectedAccountType(index, v),
                onPressedRemove: () => viewModel.removeSelectedPaymentType(index),
                paymentTypes: viewModel.paymentTypes,
              );
            },
          ),
        ],
      ];
}
