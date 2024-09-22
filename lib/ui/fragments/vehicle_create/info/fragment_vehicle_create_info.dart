import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_config.dart';
import '../../../../core/constants/ui_brightness_style.dart';
import '../../../../core/enums/enum_app.dart';
import '../../../../core/models/model_alert_dialog.dart';
import '../../../../core/models/model_dropdown.dart';
import '../../../../core/models/model_vehicle_body_type.dart';
import '../../../../core/models/model_vehicle_fuel_type.dart';
import '../../../../core/models/model_vehicle_transmission_type.dart';
import '../../../../core/models/request/model_request_vehicle.dart';
import '../../../../core/resources/_r.dart';
import '../../../../core/utils/formatters.dart';
import '../../../base/base_view.dart';
import '../../../widgets/widget_date_selection.dart';
import '../../../widgets/widget_dropdown.dart';
import '../../../widgets/widget_scroll.dart';
import '../../../widgets/widget_textfield.dart';
import '../../../widgets/widget_vehicle_create_fragment_base.dart';
import '../../../widgets/widgets_text.dart';
import 'vm_fragment_vehicle_create_info.dart';

@RoutePage()
class FragmentVehicleCreateInfo extends StatefulWidget {
  const FragmentVehicleCreateInfo({
    required this.params,
    required this.onPressedPreviousButton,
    required this.onPressedNextButton,
    super.key,
  });

  final ModelRequestVehicleParams params;
  final Function() onPressedPreviousButton;
  final Function(ModelRequestVehicleParams newParams) onPressedNextButton;

  @override
  State<FragmentVehicleCreateInfo> createState() => _FragmentVehicleCreateInfoState();
}

