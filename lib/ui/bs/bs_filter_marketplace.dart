import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import '../../core/enums/enum_app.dart';
import '../../core/models/model_alert_dialog.dart';
import '../../core/models/model_filter_marketplace.dart';
import '../../core/models/model_value_label.dart';
import '../../core/models/model_vehicle_body_type.dart';
import '../../core/models/model_vehicle_fuel_type.dart';
import '../../core/models/model_vehicle_traction_type.dart';
import '../../core/models/model_vehicle_transmission_type.dart';
import '../../core/models/response/model_response_marketplace_filters.dart';
import '../../core/resources/_r.dart';
import '../../core/services/service_api.dart';
import '../../core/utils/alert_utils.dart';
import '../../core/utils/formatters.dart';
import '../../ui/base/base_view.dart';
import '../../ui/base/base_view_model.dart';
import '../widgets/widget_button.dart';
import '../widgets/widget_collapsable_box.dart';
import '../widgets/widget_dropdown.dart';
import '../widgets/widget_scroll.dart';
import '../widgets/widget_textfield.dart';
import '../widgets/widgets_text.dart';

class BsFiltershowcase extends StatefulWidget {
  const BsFiltershowcase({required this.onSuccess, super.key, this.filter});
  final ModelFilterMarketplace? filter;
  final Function(ModelFilterMarketplace filter) onSuccess;

  @override
  State<BsFiltershowcase> createState() => _BsFiltershowcaseState();
}

class _BsFiltershowcaseState extends WidgetBaseStatefull<BsFiltershowcase, VmBsFiltershowcase> {
  @override
  VmBsFiltershowcase createViewModel(BuildContext context) => VmBsFiltershowcase(apiService(context), widget.filter);

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  Widget buildWidgetForWeb(BuildContext context, VmBsFiltershowcase viewModel) => _getBody(context, viewModel);

  @override
  Widget buildWidget(BuildContext context, VmBsFiltershowcase viewModel) => _getBody(context, viewModel);

