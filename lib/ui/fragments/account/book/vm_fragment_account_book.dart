// ignore_for_file: avoid_catches_without_on_clauses, no_leading_underscores_for_local_identifiers, unnecessary_breaks

import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../../../core/enums/enum_app.dart';
import '../../../../core/extensions/extension_date.dart';
import '../../../../core/models/model_account_book_list.dart';
import '../../../../core/models/model_accounting_book.dart';
import '../../../../core/models/model_sidebar.dart';
import '../../../../core/services/service_api.dart';
import '../../../base/base_view_model.dart';

class VmFragmentAccountBook extends ViewModelBase {
  VmFragmentAccountBook(this.serviceApi) {
    unawaited(init());
  }
  final ServiceApi serviceApi;
  Map<String, List<ModelSideBar>> sideBarList = {};
  Map<String, List<ModelSideBar>> sideBarListTemp = {};
  List<ModelSideBar>? sideBarListData;
  ModelAccountingBook? data;

  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  ModelSideBar? selectedBankAccount;
  DateTime? startDate;
  DateTime? endDate;
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  ModelSideBar? selectedSideBar;
  List<ModelAccountBookList>? selectedAccountBookList;

  bool detectFieldError = false;
  bool isAscending = true;

  @override
  Future<void> init() async {
    startDate = DateTime(DateTime.now().year, DateTime.now().month);
    endDate = DateTime.now();
    startDateController.text = startDate.dayMonthNameAndYear();
    endDateController.text = endDate.dayMonthNameAndYear();

    searchController.addListener(() async {
      if (searchController.text.isNotEmpty) {
        final query = searchController.text.toLowerCase();
        sideBarList = Map.fromEntries(
          sideBarListTemp.entries.map((entry) {
            final filteredList = entry.value.where((item) => (item.itemName ?? '').toLowerCase().contains(query)).toList();
            return MapEntry(entry.key, filteredList);
          }).where((entry) => entry.value.isNotEmpty),
        );
        notifyListeners();
      } else {
        sideBarList = sideBarListTemp;
        notifyListeners();
      }
    });
    unawaited(getSideBarData());
    unawaited(getData());
  }

  Future<void> getData() async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client
        .getAccountingBooks(
      startDate: startDate.yearMonthDay(),
      endDate: endDate.yearMonthDay(),
      versusType: selectedBankAccount?.modelName,
      versusId: selectedBankAccount?.modelId,
    )
        .then(
      (response) {
        data = response.data;
        if (data != null) {
          data = response.data;
        }
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
  }

  Future<void> getSideBarData() async {
    setActivityState(ActivityState.isLoading);
    try {
      final response = await serviceApi.client.getSidebar();
      if (response.data != null) {
        final temp = response.data!;
        sideBarList = groupByGroupName(temp);
        sideBarListTemp = groupByGroupName(temp);
        sideBarListData = distincSideBarList();
      }
    } catch (_err) {
      await handleApiError(_err);
    }
    setActivityState(ActivityState.isLoaded);
  }

  Future<void> getSelectedAccountBookDetail() async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client
        .getSelectedAccountBookDetail(
      selectedSideBar?.modelName ?? '',
      selectedSideBar?.modelId ?? -1,
      startDate.yearMonthDay(),
      endDate.yearMonthDay(),
    )
        .then(
      (response) {
        if (data != null) {
          selectedAccountBookList = response.data;
        }
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
  }

  List<ModelSideBar> distincSideBarList() {
    final list = <ModelSideBar>[];
    sideBarList.forEach((key, value) {
      for (final item in value) {
        final exists = list.any((element) => element.dropdownTitle == item.dropdownTitle);
        if (!exists) {
          list.add(item);
        }
      }
    });
    return list;
  }

  void sortAccountBookList({required String type, required bool isDescending}) {
    selectedAccountBookList?.sort((a, b) {
      var comparison = 0;
      isAscending = !isDescending;
      switch (type) {
        case 'description':
          final descA = (a.description?.category ?? '') + (a.description?.description ?? '');
          final descB = (b.description?.category ?? '') + (b.description?.description ?? '');
          comparison = descA.compareTo(descB);
          break;
        case 'date':
          comparison = (a.transactionDate ?? DateTime(1970)).compareTo(b.transactionDate ?? DateTime(1970));
          break;
        case 'amount':
          comparison = (a.amount?.amount ?? 0).compareTo(b.amount?.amount ?? 0);
          break;
        case 'balance':
          comparison = (a.balance?.amount ?? 0).compareTo(b.balance?.amount ?? 0);
          break;
        default:
          break;
      }
      notifyListeners();
      return isDescending ? -comparison : comparison;
    });
  }

  Map<String, List<ModelSideBar>> groupByGroupName(List<ModelSideBar> list) => list.fold<Map<String, List<ModelSideBar>>>(
        {},
        (map, item) {
          final groupName = item.groupName ?? '';
          if (!map.containsKey(groupName)) {
            map[groupName] = [];
          }
          map[groupName]?.add(item);
          return map;
        },
      );

  void setSelectedBankAccount(ModelSideBar? model, bool isAutoComplete) {
    if (selectedBankAccount == model) {
      return;
    }
    selectedBankAccount = model;
  }

  void onChangedStartDate(DateTime? value) {
    startDate = value;
  }

  void onChangedEndDate(DateTime? value) {
    endDate = value;
  }
}
