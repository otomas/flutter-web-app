import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paged_datatable/paged_datatable.dart';
import '../../../../core/enums/enum_app.dart';
import '../../../../core/extensions/extension_balance.dart';
import '../../../../core/extensions/extension_bool.dart';
import '../../../../core/models/model_data_table_column.dart';
import '../../../../core/models/model_vehicle.dart';
import '../../../../core/resources/_r.dart';
import '../../../../core/services/service_api.dart';
import '../../../base/base_view_model.dart';
import '../../../widgets/widget_image.dart';
import '../../../widgets/widgets_text.dart';

class VmFragmentVehiclesMine extends ViewModelBase {
  VmFragmentVehiclesMine(this.serviceApi, this.orderByField, this.orderByDirection) {
    unawaited(init());
  }
  final ServiceApi serviceApi;

  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  String? orderByField;
  String? orderByDirection;

  List<ModelVehicle> data = [];
  List<ModelDataTableColumn> tableData = [
    ModelDataTableColumn(id: 'avatar', title: 'Fotoğraf', sortable: false, size: const FractionalColumnSize(.15)),
    ModelDataTableColumn(id: 'plate_number', title: 'Plaka No', size: const FractionalColumnSize(.15)),
    ModelDataTableColumn(id: 'model_year', title: 'Yıl'),
    ModelDataTableColumn(id: 'vehicle_version.vehicle_model.vehicle_series.name', title: 'Marka'),
    ModelDataTableColumn(id: 'vehicle_version.vehicle_model.vehicle_series.name', title: 'Seri'),
    ModelDataTableColumn(id: 'seller.first_name', title: 'Müşteri'),
    ModelDataTableColumn(id: 'price', title: 'Araç Fiyatı', size: const FractionalColumnSize(.15)),
    ModelDataTableColumn(id: 'credit', title: 'Kredi', size: const FractionalColumnSize(.15)),
  ];

  final tableController = PagedDataTableController<String, Widget>();

  @override
  Future<void> init() async {
    searchController.addListener(() async {
      if (searchController.text.isNotEmpty) {
        await getData();
      }
    });
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if (!isLoadingPagination && !isEndPagination) {
          getDataScrollable();
        }
      }
    });
    // await getDataScrollable(false);
  }

  Future<void> getDataScrollable([bool isPagination = true]) async {
    if (!isPagination) {
      page = 0;
      isEndPagination = false;
      isLoadingPagination = false;
      isLoadingPagination = true;
    } else {
      page += take;
      isLoadingPagination = true;
    }
    notifyListeners();
    await serviceApi.client.getVehicles(start: page, length: take, search: searchController.text).then(
      (response) {
        if (response.data != null) {
          if (isPagination) {
            data.addAll(response.data ?? []);
          } else {
            data = response.data ?? [];
          }
        }
        if (response.data != null && response.data!.isEmpty) {
          isEndPagination = true;
        }
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    isLoadingPagination = false;
    setActivityState(ActivityState.isLoaded);
  }

  Future<List<ModelDataTableColumn>> getData({
    int? length,
    String? pageToken,
    SortModel? sort,
  }) async {
    if (sort?.fieldName != null) {
      orderByField = sort?.fieldName;
      orderByDirection = sort?.descending.getOrderDirection(orderByField);
    }

    page = (pageToken == null ? -1 : int.tryParse(pageToken) ?? 1) + 1;
    for (final element in tableData) {
      element.widgets = [];
    }
    notifyListeners();
    await serviceApi.client
        .getVehicles(
      start: page * (length ?? take),
      length: length ?? take,
      search: searchController.text,
      orderByField: orderByField,
      orderByDirection: orderByDirection,
    )
        .then(
      (response) {
        if (response.data != null) {
          totalListCount ??= response.recordsTotal ?? 0;
          data = response.data ?? [];
        }
        if (response.data != null && response.data!.isEmpty) {
          isEndPagination = true;
        }
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    for (final element in data) {
      tableData[0].addWidget(NetworkImageWithPlaceholder(imageUrl: element.avatar ?? '', width: 160, radius: 12, height: 160, isActiveShadow: true, border: Border.all(color: R.themeColor.viewBg)));
      tableData[1].addWidget(TextBasic(text: element.plateNumber ?? ''));
      tableData[2].addWidget(TextBasic(text: element.modelYear ?? ''));
      tableData[3].addWidget(TextBasic(text: element.vehicleVersion?.vehicleModel?.vehicleSeries?.vehicleBrand?.name ?? ''));
      tableData[4].addWidget(TextBasic(text: element.vehicleVersion?.vehicleModel?.vehicleSeries?.name ?? ''));
      tableData[5].addWidget(TextBasic(text: element.seller?.fullName ?? ''));
      tableData[6].addWidget(TextBasic(text: element.price.formatPrice(), color: R.themeColor.primary, fontFamily: R.fonts.displayBold, fontSize: 16));
      tableData[7].addWidget(TextBasic(text: element.credit.formatPrice()));
    }
    setActivityState(ActivityState.isLoaded);
    return tableData;
  }
}