  Widget _getBody(BuildContext context, VmBsFiltershowcase viewModel) => Column(
        children: [
          Expanded(
            child: ScrollWithNoGlowWidget(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ..._getVehicleFilters(context, viewModel),
                  const SizedBox(height: 10),
                  ..._getLocationFilters(context, viewModel),
                  const SizedBox(height: 10),
                  ..._getDateRangeFilters(context, viewModel),
                  const SizedBox(height: 10),
                  ..._getPriceRangeFilters(context, viewModel),
                  const SizedBox(height: 10),
                  ..._getKilometerRangeFilters(context, viewModel),
                  const SizedBox(height: 10),
                  WidgetCollapsableBox(
                    title: 'Yakıt',
                    selectedItems: viewModel.filter.fuelTypes,
                    // ignore: discarded_futures
                    callback: () => apiService(context).client.getVehicleFuelTypes(),
                    onChanged: viewModel.onChangedSelectedFuelTypes,
                  ),
                  WidgetCollapsableBox(
                    title: 'Vites',
                    selectedItems: viewModel.filter.transmissionTypes,
                    // ignore: discarded_futures
                    callback: () => apiService(context).client.getVehicleTranmissionTypes(),
                    onChanged: viewModel.onChangedSelectedTransmissionTypes,
                  ),
                  WidgetCollapsableBox(
                    title: 'Kasa Tipi',
                    selectedItems: viewModel.filter.bodyTypes,
                    // ignore: discarded_futures
                    callback: () => apiService(context).client.getVehicleBodyTypes(),
                    onChanged: viewModel.onChangedSelectedBodyTypes,
                  ),
                  WidgetCollapsableBox<ModelValueLabel>(
                    key: ValueKey(viewModel.filterData?.filters?.enginePower ?? const Uuid().v4()),
                    title: 'Motor Gücü',
                    selectedItems: viewModel.filter.enginePowers,
                    items: viewModel.filterData?.filters?.enginePower,
                    onChanged: viewModel.onChangedSelectedEnginePowers,
                  ),
                  WidgetCollapsableBox<ModelValueLabel>(
                    key: ValueKey(viewModel.filterData?.filters?.engineCapacity ?? const Uuid().v4()),
                    title: 'Motor Hacmi',
                    selectedItems: viewModel.filter.engineCapacity,
                    items: viewModel.filterData?.filters?.engineCapacity,
                    onChanged: viewModel.onChangedSelectedEngineCapacity,
                  ),
                  WidgetCollapsableBox(
                    title: 'Çekiş Tipi',
                    selectedItems: viewModel.filter.transmissionTypes,
                    // ignore: discarded_futures
                    callback: () => apiService(context).client.getVehicleTranmissionTypes(),
                    onChanged: viewModel.onChangedSelectedTransmissionTypes,
                  ),
                  WidgetCollapsableBox<ModelValueLabel>(
                    key: ValueKey(viewModel.filterData?.filters?.date ?? const Uuid().v4()),
                    title: 'Tarih',
                    selectedItems: viewModel.filter.dates,
                    items: viewModel.filterData?.filters?.date,
                    onChanged: viewModel.onChangedSelectedDates,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ButtonBasic(
              text: 'Filtrele',
              radius: 12,
              onPressed: () {
                widget.onSuccess(viewModel.filter);
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      );

  List<Widget> _getVehicleFilters(BuildContext context, VmBsFiltershowcase viewModel) => [
        TextBasic(text: 'Filtrele', color: R.themeColor.primary, fontFamily: R.fonts.displayBold, fontSize: 18),
        const SizedBox(height: 20),
        DropdownBasic(
          hint: 'Araç Tipi',
          isRequired: true,
          // ignore: discarded_futures
          callback: () => apiService(context).client.getVehicleTypes(),
          selectedItem: viewModel.filter.vehicleType,
          onChanged: (vehicleType, isAutoComplete) => {viewModel.filter.setVehicleType(vehicleType), setState(() {})},
        ),
        const SizedBox(height: 10),
        DropdownBasic(
          key: ValueKey(viewModel.filter.vehicleType),
          hint: 'Marka',
          isRequired: true,
          // ignore: discarded_futures
          callback: viewModel.filter.vehicleType == null ? null : () => apiService(context).client.getVehicleBrands(viewModel.filter.vehicleType!.id),
          selectedItem: viewModel.filter.brand,
          customOnTap: viewModel.filter.vehicleType == null ? () => viewModel.alertObserver.alert = const ModelAlertDialog(description: 'Lütfen araç tipi seçiniz', dialogType: DialogTypes.warning) : null,
          onChanged: (brand, isAutoComplete) => {viewModel.filter.setBrand(brand), setState(() {})},
        ),
        const SizedBox(height: 10),
        DropdownBasic(
          key: ValueKey(viewModel.filter.brand),
          hint: 'Seri',
          isRequired: true,
          callback: viewModel.filter.brand == null
              ? null
              // ignore: discarded_futures
              : () => apiService(context).client.getVehicleSeries(viewModel.filter.brand!.id, viewModel.filter.vehicleType!.id),
          customOnTap: viewModel.filter.brand == null ? () => viewModel.alertObserver.alert = const ModelAlertDialog(description: 'Lütfen marka seçiniz', dialogType: DialogTypes.warning) : null,
          selectedItem: viewModel.filter.serie,
          onChanged: (seri, isAutoComplete) => {viewModel.filter.setSerie(seri), setState(() {})},
        ),
        const SizedBox(height: 10),
        DropdownBasic(
          key: ValueKey(viewModel.filter.serie),
          hint: 'Model',
          isRequired: true,
          // ignore: discarded_futures
          callback: viewModel.filter.serie == null ? null : () => apiService(context).client.getVehicleModels(viewModel.filter.serie!.id),
          customOnTap: viewModel.filter.serie == null ? () => viewModel.alertObserver.alert = const ModelAlertDialog(description: 'Lütfen seri seçiniz', dialogType: DialogTypes.warning) : null,
          selectedItem: viewModel.filter.model,
          onChanged: (model, isAutoComplete) => {viewModel.filter.setModel(model), setState(() {})},
        ),
        const SizedBox(height: 10),
        DropdownBasic(
          key: ValueKey(viewModel.filter.model),
          hint: 'Versiyon',
          isRequired: true,
          callback: viewModel.filter.model == null
              ? null
              // ignore: discarded_futures
              : () => apiService(context).client.getVehicleVersions(viewModel.filter.model!.id),
          customOnTap: viewModel.filter.model == null ? () => viewModel.alertObserver.alert = const ModelAlertDialog(description: 'Lütfen model seçiniz', dialogType: DialogTypes.warning) : null,
          selectedItem: viewModel.filter.version,
          onChanged: (version, isAutoComplete) => {viewModel.filter.setVersion(version), setState(() {})},
        ),
      ];

  List<Widget> _getLocationFilters(BuildContext context, VmBsFiltershowcase viewModel) => [
        TextBasic(text: R.string.location, color: R.themeColor.smokeDark, fontFamily: R.fonts.displayMedium, fontSize: 14),
        const SizedBox(height: 10),
        DropdownBasic(
          hint: 'Ülke Seçimi',
          isRequired: true,
          // ignore: discarded_futures
          callback: () => apiService(context).client.getCountries(),
          selectedItem: viewModel.filter.country,
          onChanged: (country, isAutoComplete) => {viewModel.filter.setCountry(country), setState(() {})},
        ),
        const SizedBox(height: 10),
        DropdownBasic(
          key: ValueKey(viewModel.filter.country),
          hint: 'Şehir Seçimi',
          isRequired: true,
          // ignore: discarded_futures
          callback: viewModel.filter.country == null ? null : () => apiService(context).client.getCities(viewModel.filter.country!.id),
          selectedItem: viewModel.filter.city,
          onChanged: viewModel.filter.setCity,
          customOnTap: viewModel.filter.country == null ? () => viewModel.alertObserver.alert = const ModelAlertDialog(description: 'Lütfen ülke seçiniz', dialogType: DialogTypes.warning) : null,
        ),
      ];

  List<Widget> _getDateRangeFilters(BuildContext context, VmBsFiltershowcase viewModel) => [
        TextBasic(text: 'Tarih Aralığı', color: R.themeColor.smokeDark, fontFamily: R.fonts.displayMedium, fontSize: 14),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _showMinDatePicker(context, viewModel),
                child: TextFieldBasic(labelText: 'Başlangıç', controller: viewModel.filter.minDateController, enabled: false),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => _showMaxDatePicker(context, viewModel),
                child: TextFieldBasic(labelText: 'Bitiş', controller: viewModel.filter.maxDateController, enabled: false),
              ),
            ),
          ],
        ),
      ];

  List<Widget> _getPriceRangeFilters(BuildContext context, VmBsFiltershowcase viewModel) => [
        TextBasic(text: 'Fiyat Aralığı', color: R.themeColor.smokeDark, fontFamily: R.fonts.displayMedium, fontSize: 14),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextFieldBasic(
                labelText: 'Minimum',
                keyboardType: TextInputType.number,
                controller: viewModel.filter.minPriceController,
                inputFormatters: [DecimalFormatter(), FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d+)*$'))],
                suffixIcon: TextBasic(text: '₺', color: R.themeColor.primary, fontFamily: R.fonts.displayBold),
              ),
            ),
            Expanded(
              child: TextFieldBasic(
                labelText: 'Maximum',
                keyboardType: TextInputType.number,
                controller: viewModel.filter.maxPriceController,
                inputFormatters: [DecimalFormatter(), FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d+)*$'))],
                suffixIcon: TextBasic(text: '₺', color: R.themeColor.primary, fontFamily: R.fonts.displayBold),
              ),
            ),
          ],
        ),
      ];

  List<Widget> _getKilometerRangeFilters(BuildContext context, VmBsFiltershowcase viewModel) => [
        TextBasic(text: 'Kilometre Aralığı', color: R.themeColor.smokeDark, fontFamily: R.fonts.displayMedium, fontSize: 14),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextFieldBasic(
                labelText: 'Minimum',
                keyboardType: TextInputType.number,
                controller: viewModel.filter.minKilometerController,
                inputFormatters: [DecimalFormatter(), FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d+)*$'))],
                suffixIcon: TextBasic(text: 'km', color: R.themeColor.primary, fontFamily: R.fonts.displayBold),
              ),
            ),
            Expanded(
              child: TextFieldBasic(
                labelText: 'Maximum',
                keyboardType: TextInputType.number,
                controller: viewModel.filter.maxKilometerController,
                inputFormatters: [DecimalFormatter(), FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d+)*$'))],
                suffixIcon: TextBasic(text: 'km', color: R.themeColor.primary, fontFamily: R.fonts.displayBold),
              ),
            ),
          ],
        ),
      ];

  void _showMinDatePicker(BuildContext context, VmBsFiltershowcase viewModel) {
    unawaited(
      showCustomDatePicker(
        context,
        initial: DateTime.now(),
        max: viewModel.filter.maxDate ?? DateTime.now(),
        min: DateTime.now().add(const Duration(days: -(365 * 100))),
        onConfirm: (date, _) {
          viewModel.filter.minDate = date;
          viewModel.filter.minDateController.text = date.year.toString();
        },
      ),
    );
  }

  void _showMaxDatePicker(BuildContext context, VmBsFiltershowcase viewModel) {
    unawaited(
      showCustomDatePicker(
        context,
        initial: DateTime.now(),
        max: DateTime.now(),
        min: viewModel.filter.minDate ?? DateTime.now().add(const Duration(days: -(365 * 100))),
        onConfirm: (date, _) {
          viewModel.filter.maxDate = date;
          viewModel.filter.maxDateController.text = date.year.toString();
        },
      ),
    );
  }
}

