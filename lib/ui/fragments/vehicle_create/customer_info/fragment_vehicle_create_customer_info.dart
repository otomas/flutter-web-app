import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/ui_brightness_style.dart';
import '../../../../core/models/request/model_request_vehicle.dart';
import '../../../../core/resources/_r.dart';
import '../../../base/base_view.dart';
import '../../../widgets/widget_customer_selection.dart';
import '../../../widgets/widget_scroll.dart';
import '../../../widgets/widget_vehicle_create_fragment_base.dart';
import 'vm_fragment_vehicle_create_customer_info.dart';

@RoutePage()
class FragmentVehicleCreateCustomerInfo extends StatefulWidget {
  const FragmentVehicleCreateCustomerInfo({
    required this.params,
    required this.onPressedPreviousButton,
    required this.onPressedNextButton,
    super.key,
  });

  final ModelRequestVehicleParams params;
  final Function() onPressedPreviousButton;
  final Function(ModelRequestVehicleParams newParams) onPressedNextButton;

  @override
  State<FragmentVehicleCreateCustomerInfo> createState() => _FragmentVehicleCreateCustomerInfoState();
}

class _FragmentVehicleCreateCustomerInfoState extends WidgetBaseStatefull<FragmentVehicleCreateCustomerInfo, VmFragmentVehicleCreateCustomerInfo> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentVehicleCreateCustomerInfo createViewModel(BuildContext context) => VmFragmentVehicleCreateCustomerInfo(apiService(context), widget.params);

  @override
  Widget buildWidget(BuildContext context, VmFragmentVehicleCreateCustomerInfo viewModel) => _getBase(
        context,
        viewModel,
        ScrollWithNoGlowWidget(
          child: Column(
            children: _getForm(context, viewModel),
          ),
        ),
      );

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentVehicleCreateCustomerInfo viewModel) {
    final fields = _getForm(context, viewModel);
    return _getBase(
      context,
      viewModel,
      Row(
        children: List.generate(
          fields.length,
          (index) => Expanded(child: fields[index]),
        ),
      ),
    );
  }

  Widget _getBase(BuildContext context, VmFragmentVehicleCreateCustomerInfo viewModel, Widget child) => WidgetVehicleCreateFragmentBase(
        nextButtonText: 'Sonraki Adım',
        onPressedNextButton: () {
          if (viewModel.checkFields()) {
            widget.onPressedNextButton(viewModel.params);
          }
        },
        onPressedPreviousButton: widget.onPressedPreviousButton,
        previousButtonText: 'Vazgeç',
        stepTitle: '1. Adım',
        title: 'Alıcı Satıcı ve Tedarikçi Bilgileri',
        child: child,
      );

  List<Widget> _getForm(BuildContext context, VmFragmentVehicleCreateCustomerInfo viewModel) => [
        _getSupplierSelectionField(context, viewModel),
        _getSellerSelectionField(context, viewModel),
        _getBuyerSelectionField(context, viewModel),
      ];

  Widget _getSupplierSelectionField(BuildContext context, VmFragmentVehicleCreateCustomerInfo viewModel) => WidgetCustomerSelection(
        title: 'Tedarikçi',
        buttonTitle: 'Tedarikçi Ekle',
        onChangedCustomer: viewModel.onChangedSupplier,
        selectedItem: viewModel.params.supplier,
        bgColor: R.themeColor.viewBg,
        hasError: viewModel.isDetectError && viewModel.checkErrorByField('supplier_id'),
        errorLabel: viewModel.getErrorMsg('supplier_id'),
        onRemove: () => viewModel.onChangedSupplier(null, false),
      );

  Widget _getSellerSelectionField(BuildContext context, VmFragmentVehicleCreateCustomerInfo viewModel) => WidgetCustomerSelection(
        title: 'Satıcı',
        buttonTitle: 'Satıcı Ekle',
        onChangedCustomer: viewModel.onChangedSeller,
        selectedItem: viewModel.params.seller,
        bgColor: R.themeColor.boxBg,
        hasError: viewModel.isDetectError && viewModel.checkErrorByField('seller_id'),
        errorLabel: viewModel.getErrorMsg('seller_id'),
        onRemove: () => viewModel.onChangedSeller(null, false),
      );

  Widget _getBuyerSelectionField(BuildContext context, VmFragmentVehicleCreateCustomerInfo viewModel) => WidgetCustomerSelection(
        title: 'Alıcı',
        buttonTitle: 'Alıcı Ekle',
        onChangedCustomer: viewModel.onChangedBuyer,
        selectedItem: viewModel.params.buyer,
        bgColor: R.themeColor.viewBg,
        hasError: viewModel.isDetectError && viewModel.checkErrorByField('buyer_id'),
        errorLabel: viewModel.getErrorMsg('buyer_id'),
        onRemove: () => viewModel.onChangedBuyer(null, false),
      );
}