class _FragmentVehicleCreateInfoState extends WidgetBaseStatefull<FragmentVehicleCreateInfo, VmFragmentVehicleCreateInfo> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentVehicleCreateInfo createViewModel(BuildContext context) => VmFragmentVehicleCreateInfo(apiService(context), widget.params);

  @override
  Widget buildWidget(BuildContext context, VmFragmentVehicleCreateInfo viewModel) {
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
  Widget buildWidgetForWeb(BuildContext context, VmFragmentVehicleCreateInfo viewModel) {
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

  Widget _getBase(BuildContext context, VmFragmentVehicleCreateInfo viewModel, Widget child) => WidgetVehicleCreateFragmentBase(
        nextButtonText: 'Sonraki Adım',
        onPressedNextButton: () {
          if (viewModel.checkFields()) {
            widget.onPressedNextButton(viewModel.params);
          }
        },
        onPressedPreviousButton: widget.onPressedPreviousButton,
        previousButtonText: 'Önceki Adım',
        stepTitle: '2. Adım',
        title: 'Araç Özellikleri, Sigorta Muayene',
        child: child,
      );

  Widget _getTitle(BuildContext context, VmFragmentVehicleCreateInfo viewModel) => TextBasic(
        text: 'Aracınızın Özellikleri',
        color: R.themeColor.primary,
        fontFamily: R.fonts.displayMedium,
        fontSize: 16,
      );

  List<List<Widget>> _getForm(BuildContext context, VmFragmentVehicleCreateInfo viewModel) => [
        _getBrandProps(context, viewModel),
        _getTypeProps(context, viewModel),
        _getVehicleProps(context, viewModel),
        _getKmProps(context, viewModel),
        _getInputProps(context, viewModel),
        _getInsuranceInfo(context, viewModel),
      ];

  List<Widget> _getBrandProps(BuildContext context, VmFragmentVehicleCreateInfo viewModel) => [
        DropdownBasic(
          title: 'Araç Tipi',
          hint: 'Seçiniz',
          isRequired: true,
          // ignore: discarded_futures
          callback: () => apiService(context).client.getVehicleTypes(),
          selectedItem: viewModel.params.vehicleType,
          hasError:
              viewModel.isDetectError && viewModel.checkErrorByField('vehicle_type') || viewModel.params.vmVehicleCreate.checkErrorByField('vehicle_type'),
          errorLabel: viewModel.getErrorMsg('vehicle_type') ?? viewModel.params.vmVehicleCreate.getErrorMsg('vehicle_type'),
          onChanged: viewModel.setSelectedVehicleType,
        ),
        DropdownBasic(
          key: ValueKey(viewModel.params.vehicleType),
          title: 'Marka',
          hint: 'Seçiniz',
          isRequired: true,
          // ignore: discarded_futures
          callback: viewModel.params.vehicleType == null ? null : () => apiService(context).client.getVehicleBrands(viewModel.params.vehicleType!.id),
          selectedItem: viewModel.params.brand,
          customOnTap: viewModel.params.vehicleType == null
              ? () => viewModel.alertObserver.alert = const ModelAlertDialog(description: 'Lütfen araç tipi seçiniz', dialogType: DialogTypes.warning)
              : null,
          hasError: viewModel.isDetectError && viewModel.checkErrorByField('brand') || viewModel.params.vmVehicleCreate.checkErrorByField('brand'),
          errorLabel: viewModel.getErrorMsg('brand') ?? viewModel.params.vmVehicleCreate.getErrorMsg('brand'),
          onChanged: viewModel.setSelectedBrand,
        ),
        DropdownBasic(
          key: ValueKey(viewModel.params.brand),
          title: 'Seri',
          hint: 'Seçiniz',
          isRequired: true,
          callback: viewModel.params.brand == null
              ? null
              // ignore: discarded_futures
              : () => apiService(context).client.getVehicleSeries(viewModel.params.brand!.id, viewModel.params.vehicleType!.id),
          customOnTap: viewModel.params.brand == null
              ? () => viewModel.alertObserver.alert = const ModelAlertDialog(description: 'Lütfen marka seçiniz', dialogType: DialogTypes.warning)
              : null,
          selectedItem: viewModel.params.series,
          hasError: viewModel.isDetectError && viewModel.checkErrorByField('series') || viewModel.params.vmVehicleCreate.checkErrorByField('series'),
          errorLabel: viewModel.getErrorMsg('series') ?? viewModel.params.vmVehicleCreate.getErrorMsg('series'),
          onChanged: viewModel.setSelectedSeries,
        ),
      ];

  List<Widget> _getTypeProps(BuildContext context, VmFragmentVehicleCreateInfo viewModel) => [
        DropdownBasic(
          key: ValueKey(viewModel.params.series),
          title: 'Model',
          hint: 'Seçiniz',
          isRequired: true,
          // ignore: discarded_futures
          callback: viewModel.params.series == null ? null : () => apiService(context).client.getVehicleModels(viewModel.params.series!.id),
          customOnTap: viewModel.params.series == null
              ? () => viewModel.alertObserver.alert = const ModelAlertDialog(description: 'Lütfen seri seçiniz', dialogType: DialogTypes.warning)
              : null,
          selectedItem: viewModel.params.model,
          hasError: viewModel.isDetectError && viewModel.checkErrorByField('vehicle_model_id') ||
              viewModel.params.vmVehicleCreate.checkErrorByField('vehicle_model_id'),
          errorLabel: viewModel.getErrorMsg('vehicle_model_id') ?? viewModel.params.vmVehicleCreate.getErrorMsg('vehicle_model_id'),
          onChanged: viewModel.setSelectedModel,
        ),
        DropdownBasic(
          key: ValueKey(viewModel.params.model),
          title: 'Versiyon',
          hint: 'Seçiniz',
          isRequired: true,
          callback: viewModel.params.model == null
              ? null
              // ignore: discarded_futures
              : () => apiService(context).client.getVehicleVersions(viewModel.params.model!.id),
          customOnTap: viewModel.params.model == null
              ? () => viewModel.alertObserver.alert = const ModelAlertDialog(description: 'Lütfen model seçiniz', dialogType: DialogTypes.warning)
              : null,
          selectedItem: viewModel.params.version,
          hasError: viewModel.isDetectError && viewModel.checkErrorByField('vehicle_version_id') ||
              viewModel.params.vmVehicleCreate.checkErrorByField('vehicle_version_id'),
          errorLabel: viewModel.getErrorMsg('vehicle_version_id') ?? viewModel.params.vmVehicleCreate.getErrorMsg('vehicle_version_id'),
          onChanged: viewModel.setSelectedVersion,
        ),
        DropdownBasic(
          key: ValueKey(viewModel.vehicleTypeInfo?.vehicleTransmissionType ?? DateTime.now()),
          title: 'Kasa Tipi',
          hint: 'Seçiniz',
          isRequired: true,
          selectedItem: viewModel.params.bodyType,
          items: viewModel.vehicleTypeInfo?.vehicleBodyType ?? <ModelVehicleBodyType>[],
          customOnTap: viewModel.params.model == null
              ? () => viewModel.alertObserver.alert = const ModelAlertDialog(description: 'Lütfen model seçiniz', dialogType: DialogTypes.warning)
              : null,
          hasError: viewModel.isDetectError && viewModel.checkErrorByField('vehicle_body_type_id') ||
              viewModel.params.vmVehicleCreate.checkErrorByField('vehicle_body_type_id'),
          errorLabel: viewModel.getErrorMsg('vehicle_body_type_id') ?? viewModel.params.vmVehicleCreate.getErrorMsg('vehicle_body_type_id'),
          onChanged: viewModel.onChangedBodyType,
        ),
      ];

  List<Widget> _getVehicleProps(BuildContext context, VmFragmentVehicleCreateInfo viewModel) => [
        DropdownBasic(
          key: ValueKey(viewModel.vehicleTypeInfo?.vehicleTransmissionType ?? DateTime.now()),
          title: 'Şanzıman Tipi',
          hint: 'Seçiniz',
          isRequired: true,
          selectedItem: viewModel.params.transmissionType,
          items: viewModel.vehicleTypeInfo?.vehicleTransmissionType ?? <ModelVehicleTransmissionType>[],
          customOnTap: viewModel.params.model == null
              ? () => viewModel.alertObserver.alert = const ModelAlertDialog(description: 'Lütfen model seçiniz', dialogType: DialogTypes.warning)
              : null,
          hasError: viewModel.isDetectError && viewModel.checkErrorByField('vehicle_transmission_type_id') ||
              viewModel.params.vmVehicleCreate.checkErrorByField('vehicle_transmission_type_id'),
          errorLabel: viewModel.getErrorMsg('vehicle_transmission_type_id') ?? viewModel.params.vmVehicleCreate.getErrorMsg('vehicle_transmission_type_id'),
          onChanged: viewModel.onChangedTranmissionType,
        ),
        DropdownBasic(
          title: 'Çekiş Tipi',
          hint: 'Seçiniz',
          isRequired: true,
          selectedItem: viewModel.params.tractionType,
          // ignore: discarded_futures
          callback: () => apiService(context).client.getVehicleTractionTypes(),
          customOnTap: viewModel.params.model == null
              ? () => viewModel.alertObserver.alert = const ModelAlertDialog(description: 'Lütfen model seçiniz', dialogType: DialogTypes.warning)
              : null,
          hasError: viewModel.isDetectError && viewModel.checkErrorByField('vehicle_traction_type_id') ||
              viewModel.params.vmVehicleCreate.checkErrorByField('vehicle_traction_type_id'),
          errorLabel: viewModel.getErrorMsg('vehicle_traction_type_id') ?? viewModel.params.vmVehicleCreate.getErrorMsg('vehicle_traction_type_id'),
          onChanged: viewModel.onChangedTractionType,
        ),
        DropdownBasic(
          key: ValueKey(viewModel.vehicleTypeInfo?.vehicleTransmissionType ?? DateTime.now()),
          title: 'Yakıt Tipi',
          hint: 'Seçiniz',
          isRequired: true,
          selectedItem: viewModel.params.fuelType,
          items: viewModel.vehicleTypeInfo?.vehicleFuelType ?? <ModelVehicleFuelType>[],
          customOnTap: viewModel.params.model == null
              ? () => viewModel.alertObserver.alert = const ModelAlertDialog(description: 'Lütfen model seçiniz', dialogType: DialogTypes.warning)
              : null,
          hasError: viewModel.isDetectError && viewModel.checkErrorByField('vehicle_fuel_type_id') ||
              viewModel.params.vmVehicleCreate.checkErrorByField('vehicle_fuel_type_id'),
          errorLabel: viewModel.getErrorMsg('vehicle_fuel_type_id') ?? viewModel.params.vmVehicleCreate.getErrorMsg('vehicle_fuel_type_id'),
          onChanged: viewModel.onChangedFuelType,
        ),
      ];

  List<Widget> _getKmProps(BuildContext contet, VmFragmentVehicleCreateInfo viewModel) => [
        TextFieldBasic(
          controller: viewModel.params.kilometerController,
          title: 'Kilometre Bilgisi',
          isRequired: true,
          keyboardType: TextInputType.number,
          hasError: viewModel.isDetectError && viewModel.checkErrorByField('kilometer') || viewModel.params.vmVehicleCreate.checkErrorByField('kilometer'),
          errorLabel: viewModel.getErrorMsg('kilometer') ?? viewModel.params.vmVehicleCreate.getErrorMsg('kilometer'),
          inputFormatters: inputDecimalFormatter,
        ),
        TextFieldBasic(
          controller: viewModel.params.enginePowerController,
          title: 'Motor Gücü',
          isRequired: true,
          keyboardType: TextInputType.number,
          hasError:
              viewModel.isDetectError && viewModel.checkErrorByField('engine_power') || viewModel.params.vmVehicleCreate.checkErrorByField('engine_power'),
          errorLabel: viewModel.getErrorMsg('engine_power') ?? viewModel.params.vmVehicleCreate.getErrorMsg('engine_power'),
          inputFormatters: inputDecimalFormatter,
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextBasic(
              text: 'hp',
              fontFamily: R.fonts.displayBold,
              color: R.themeColor.primary,
            ),
          ),
        ),
        TextFieldBasic(
          controller: viewModel.params.engineCapacity,
          title: 'Motor Hacmi',
          keyboardType: TextInputType.number,
          hasError: viewModel.isDetectError && viewModel.checkErrorByField('engine_capacity') ||
              viewModel.params.vmVehicleCreate.checkErrorByField('engine_capacity'),
          errorLabel: viewModel.getErrorMsg('engine_capacity') ?? viewModel.params.vmVehicleCreate.getErrorMsg('engine_capacity'),
          inputFormatters: inputDecimalFormatter,
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextBasic(
              text: 'cm³',
              fontFamily: R.fonts.displayBold,
              color: R.themeColor.primary,
            ),
          ),
        ),
      ];

  List<Widget> _getInputProps(BuildContext context, VmFragmentVehicleCreateInfo viewModel) => [
        DropdownBasic(
          key: UniqueKey(),
          title: 'Model yılı',
          hint: 'Seçiniz',
          isRequired: true,
          selectedItem: viewModel.params.year,
          items: viewModel.vehicleTypeInfo?.modelYear?.years ?? <ModelDropdown>[],
          customOnTap: viewModel.params.model == null
              ? () => viewModel.alertObserver.alert = const ModelAlertDialog(description: 'Lütfen model seçiniz', dialogType: DialogTypes.warning)
              : null,
          hasError: viewModel.isDetectError && viewModel.checkErrorByField('model_year') || viewModel.params.vmVehicleCreate.checkErrorByField('model_year'),
          errorLabel: viewModel.getErrorMsg('model_year') ?? viewModel.params.vmVehicleCreate.getErrorMsg('model_year'),
          onChanged: viewModel.onChangedYear,
        ),
        TextFieldBasic(
          controller: viewModel.params.plateNumberController,
          title: 'Plaka Numarası',
          isRequired: true,
          hasError:
              viewModel.isDetectError && viewModel.checkErrorByField('plate_number') || viewModel.params.vmVehicleCreate.checkErrorByField('plate_number'),
          errorLabel: viewModel.getErrorMsg('plate_number') ?? viewModel.params.vmVehicleCreate.getErrorMsg('plate_number'),
          textCapitalization: TextCapitalization.characters,
          inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s\b|\b\s')), UpperCaseTextFormatter()],
        ),
        TextFieldBasic(
          controller: viewModel.params.chassisNumberController,
          title: 'Şasi Numarası',
          isRequired: true,
          maxLength: 17,
          inputFormatters: [UpperCaseTextFormatter()],
          hintText: 'Ruhsatta yer alan 17 karakterli şasi numarasını giriniz',
          hasError:
              viewModel.isDetectError && viewModel.checkErrorByField('chassis_number') || viewModel.params.vmVehicleCreate.checkErrorByField('chassis_number'),
          errorLabel: viewModel.getErrorMsg('chassis_number') ?? viewModel.params.vmVehicleCreate.getErrorMsg('chassis_number'),
          titleSuffix: GestureDetector(
            onTap: () => viewModel.alertObserver.alert =
                const ModelAlertDialog(description: 'Ruhsatta yer alan 17 karakterli şasi numarası', dialogType: DialogTypes.warning),
            child: Row(
              children: [
                Icon(Icons.help_outline, size: 16, color: R.themeColor.primary),
                const SizedBox(width: 4),
                TextBasic(text: 'Nedir?', color: R.themeColor.primary),
              ],
            ),
          ),
        ),
      ];

  List<Widget> _getInsuranceInfo(BuildContext context, VmFragmentVehicleCreateInfo viewModel) => [
        WidgetDateSelection(
          key: UniqueKey(),
          title: 'Sigorta Bilgileri',
          bgColor: R.themeColor.warningLight,
          titleColor: R.color.orange,
          selectedStartDate: viewModel.params.insuranceStartDate,
          selectedEndDate: viewModel.params.insuranceEndDate,
          onChangedStartDate: viewModel.onChangedInsuranceStartDate,
          onChangedEndDate: viewModel.onChangedInsuranceEndDate,
          startDateErrorText: viewModel.getErrorMsg('insurance_start_date') ?? viewModel.params.vmVehicleCreate.getErrorMsg('insurance_start_date'),
          endDateErrorText: viewModel.getErrorMsg('insurance_end_date') ?? viewModel.params.vmVehicleCreate.getErrorMsg('insurance_end_date'),
        ),
        WidgetDateSelection(
          key: UniqueKey(),
          title: 'Muayene Bilgileri',
          bgColor: R.themeColor.successLight,
          titleColor: R.color.river,
          selectedStartDate: viewModel.params.inspectionStartDate,
          selectedEndDate: viewModel.params.inspectionEndDate,
          onChangedStartDate: viewModel.onChangedInspectionStartDate,
          onChangedEndDate: viewModel.onChangedInspectionEndDate,
          startDateErrorText: viewModel.getErrorMsg('inspection_start_date') ?? viewModel.params.vmVehicleCreate.getErrorMsg('inspection_start_date'),
          endDateErrorText: viewModel.getErrorMsg('inspection_end_date') ?? viewModel.params.vmVehicleCreate.getErrorMsg('inspection_end_date'),
        ),
      ];
}
