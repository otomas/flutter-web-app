import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paged_datatable/paged_datatable.dart';
import '../../../../core/enums/enum_app.dart';
import '../../../../core/extensions/extension_bool.dart';
import '../../../../core/models/model_data_table_column.dart';
import '../../../../core/resources/_r.dart';
import '../../../../core/services/service_api.dart';
import '../../../core/models/model_user_info.dart';
import '../../base/base_view_model.dart';
import '../../widgets/widgets_text.dart';

class VmFragmentUsers extends ViewModelBase {
  VmFragmentUsers(this.serviceApi, this.orderByField, this.orderByDirection) {
    unawaited(init());
  }
  final ServiceApi serviceApi;

  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  String? orderByField;
  String? orderByDirection;

  List<ModelUserInfo> data = [];
  List<ModelDataTableColumn> tableData = [
    ModelDataTableColumn(id: 'first_name', title: 'Ad Soyad', size: const FractionalColumnSize(0.2)),
    ModelDataTableColumn(id: 'branch', title: 'Şube', size: const FractionalColumnSize(0.2)),
    ModelDataTableColumn(id: 'mobile_number', title: 'Telefon Numarası', size: const FractionalColumnSize(0.2)),
    ModelDataTableColumn(id: 'citizen_no', title: 'Seri', size: const FractionalColumnSize(0.2)),
    ModelDataTableColumn(id: 'email', title: 'Müşteri', size: const FractionalColumnSize(0.2)),
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
    await serviceApi.client.getUsers(page, take, searchController.text, null, null).then(
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
        .getUsers(
      page * (length ?? take),
      length ?? take,
      searchController.text,
      orderByField,
      orderByDirection,
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
      tableData[0].addWidget(
        Row(
          children: [
            Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: R.themeColor.primaryLight,
              ),
              child: Center(
                child: TextBasic(
                  text: (element.firstName ?? '').substring(0, 1),
                  color: R.themeColor.primary,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(width: 5),
            TextBasic(text: element.fullName),
          ],
        ),
      );
      tableData[1].addWidget(TextBasic(text: element.autoGalleryBranch?.name ?? ''));
      tableData[2].addWidget(TextBasic(text: element.mobileNo ?? ''));
      tableData[3].addWidget(TextBasic(text: element.citizenNo ?? ''));
      tableData[4].addWidget(TextBasic(text: element.email ?? ''));
    }
    setActivityState(ActivityState.isLoaded);
    return tableData;
  }
}