class VmBsFiltershowcase extends ViewModelBase {
  VmBsFiltershowcase(this.serviceApi, ModelFilterMarketplace? filter) {
    this.filter = filter ?? ModelFilterMarketplace();
    init();
  }

  final ServiceApi serviceApi;

  ModelMarketplaceFilterResponse? filterData;

  late ModelFilterMarketplace filter;

  @override
  void init() {
    unawaited(getFilters());
  }

  Future<void> getFilters() async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.getMarketplaceFilters().then(
      (response) {
        filterData = response.data;
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
  }

  void onChangedSelectedFuelTypes(List<ModelVehicleFuelType> items) {
    filter.fuelTypes = items;
  }

  void onChangedSelectedTransmissionTypes(List<ModelVehicleTransmissionType> items) {
    filter.transmissionTypes = items;
  }

  void onChangedSelectedBodyTypes(List<ModelVehicleBodyType> items) {
    filter.bodyTypes = items;
  }

  void onChangedSelectedEnginePowers(List<ModelValueLabel> items) {
    filter.enginePowers = items;
  }

  void onChangedSelectedEngineCapacity(List<ModelValueLabel> items) {
    filter.engineCapacity = items;
  }

  void onChangedSelectedVehicleTractionTypes(List<ModelVehicleTractionType> items) {
    filter.tractionTypes = items;
  }

  void onChangedSelectedDates(List<ModelValueLabel> items) {
    filter.dates = items;
  }
}
