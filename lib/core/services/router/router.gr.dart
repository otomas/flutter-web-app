// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i55;
import 'package:flutter/cupertino.dart' as _i59;
import 'package:flutter/foundation.dart' as _i60;
import 'package:flutter/material.dart' as _i56;
import 'package:otomas/core/models/request/model_request_vehicle.dart' as _i58;
import 'package:otomas/core/models/response/model_response_marketplace.dart'
    as _i57;
import 'package:otomas/ui/fragments/account/balance_top_up/fragment_account_balance_top_up.dart'
    as _i1;
import 'package:otomas/ui/fragments/account/bank_accounts/fragment_account_bank_accounts.dart'
    as _i2;
import 'package:otomas/ui/fragments/account/book/fragment_account_book.dart'
    as _i3;
import 'package:otomas/ui/fragments/account/branch_pos_devices/fragment_account_branch_pos_devices.dart'
    as _i4;
import 'package:otomas/ui/fragments/account/credit_requests/fragment_account_credit_requests.dart'
    as _i5;
import 'package:otomas/ui/fragments/account/invoices/fragment_account_invoices.dart'
    as _i6;
import 'package:otomas/ui/fragments/account/turnover/fragment_account_turnover.dart'
    as _i7;
import 'package:otomas/ui/fragments/authorization/fragment_authorization.dart'
    as _i8;
import 'package:otomas/ui/fragments/branches/fragment_branches.dart' as _i9;
import 'package:otomas/ui/fragments/customer/fragment_customer.dart' as _i10;
import 'package:otomas/ui/fragments/empty/fragment_empty.dart' as _i11;
import 'package:otomas/ui/fragments/favorites/fragment_favorites.dart' as _i12;
import 'package:otomas/ui/fragments/for_me/fragment_for_me.dart' as _i13;
import 'package:otomas/ui/fragments/marketplace/fragment_marketplace.dart'
    as _i14;
import 'package:otomas/ui/fragments/messages/fragment_messages.dart' as _i15;
import 'package:otomas/ui/fragments/my_account/fragment_my_account.dart'
    as _i16;
import 'package:otomas/ui/fragments/notifications/fragment_notifications.dart'
    as _i17;
import 'package:otomas/ui/fragments/public/list/fragment_public_list.dart'
    as _i18;
import 'package:otomas/ui/fragments/queries/damage_record/fragment_queries_damage_record.dart'
    as _i19;
import 'package:otomas/ui/fragments/queries/kilometer/fragment_queries_kilometer.dart'
    as _i20;
import 'package:otomas/ui/fragments/queries/part_change/fragment_queries_part_change.dart'
    as _i21;
import 'package:otomas/ui/fragments/search/fragment_search.dart' as _i22;
import 'package:otomas/ui/fragments/settings/fragment_settings.dart' as _i23;
import 'package:otomas/ui/fragments/showcase/fragment_showcase.dart' as _i24;
import 'package:otomas/ui/fragments/support_requests/fragment_support_requests.dart'
    as _i25;
import 'package:otomas/ui/fragments/users/fragment_users.dart' as _i26;
import 'package:otomas/ui/fragments/vehicle_create/customer_info/fragment_vehicle_create_customer_info.dart'
    as _i28;
import 'package:otomas/ui/fragments/vehicle_create/expertise/fragment_vehicle_create_expertise.dart'
    as _i29;
import 'package:otomas/ui/fragments/vehicle_create/info/fragment_vehicle_create_info.dart'
    as _i30;
import 'package:otomas/ui/fragments/vehicle_create/prices/fragment_vehicle_create_prices.dart'
    as _i31;
import 'package:otomas/ui/fragments/vehicle_detail/ad_info/fragment_vehicle_detail_ad_info.dart'
    as _i33;
import 'package:otomas/ui/fragments/vehicle_detail/info/fragment_vehicle_detail_info.dart'
    as _i34;
import 'package:otomas/ui/fragments/vehicle_detail/info_card/fragment_vehicle_detail_info_card.dart'
    as _i35;
import 'package:otomas/ui/fragments/vehicle_detail/query_damage/fragment_vehicle_detail_query_damage.dart'
    as _i36;
import 'package:otomas/ui/fragments/vehicle_detail/query_kilometer/fragment_vehicle_detail_query_kilometer.dart'
    as _i37;
import 'package:otomas/ui/fragments/vehicle_detail/query_part_change/fragment_vehicle_detail_query_part_change.dart'
    as _i38;
import 'package:otomas/ui/fragments/vehicles/archived/fragment_vehicles_archived.dart'
    as _i41;
import 'package:otomas/ui/fragments/vehicles/consignment/fragment_vehicles_consignment.dart'
    as _i27;
import 'package:otomas/ui/fragments/vehicles/deleted/fragment_vehicles_deleted.dart'
    as _i32;
import 'package:otomas/ui/fragments/vehicles/inventory/fragment_vehicles_inventory.dart'
    as _i39;
import 'package:otomas/ui/fragments/vehicles/mine/fragment_vehicles_mine.dart'
    as _i42;
import 'package:otomas/ui/fragments/vehicles/purchased/fragment_vehicles_purchased.dart'
    as _i43;
import 'package:otomas/ui/fragments/vehicles/sold/fragment_vehicles_sold.dart'
    as _i40;
import 'package:otomas/ui/views/forgot_password/view_forgot_password.dart'
    as _i44;
import 'package:otomas/ui/views/home/view_home.dart' as _i45;
import 'package:otomas/ui/views/login/view_login.dart' as _i46;
import 'package:otomas/ui/views/marketplace/view_marketplace.dart' as _i47;
import 'package:otomas/ui/views/public/view_public_home.dart' as _i49;
import 'package:otomas/ui/views/public_detail/view_public_detail.dart' as _i48;
import 'package:otomas/ui/views/register/view_register.dart' as _i50;
import 'package:otomas/ui/views/splash/view_splash.dart' as _i51;
import 'package:otomas/ui/views/vehicle/create/view_vehicle_create.dart'
    as _i52;
import 'package:otomas/ui/views/vehicle/detail/view_vehicle_detail.dart'
    as _i53;
import 'package:otomas/ui/views/vehicle/doping/view_vehicle_doping.dart'
    as _i54;

/// generated route for
/// [_i1.FragmentAccountBalanceTopUp]
class FragmentAccountBalanceTopUp extends _i55.PageRouteInfo<void> {
  const FragmentAccountBalanceTopUp({List<_i55.PageRouteInfo>? children})
      : super(
          FragmentAccountBalanceTopUp.name,
          initialChildren: children,
        );

  static const String name = 'FragmentAccountBalanceTopUp';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      return const _i1.FragmentAccountBalanceTopUp();
    },
  );
}

/// generated route for
/// [_i2.FragmentAccountBankAccounts]
class FragmentAccountBankAccounts extends _i55.PageRouteInfo<void> {
  const FragmentAccountBankAccounts({List<_i55.PageRouteInfo>? children})
      : super(
          FragmentAccountBankAccounts.name,
          initialChildren: children,
        );

  static const String name = 'FragmentAccountBankAccounts';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      return const _i2.FragmentAccountBankAccounts();
    },
  );
}

/// generated route for
/// [_i3.FragmentAccountBook]
class FragmentAccountBook extends _i55.PageRouteInfo<void> {
  const FragmentAccountBook({List<_i55.PageRouteInfo>? children})
      : super(
          FragmentAccountBook.name,
          initialChildren: children,
        );

  static const String name = 'FragmentAccountBook';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      return const _i3.FragmentAccountBook();
    },
  );
}

/// generated route for
/// [_i4.FragmentAccountBranchPosDevices]
class FragmentAccountBranchPosDevices extends _i55.PageRouteInfo<void> {
  const FragmentAccountBranchPosDevices({List<_i55.PageRouteInfo>? children})
      : super(
          FragmentAccountBranchPosDevices.name,
          initialChildren: children,
        );

  static const String name = 'FragmentAccountBranchPosDevices';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      return const _i4.FragmentAccountBranchPosDevices();
    },
  );
}

/// generated route for
/// [_i5.FragmentAccountCreditRequests]
class FragmentAccountCreditRequests extends _i55.PageRouteInfo<void> {
  const FragmentAccountCreditRequests({List<_i55.PageRouteInfo>? children})
      : super(
          FragmentAccountCreditRequests.name,
          initialChildren: children,
        );

  static const String name = 'FragmentAccountCreditRequests';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      return const _i5.FragmentAccountCreditRequests();
    },
  );
}

/// generated route for
/// [_i6.FragmentAccountInvoices]
class FragmentAccountInvoices extends _i55.PageRouteInfo<void> {
  const FragmentAccountInvoices({List<_i55.PageRouteInfo>? children})
      : super(
          FragmentAccountInvoices.name,
          initialChildren: children,
        );

  static const String name = 'FragmentAccountInvoices';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      return const _i6.FragmentAccountInvoices();
    },
  );
}

/// generated route for
/// [_i7.FragmentAccountTurnover]
class FragmentAccountTurnover extends _i55.PageRouteInfo<void> {
  const FragmentAccountTurnover({List<_i55.PageRouteInfo>? children})
      : super(
          FragmentAccountTurnover.name,
          initialChildren: children,
        );

  static const String name = 'FragmentAccountTurnover';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      return const _i7.FragmentAccountTurnover();
    },
  );
}

/// generated route for
/// [_i8.FragmentAuthorization]
class FragmentAuthorization extends _i55.PageRouteInfo<void> {
  const FragmentAuthorization({List<_i55.PageRouteInfo>? children})
      : super(
          FragmentAuthorization.name,
          initialChildren: children,
        );

  static const String name = 'FragmentAuthorization';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      return const _i8.FragmentAuthorization();
    },
  );
}

/// generated route for
/// [_i9.FragmentBranches]
class FragmentBranches extends _i55.PageRouteInfo<FragmentBranchesArgs> {
  FragmentBranches({
    _i56.Key? key,
    int? page,
    String? orderByDirection,
    String? orderByField,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          FragmentBranches.name,
          args: FragmentBranchesArgs(
            key: key,
            page: page,
            orderByDirection: orderByDirection,
            orderByField: orderByField,
          ),
          rawQueryParams: {
            'page': page,
            'orderByDirection': orderByDirection,
            'orderByField': orderByField,
          },
          initialChildren: children,
        );

  static const String name = 'FragmentBranches';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<FragmentBranchesArgs>(
          orElse: () => FragmentBranchesArgs(
                page: queryParams.optInt('page'),
                orderByDirection: queryParams.optString('orderByDirection'),
                orderByField: queryParams.optString('orderByField'),
              ));
      return _i9.FragmentBranches(
        key: args.key,
        page: args.page,
        orderByDirection: args.orderByDirection,
        orderByField: args.orderByField,
      );
    },
  );
}

class FragmentBranchesArgs {
  const FragmentBranchesArgs({
    this.key,
    this.page,
    this.orderByDirection,
    this.orderByField,
  });

  final _i56.Key? key;

  final int? page;

  final String? orderByDirection;

  final String? orderByField;

  @override
  String toString() {
    return 'FragmentBranchesArgs{key: $key, page: $page, orderByDirection: $orderByDirection, orderByField: $orderByField}';
  }
}

/// generated route for
/// [_i10.FragmentCustomer]
class FragmentCustomer extends _i55.PageRouteInfo<FragmentCustomerArgs> {
  FragmentCustomer({
    _i56.Key? key,
    int? page,
    String? orderByDirection,
    String? orderByField,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          FragmentCustomer.name,
          args: FragmentCustomerArgs(
            key: key,
            page: page,
            orderByDirection: orderByDirection,
            orderByField: orderByField,
          ),
          rawQueryParams: {
            'page': page,
            'orderByDirection': orderByDirection,
            'orderByField': orderByField,
          },
          initialChildren: children,
        );

  static const String name = 'FragmentCustomer';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<FragmentCustomerArgs>(
          orElse: () => FragmentCustomerArgs(
                page: queryParams.optInt('page'),
                orderByDirection: queryParams.optString('orderByDirection'),
                orderByField: queryParams.optString('orderByField'),
              ));
      return _i10.FragmentCustomer(
        key: args.key,
        page: args.page,
        orderByDirection: args.orderByDirection,
        orderByField: args.orderByField,
      );
    },
  );
}

class FragmentCustomerArgs {
  const FragmentCustomerArgs({
    this.key,
    this.page,
    this.orderByDirection,
    this.orderByField,
  });

  final _i56.Key? key;

  final int? page;

  final String? orderByDirection;

  final String? orderByField;

  @override
  String toString() {
    return 'FragmentCustomerArgs{key: $key, page: $page, orderByDirection: $orderByDirection, orderByField: $orderByField}';
  }
}

/// generated route for
/// [_i11.FragmentEmpty]
class FragmentEmpty extends _i55.PageRouteInfo<void> {
  const FragmentEmpty({List<_i55.PageRouteInfo>? children})
      : super(
          FragmentEmpty.name,
          initialChildren: children,
        );

  static const String name = 'FragmentEmpty';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      return const _i11.FragmentEmpty();
    },
  );
}

/// generated route for
/// [_i12.FragmentFavorites]
class FragmentFavorites extends _i55.PageRouteInfo<void> {
  const FragmentFavorites({List<_i55.PageRouteInfo>? children})
      : super(
          FragmentFavorites.name,
          initialChildren: children,
        );

  static const String name = 'FragmentFavorites';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      return const _i12.FragmentFavorites();
    },
  );
}

/// generated route for
/// [_i13.FragmentForMe]
class FragmentForMe extends _i55.PageRouteInfo<void> {
  const FragmentForMe({List<_i55.PageRouteInfo>? children})
      : super(
          FragmentForMe.name,
          initialChildren: children,
        );

  static const String name = 'FragmentForMe';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      return const _i13.FragmentForMe();
    },
  );
}

/// generated route for
/// [_i14.FragmentMarketPlace]
class FragmentMarketPlace extends _i55.PageRouteInfo<FragmentMarketPlaceArgs> {
  FragmentMarketPlace({
    dynamic Function(_i57.ModelMarketplaceResponseFilter?)? onChangedFilters,
    _i56.Key? key,
    int? vehicleTypeId,
    int? vehicleBrandId,
    int? vehicleSeriesId,
    int? vehicleModelId,
    int? vehicleVersionId,
    int? provinceId,
    int? districtId,
    num? minPrice,
    num? maxPrice,
    num? minKm,
    num? maxKm,
    int? minYear,
    int? maxYear,
    List<String>? fuelTypes,
    List<String>? transmissionTypes,
    List<String>? bodyTypes,
    List<String>? enginePowers,
    List<String>? engineCapacities,
    List<String>? tractionTypes,
    List<String>? date,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          FragmentMarketPlace.name,
          args: FragmentMarketPlaceArgs(
            onChangedFilters: onChangedFilters,
            key: key,
            vehicleTypeId: vehicleTypeId,
            vehicleBrandId: vehicleBrandId,
            vehicleSeriesId: vehicleSeriesId,
            vehicleModelId: vehicleModelId,
            vehicleVersionId: vehicleVersionId,
            provinceId: provinceId,
            districtId: districtId,
            minPrice: minPrice,
            maxPrice: maxPrice,
            minKm: minKm,
            maxKm: maxKm,
            minYear: minYear,
            maxYear: maxYear,
            fuelTypes: fuelTypes,
            transmissionTypes: transmissionTypes,
            bodyTypes: bodyTypes,
            enginePowers: enginePowers,
            engineCapacities: engineCapacities,
            tractionTypes: tractionTypes,
            date: date,
          ),
          rawQueryParams: {
            'vehicleTypeId': vehicleTypeId,
            'vehicleBrandId': vehicleBrandId,
            'vehicleSeriesId': vehicleSeriesId,
            'vehicleModelId': vehicleModelId,
            'vehicleVersionId': vehicleVersionId,
            'provinceId': provinceId,
            'districtId': districtId,
            'minPrice': minPrice,
            'maxPrice': maxPrice,
            'minKm': minKm,
            'maxKm': maxKm,
            'minYear': minYear,
            'maxYear': maxYear,
            'fuelTypes': fuelTypes,
            'transmissionTypes': transmissionTypes,
            'bodyTypes': bodyTypes,
            'enginePowers': enginePowers,
            'engineCapacities': engineCapacities,
            'tractionTypes': tractionTypes,
            'date': date,
          },
          initialChildren: children,
        );

  static const String name = 'FragmentMarketPlace';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<FragmentMarketPlaceArgs>(
          orElse: () => FragmentMarketPlaceArgs(
                vehicleTypeId: queryParams.optInt('vehicleTypeId'),
                vehicleBrandId: queryParams.optInt('vehicleBrandId'),
                vehicleSeriesId: queryParams.optInt('vehicleSeriesId'),
                vehicleModelId: queryParams.optInt('vehicleModelId'),
                vehicleVersionId: queryParams.optInt('vehicleVersionId'),
                provinceId: queryParams.optInt('provinceId'),
                districtId: queryParams.optInt('districtId'),
                minPrice: queryParams.optNum('minPrice'),
                maxPrice: queryParams.optNum('maxPrice'),
                minKm: queryParams.optNum('minKm'),
                maxKm: queryParams.optNum('maxKm'),
                minYear: queryParams.optInt('minYear'),
                maxYear: queryParams.optInt('maxYear'),
                fuelTypes: queryParams.optList('fuelTypes'),
                transmissionTypes: queryParams.optList('transmissionTypes'),
                bodyTypes: queryParams.optList('bodyTypes'),
                enginePowers: queryParams.optList('enginePowers'),
                engineCapacities: queryParams.optList('engineCapacities'),
                tractionTypes: queryParams.optList('tractionTypes'),
                date: queryParams.optList('date'),
              ));
      return _i14.FragmentMarketPlace(
        onChangedFilters: args.onChangedFilters,
        key: args.key,
        vehicleTypeId: args.vehicleTypeId,
        vehicleBrandId: args.vehicleBrandId,
        vehicleSeriesId: args.vehicleSeriesId,
        vehicleModelId: args.vehicleModelId,
        vehicleVersionId: args.vehicleVersionId,
        provinceId: args.provinceId,
        districtId: args.districtId,
        minPrice: args.minPrice,
        maxPrice: args.maxPrice,
        minKm: args.minKm,
        maxKm: args.maxKm,
        minYear: args.minYear,
        maxYear: args.maxYear,
        fuelTypes: args.fuelTypes,
        transmissionTypes: args.transmissionTypes,
        bodyTypes: args.bodyTypes,
        enginePowers: args.enginePowers,
        engineCapacities: args.engineCapacities,
        tractionTypes: args.tractionTypes,
        date: args.date,
      );
    },
  );
}

class FragmentMarketPlaceArgs {
  const FragmentMarketPlaceArgs({
    this.onChangedFilters,
    this.key,
    this.vehicleTypeId,
    this.vehicleBrandId,
    this.vehicleSeriesId,
    this.vehicleModelId,
    this.vehicleVersionId,
    this.provinceId,
    this.districtId,
    this.minPrice,
    this.maxPrice,
    this.minKm,
    this.maxKm,
    this.minYear,
    this.maxYear,
    this.fuelTypes,
    this.transmissionTypes,
    this.bodyTypes,
    this.enginePowers,
    this.engineCapacities,
    this.tractionTypes,
    this.date,
  });

  final dynamic Function(_i57.ModelMarketplaceResponseFilter?)?
      onChangedFilters;

  final _i56.Key? key;

  final int? vehicleTypeId;

  final int? vehicleBrandId;

  final int? vehicleSeriesId;

  final int? vehicleModelId;

  final int? vehicleVersionId;

  final int? provinceId;

  final int? districtId;

  final num? minPrice;

  final num? maxPrice;

  final num? minKm;

  final num? maxKm;

  final int? minYear;

  final int? maxYear;

  final List<String>? fuelTypes;

  final List<String>? transmissionTypes;

  final List<String>? bodyTypes;

  final List<String>? enginePowers;

  final List<String>? engineCapacities;

  final List<String>? tractionTypes;

  final List<String>? date;

  @override
  String toString() {
    return 'FragmentMarketPlaceArgs{onChangedFilters: $onChangedFilters, key: $key, vehicleTypeId: $vehicleTypeId, vehicleBrandId: $vehicleBrandId, vehicleSeriesId: $vehicleSeriesId, vehicleModelId: $vehicleModelId, vehicleVersionId: $vehicleVersionId, provinceId: $provinceId, districtId: $districtId, minPrice: $minPrice, maxPrice: $maxPrice, minKm: $minKm, maxKm: $maxKm, minYear: $minYear, maxYear: $maxYear, fuelTypes: $fuelTypes, transmissionTypes: $transmissionTypes, bodyTypes: $bodyTypes, enginePowers: $enginePowers, engineCapacities: $engineCapacities, tractionTypes: $tractionTypes, date: $date}';
  }
}

/// generated route for
/// [_i15.FragmentMessages]
class FragmentMessages extends _i55.PageRouteInfo<void> {
  const FragmentMessages({List<_i55.PageRouteInfo>? children})
      : super(
          FragmentMessages.name,
          initialChildren: children,
        );

  static const String name = 'FragmentMessages';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      return const _i15.FragmentMessages();
    },
  );
}

/// generated route for
/// [_i16.FragmentMyAccount]
class FragmentMyAccount extends _i55.PageRouteInfo<void> {
  const FragmentMyAccount({List<_i55.PageRouteInfo>? children})
      : super(
          FragmentMyAccount.name,
          initialChildren: children,
        );

  static const String name = 'FragmentMyAccount';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      return const _i16.FragmentMyAccount();
    },
  );
}

/// generated route for
/// [_i17.FragmentNotifications]
class FragmentNotifications extends _i55.PageRouteInfo<void> {
  const FragmentNotifications({List<_i55.PageRouteInfo>? children})
      : super(
          FragmentNotifications.name,
          initialChildren: children,
        );

  static const String name = 'FragmentNotifications';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      return const _i17.FragmentNotifications();
    },
  );
}

/// generated route for
/// [_i18.FragmentPublicList]
class FragmentPublicList extends _i55.PageRouteInfo<void> {
  const FragmentPublicList({List<_i55.PageRouteInfo>? children})
      : super(
          FragmentPublicList.name,
          initialChildren: children,
        );

  static const String name = 'FragmentPublicList';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      return const _i18.FragmentPublicList();
    },
  );
}

/// generated route for
/// [_i19.FragmentQueriesDamageRecord]
class FragmentQueriesDamageRecord extends _i55.PageRouteInfo<void> {
  const FragmentQueriesDamageRecord({List<_i55.PageRouteInfo>? children})
      : super(
          FragmentQueriesDamageRecord.name,
          initialChildren: children,
        );

  static const String name = 'FragmentQueriesDamageRecord';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      return const _i19.FragmentQueriesDamageRecord();
    },
  );
}

/// generated route for
/// [_i20.FragmentQueriesKilometer]
class FragmentQueriesKilometer extends _i55.PageRouteInfo<void> {
  const FragmentQueriesKilometer({List<_i55.PageRouteInfo>? children})
      : super(
          FragmentQueriesKilometer.name,
          initialChildren: children,
        );

  static const String name = 'FragmentQueriesKilometer';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      return const _i20.FragmentQueriesKilometer();
    },
  );
}

/// generated route for
/// [_i21.FragmentQueriesPartChange]
class FragmentQueriesPartChange extends _i55.PageRouteInfo<void> {
  const FragmentQueriesPartChange({List<_i55.PageRouteInfo>? children})
      : super(
          FragmentQueriesPartChange.name,
          initialChildren: children,
        );

  static const String name = 'FragmentQueriesPartChange';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      return const _i21.FragmentQueriesPartChange();
    },
  );
}

/// generated route for
/// [_i22.FragmentSearch]
class FragmentSearch extends _i55.PageRouteInfo<void> {
  const FragmentSearch({List<_i55.PageRouteInfo>? children})
      : super(
          FragmentSearch.name,
          initialChildren: children,
        );

  static const String name = 'FragmentSearch';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      return const _i22.FragmentSearch();
    },
  );
}

/// generated route for
/// [_i23.FragmentSettings]
class FragmentSettings extends _i55.PageRouteInfo<void> {
  const FragmentSettings({List<_i55.PageRouteInfo>? children})
      : super(
          FragmentSettings.name,
          initialChildren: children,
        );

  static const String name = 'FragmentSettings';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      return const _i23.FragmentSettings();
    },
  );
}

/// generated route for
/// [_i24.FragmentShowcase]
class FragmentShowcase extends _i55.PageRouteInfo<void> {
  const FragmentShowcase({List<_i55.PageRouteInfo>? children})
      : super(
          FragmentShowcase.name,
          initialChildren: children,
        );

  static const String name = 'FragmentShowcase';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      return const _i24.FragmentShowcase();
    },
  );
}

/// generated route for
/// [_i25.FragmentSupportRequests]
class FragmentSupportRequests extends _i55.PageRouteInfo<void> {
  const FragmentSupportRequests({List<_i55.PageRouteInfo>? children})
      : super(
          FragmentSupportRequests.name,
          initialChildren: children,
        );

  static const String name = 'FragmentSupportRequests';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      return const _i25.FragmentSupportRequests();
    },
  );
}

/// generated route for
/// [_i26.FragmentUsers]
class FragmentUsers extends _i55.PageRouteInfo<FragmentUsersArgs> {
  FragmentUsers({
    _i56.Key? key,
    int? page,
    String? orderByDirection,
    String? orderByField,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          FragmentUsers.name,
          args: FragmentUsersArgs(
            key: key,
            page: page,
            orderByDirection: orderByDirection,
            orderByField: orderByField,
          ),
          rawQueryParams: {
            'page': page,
            'orderByDirection': orderByDirection,
            'orderByField': orderByField,
          },
          initialChildren: children,
        );

  static const String name = 'FragmentUsers';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<FragmentUsersArgs>(
          orElse: () => FragmentUsersArgs(
                page: queryParams.optInt('page'),
                orderByDirection: queryParams.optString('orderByDirection'),
                orderByField: queryParams.optString('orderByField'),
              ));
      return _i26.FragmentUsers(
        key: args.key,
        page: args.page,
        orderByDirection: args.orderByDirection,
        orderByField: args.orderByField,
      );
    },
  );
}

class FragmentUsersArgs {
  const FragmentUsersArgs({
    this.key,
    this.page,
    this.orderByDirection,
    this.orderByField,
  });

  final _i56.Key? key;

  final int? page;

  final String? orderByDirection;

  final String? orderByField;

  @override
  String toString() {
    return 'FragmentUsersArgs{key: $key, page: $page, orderByDirection: $orderByDirection, orderByField: $orderByField}';
  }
}

/// generated route for
/// [_i27.FragmentVehicleConsignment]
class FragmentVehicleConsignment
    extends _i55.PageRouteInfo<FragmentVehicleConsignmentArgs> {
  FragmentVehicleConsignment({
    _i56.Key? key,
    int? page,
    String? orderByDirection,
    String? orderByField,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          FragmentVehicleConsignment.name,
          args: FragmentVehicleConsignmentArgs(
            key: key,
            page: page,
            orderByDirection: orderByDirection,
            orderByField: orderByField,
          ),
          rawQueryParams: {
            'page': page,
            'orderByDirection': orderByDirection,
            'orderByField': orderByField,
          },
          initialChildren: children,
        );

  static const String name = 'FragmentVehicleConsignment';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<FragmentVehicleConsignmentArgs>(
          orElse: () => FragmentVehicleConsignmentArgs(
                page: queryParams.optInt('page'),
                orderByDirection: queryParams.optString('orderByDirection'),
                orderByField: queryParams.optString('orderByField'),
              ));
      return _i27.FragmentVehicleConsignment(
        key: args.key,
        page: args.page,
        orderByDirection: args.orderByDirection,
        orderByField: args.orderByField,
      );
    },
  );
}

class FragmentVehicleConsignmentArgs {
  const FragmentVehicleConsignmentArgs({
    this.key,
    this.page,
    this.orderByDirection,
    this.orderByField,
  });

  final _i56.Key? key;

  final int? page;

  final String? orderByDirection;

  final String? orderByField;

  @override
  String toString() {
    return 'FragmentVehicleConsignmentArgs{key: $key, page: $page, orderByDirection: $orderByDirection, orderByField: $orderByField}';
  }
}

/// generated route for
/// [_i28.FragmentVehicleCreateCustomerInfo]
class FragmentVehicleCreateCustomerInfo
    extends _i55.PageRouteInfo<FragmentVehicleCreateCustomerInfoArgs> {
  FragmentVehicleCreateCustomerInfo({
    required _i58.ModelRequestVehicleParams params,
    required dynamic Function() onPressedPreviousButton,
    required dynamic Function(_i58.ModelRequestVehicleParams)
        onPressedNextButton,
    _i56.Key? key,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          FragmentVehicleCreateCustomerInfo.name,
          args: FragmentVehicleCreateCustomerInfoArgs(
            params: params,
            onPressedPreviousButton: onPressedPreviousButton,
            onPressedNextButton: onPressedNextButton,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'FragmentVehicleCreateCustomerInfo';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FragmentVehicleCreateCustomerInfoArgs>();
      return _i28.FragmentVehicleCreateCustomerInfo(
        params: args.params,
        onPressedPreviousButton: args.onPressedPreviousButton,
        onPressedNextButton: args.onPressedNextButton,
        key: args.key,
      );
    },
  );
}

class FragmentVehicleCreateCustomerInfoArgs {
  const FragmentVehicleCreateCustomerInfoArgs({
    required this.params,
    required this.onPressedPreviousButton,
    required this.onPressedNextButton,
    this.key,
  });

  final _i58.ModelRequestVehicleParams params;

  final dynamic Function() onPressedPreviousButton;

  final dynamic Function(_i58.ModelRequestVehicleParams) onPressedNextButton;

  final _i56.Key? key;

  @override
  String toString() {
    return 'FragmentVehicleCreateCustomerInfoArgs{params: $params, onPressedPreviousButton: $onPressedPreviousButton, onPressedNextButton: $onPressedNextButton, key: $key}';
  }
}

/// generated route for
/// [_i29.FragmentVehicleCreateExpertise]
class FragmentVehicleCreateExpertise
    extends _i55.PageRouteInfo<FragmentVehicleCreateExpertiseArgs> {
  FragmentVehicleCreateExpertise({
    required _i58.ModelRequestVehicleParams params,
    required dynamic Function() onPressedPreviousButton,
    required dynamic Function(_i58.ModelRequestVehicleParams)
        onPressedNextButton,
    _i56.Key? key,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          FragmentVehicleCreateExpertise.name,
          args: FragmentVehicleCreateExpertiseArgs(
            params: params,
            onPressedPreviousButton: onPressedPreviousButton,
            onPressedNextButton: onPressedNextButton,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'FragmentVehicleCreateExpertise';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FragmentVehicleCreateExpertiseArgs>();
      return _i29.FragmentVehicleCreateExpertise(
        params: args.params,
        onPressedPreviousButton: args.onPressedPreviousButton,
        onPressedNextButton: args.onPressedNextButton,
        key: args.key,
      );
    },
  );
}

class FragmentVehicleCreateExpertiseArgs {
  const FragmentVehicleCreateExpertiseArgs({
    required this.params,
    required this.onPressedPreviousButton,
    required this.onPressedNextButton,
    this.key,
  });

  final _i58.ModelRequestVehicleParams params;

  final dynamic Function() onPressedPreviousButton;

  final dynamic Function(_i58.ModelRequestVehicleParams) onPressedNextButton;

  final _i56.Key? key;

  @override
  String toString() {
    return 'FragmentVehicleCreateExpertiseArgs{params: $params, onPressedPreviousButton: $onPressedPreviousButton, onPressedNextButton: $onPressedNextButton, key: $key}';
  }
}

/// generated route for
/// [_i30.FragmentVehicleCreateInfo]
class FragmentVehicleCreateInfo
    extends _i55.PageRouteInfo<FragmentVehicleCreateInfoArgs> {
  FragmentVehicleCreateInfo({
    required _i58.ModelRequestVehicleParams params,
    required dynamic Function() onPressedPreviousButton,
    required dynamic Function(_i58.ModelRequestVehicleParams)
        onPressedNextButton,
    _i56.Key? key,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          FragmentVehicleCreateInfo.name,
          args: FragmentVehicleCreateInfoArgs(
            params: params,
            onPressedPreviousButton: onPressedPreviousButton,
            onPressedNextButton: onPressedNextButton,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'FragmentVehicleCreateInfo';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FragmentVehicleCreateInfoArgs>();
      return _i30.FragmentVehicleCreateInfo(
        params: args.params,
        onPressedPreviousButton: args.onPressedPreviousButton,
        onPressedNextButton: args.onPressedNextButton,
        key: args.key,
      );
    },
  );
}

class FragmentVehicleCreateInfoArgs {
  const FragmentVehicleCreateInfoArgs({
    required this.params,
    required this.onPressedPreviousButton,
    required this.onPressedNextButton,
    this.key,
  });

  final _i58.ModelRequestVehicleParams params;

  final dynamic Function() onPressedPreviousButton;

  final dynamic Function(_i58.ModelRequestVehicleParams) onPressedNextButton;

  final _i56.Key? key;

  @override
  String toString() {
    return 'FragmentVehicleCreateInfoArgs{params: $params, onPressedPreviousButton: $onPressedPreviousButton, onPressedNextButton: $onPressedNextButton, key: $key}';
  }
}

/// generated route for
/// [_i31.FragmentVehicleCreatePrices]
class FragmentVehicleCreatePrices
    extends _i55.PageRouteInfo<FragmentVehicleCreatePricesArgs> {
  FragmentVehicleCreatePrices({
    required _i58.ModelRequestVehicleParams params,
    required dynamic Function() onPressedPreviousButton,
    required dynamic Function(_i58.ModelRequestVehicleParams)
        onPressedNextButton,
    _i56.Key? key,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          FragmentVehicleCreatePrices.name,
          args: FragmentVehicleCreatePricesArgs(
            params: params,
            onPressedPreviousButton: onPressedPreviousButton,
            onPressedNextButton: onPressedNextButton,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'FragmentVehicleCreatePrices';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FragmentVehicleCreatePricesArgs>();
      return _i31.FragmentVehicleCreatePrices(
        params: args.params,
        onPressedPreviousButton: args.onPressedPreviousButton,
        onPressedNextButton: args.onPressedNextButton,
        key: args.key,
      );
    },
  );
}

class FragmentVehicleCreatePricesArgs {
  const FragmentVehicleCreatePricesArgs({
    required this.params,
    required this.onPressedPreviousButton,
    required this.onPressedNextButton,
    this.key,
  });

  final _i58.ModelRequestVehicleParams params;

  final dynamic Function() onPressedPreviousButton;

  final dynamic Function(_i58.ModelRequestVehicleParams) onPressedNextButton;

  final _i56.Key? key;

  @override
  String toString() {
    return 'FragmentVehicleCreatePricesArgs{params: $params, onPressedPreviousButton: $onPressedPreviousButton, onPressedNextButton: $onPressedNextButton, key: $key}';
  }
}

/// generated route for
/// [_i32.FragmentVehicleDeleted]
class FragmentVehicleDeleted
    extends _i55.PageRouteInfo<FragmentVehicleDeletedArgs> {
  FragmentVehicleDeleted({
    _i56.Key? key,
    int? page,
    String? orderByDirection,
    String? orderByField,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          FragmentVehicleDeleted.name,
          args: FragmentVehicleDeletedArgs(
            key: key,
            page: page,
            orderByDirection: orderByDirection,
            orderByField: orderByField,
          ),
          rawQueryParams: {
            'page': page,
            'orderByDirection': orderByDirection,
            'orderByField': orderByField,
          },
          initialChildren: children,
        );

  static const String name = 'FragmentVehicleDeleted';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<FragmentVehicleDeletedArgs>(
          orElse: () => FragmentVehicleDeletedArgs(
                page: queryParams.optInt('page'),
                orderByDirection: queryParams.optString('orderByDirection'),
                orderByField: queryParams.optString('orderByField'),
              ));
      return _i32.FragmentVehicleDeleted(
        key: args.key,
        page: args.page,
        orderByDirection: args.orderByDirection,
        orderByField: args.orderByField,
      );
    },
  );
}

class FragmentVehicleDeletedArgs {
  const FragmentVehicleDeletedArgs({
    this.key,
    this.page,
    this.orderByDirection,
    this.orderByField,
  });

  final _i56.Key? key;

  final int? page;

  final String? orderByDirection;

  final String? orderByField;

  @override
  String toString() {
    return 'FragmentVehicleDeletedArgs{key: $key, page: $page, orderByDirection: $orderByDirection, orderByField: $orderByField}';
  }
}

/// generated route for
/// [_i33.FragmentVehicleDetailAdInfo]
class FragmentVehicleDetailAdInfo
    extends _i55.PageRouteInfo<FragmentVehicleDetailAdInfoArgs> {
  FragmentVehicleDetailAdInfo({
    int? branchId,
    _i56.Key? key,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          FragmentVehicleDetailAdInfo.name,
          args: FragmentVehicleDetailAdInfoArgs(
            branchId: branchId,
            key: key,
          ),
          rawQueryParams: {'branchId': branchId},
          initialChildren: children,
        );

  static const String name = 'FragmentVehicleDetailAdInfo';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final queryParams = data.queryParams;
      final args = data.argsAs<FragmentVehicleDetailAdInfoArgs>(
          orElse: () => FragmentVehicleDetailAdInfoArgs(
              branchId: queryParams.optInt('branchId')));
      return _i33.FragmentVehicleDetailAdInfo(
        id: pathParams.getInt('vehicleId'),
        branchId: args.branchId,
        key: args.key,
      );
    },
  );
}

class FragmentVehicleDetailAdInfoArgs {
  const FragmentVehicleDetailAdInfoArgs({
    this.branchId,
    this.key,
  });

  final int? branchId;

  final _i56.Key? key;

  @override
  String toString() {
    return 'FragmentVehicleDetailAdInfoArgs{branchId: $branchId, key: $key}';
  }
}

/// generated route for
/// [_i34.FragmentVehicleDetailInfo]
class FragmentVehicleDetailInfo
    extends _i55.PageRouteInfo<FragmentVehicleDetailInfoArgs> {
  FragmentVehicleDetailInfo({
    int? branchId,
    _i59.Key? key,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          FragmentVehicleDetailInfo.name,
          args: FragmentVehicleDetailInfoArgs(
            branchId: branchId,
            key: key,
          ),
          rawQueryParams: {'branchId': branchId},
          initialChildren: children,
        );

  static const String name = 'FragmentVehicleDetailInfo';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final queryParams = data.queryParams;
      final args = data.argsAs<FragmentVehicleDetailInfoArgs>(
          orElse: () => FragmentVehicleDetailInfoArgs(
              branchId: queryParams.optInt('branchId')));
      return _i34.FragmentVehicleDetailInfo(
        id: pathParams.getInt('vehicleId'),
        branchId: args.branchId,
        key: args.key,
      );
    },
  );
}

class FragmentVehicleDetailInfoArgs {
  const FragmentVehicleDetailInfoArgs({
    this.branchId,
    this.key,
  });

  final int? branchId;

  final _i59.Key? key;

  @override
  String toString() {
    return 'FragmentVehicleDetailInfoArgs{branchId: $branchId, key: $key}';
  }
}

/// generated route for
/// [_i35.FragmentVehicleDetailInfoCard]
class FragmentVehicleDetailInfoCard
    extends _i55.PageRouteInfo<FragmentVehicleDetailInfoCardArgs> {
  FragmentVehicleDetailInfoCard({
    int? branchId,
    _i56.Key? key,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          FragmentVehicleDetailInfoCard.name,
          args: FragmentVehicleDetailInfoCardArgs(
            branchId: branchId,
            key: key,
          ),
          rawQueryParams: {'branchId': branchId},
          initialChildren: children,
        );

  static const String name = 'FragmentVehicleDetailInfoCard';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final queryParams = data.queryParams;
      final args = data.argsAs<FragmentVehicleDetailInfoCardArgs>(
          orElse: () => FragmentVehicleDetailInfoCardArgs(
              branchId: queryParams.optInt('branchId')));
      return _i35.FragmentVehicleDetailInfoCard(
        id: pathParams.getInt('vehicleId'),
        branchId: args.branchId,
        key: args.key,
      );
    },
  );
}

class FragmentVehicleDetailInfoCardArgs {
  const FragmentVehicleDetailInfoCardArgs({
    this.branchId,
    this.key,
  });

  final int? branchId;

  final _i56.Key? key;

  @override
  String toString() {
    return 'FragmentVehicleDetailInfoCardArgs{branchId: $branchId, key: $key}';
  }
}

/// generated route for
/// [_i36.FragmentVehicleDetailQueryDamage]
class FragmentVehicleDetailQueryDamage
    extends _i55.PageRouteInfo<FragmentVehicleDetailQueryDamageArgs> {
  FragmentVehicleDetailQueryDamage({
    int? branchId,
    _i56.Key? key,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          FragmentVehicleDetailQueryDamage.name,
          args: FragmentVehicleDetailQueryDamageArgs(
            branchId: branchId,
            key: key,
          ),
          rawQueryParams: {'branchId': branchId},
          initialChildren: children,
        );

  static const String name = 'FragmentVehicleDetailQueryDamage';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final queryParams = data.queryParams;
      final args = data.argsAs<FragmentVehicleDetailQueryDamageArgs>(
          orElse: () => FragmentVehicleDetailQueryDamageArgs(
              branchId: queryParams.optInt('branchId')));
      return _i36.FragmentVehicleDetailQueryDamage(
        id: pathParams.getInt('vehicleId'),
        branchId: args.branchId,
        key: args.key,
      );
    },
  );
}

class FragmentVehicleDetailQueryDamageArgs {
  const FragmentVehicleDetailQueryDamageArgs({
    this.branchId,
    this.key,
  });

  final int? branchId;

  final _i56.Key? key;

  @override
  String toString() {
    return 'FragmentVehicleDetailQueryDamageArgs{branchId: $branchId, key: $key}';
  }
}

/// generated route for
/// [_i37.FragmentVehicleDetailQueryKilometer]
class FragmentVehicleDetailQueryKilometer
    extends _i55.PageRouteInfo<FragmentVehicleDetailQueryKilometerArgs> {
  FragmentVehicleDetailQueryKilometer({
    int? branchId,
    _i56.Key? key,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          FragmentVehicleDetailQueryKilometer.name,
          args: FragmentVehicleDetailQueryKilometerArgs(
            branchId: branchId,
            key: key,
          ),
          rawQueryParams: {'branchId': branchId},
          initialChildren: children,
        );

  static const String name = 'FragmentVehicleDetailQueryKilometer';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final queryParams = data.queryParams;
      final args = data.argsAs<FragmentVehicleDetailQueryKilometerArgs>(
          orElse: () => FragmentVehicleDetailQueryKilometerArgs(
              branchId: queryParams.optInt('branchId')));
      return _i37.FragmentVehicleDetailQueryKilometer(
        id: pathParams.getInt('vehicleId'),
        branchId: args.branchId,
        key: args.key,
      );
    },
  );
}

class FragmentVehicleDetailQueryKilometerArgs {
  const FragmentVehicleDetailQueryKilometerArgs({
    this.branchId,
    this.key,
  });

  final int? branchId;

  final _i56.Key? key;

  @override
  String toString() {
    return 'FragmentVehicleDetailQueryKilometerArgs{branchId: $branchId, key: $key}';
  }
}

/// generated route for
/// [_i38.FragmentVehicleDetailQueryPartChange]
class FragmentVehicleDetailQueryPartChange
    extends _i55.PageRouteInfo<FragmentVehicleDetailQueryPartChangeArgs> {
  FragmentVehicleDetailQueryPartChange({
    int? branchId,
    _i56.Key? key,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          FragmentVehicleDetailQueryPartChange.name,
          args: FragmentVehicleDetailQueryPartChangeArgs(
            branchId: branchId,
            key: key,
          ),
          rawQueryParams: {'branchId': branchId},
          initialChildren: children,
        );

  static const String name = 'FragmentVehicleDetailQueryPartChange';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final queryParams = data.queryParams;
      final args = data.argsAs<FragmentVehicleDetailQueryPartChangeArgs>(
          orElse: () => FragmentVehicleDetailQueryPartChangeArgs(
              branchId: queryParams.optInt('branchId')));
      return _i38.FragmentVehicleDetailQueryPartChange(
        id: pathParams.getInt('vehicleId'),
        branchId: args.branchId,
        key: args.key,
      );
    },
  );
}

class FragmentVehicleDetailQueryPartChangeArgs {
  const FragmentVehicleDetailQueryPartChangeArgs({
    this.branchId,
    this.key,
  });

  final int? branchId;

  final _i56.Key? key;

  @override
  String toString() {
    return 'FragmentVehicleDetailQueryPartChangeArgs{branchId: $branchId, key: $key}';
  }
}

/// generated route for
/// [_i39.FragmentVehicleInventory]
class FragmentVehicleInventory
    extends _i55.PageRouteInfo<FragmentVehicleInventoryArgs> {
  FragmentVehicleInventory({
    _i56.Key? key,
    int? page,
    String? orderByDirection,
    String? orderByField,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          FragmentVehicleInventory.name,
          args: FragmentVehicleInventoryArgs(
            key: key,
            page: page,
            orderByDirection: orderByDirection,
            orderByField: orderByField,
          ),
          rawQueryParams: {
            'page': page,
            'orderByDirection': orderByDirection,
            'orderByField': orderByField,
          },
          initialChildren: children,
        );

  static const String name = 'FragmentVehicleInventory';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<FragmentVehicleInventoryArgs>(
          orElse: () => FragmentVehicleInventoryArgs(
                page: queryParams.optInt('page'),
                orderByDirection: queryParams.optString('orderByDirection'),
                orderByField: queryParams.optString('orderByField'),
              ));
      return _i39.FragmentVehicleInventory(
        key: args.key,
        page: args.page,
        orderByDirection: args.orderByDirection,
        orderByField: args.orderByField,
      );
    },
  );
}

class FragmentVehicleInventoryArgs {
  const FragmentVehicleInventoryArgs({
    this.key,
    this.page,
    this.orderByDirection,
    this.orderByField,
  });

  final _i56.Key? key;

  final int? page;

  final String? orderByDirection;

  final String? orderByField;

  @override
  String toString() {
    return 'FragmentVehicleInventoryArgs{key: $key, page: $page, orderByDirection: $orderByDirection, orderByField: $orderByField}';
  }
}

/// generated route for
/// [_i40.FragmentVehicleSold]
class FragmentVehicleSold extends _i55.PageRouteInfo<FragmentVehicleSoldArgs> {
  FragmentVehicleSold({
    _i56.Key? key,
    int? page,
    String? orderByDirection,
    String? orderByField,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          FragmentVehicleSold.name,
          args: FragmentVehicleSoldArgs(
            key: key,
            page: page,
            orderByDirection: orderByDirection,
            orderByField: orderByField,
          ),
          rawQueryParams: {
            'page': page,
            'orderByDirection': orderByDirection,
            'orderByField': orderByField,
          },
          initialChildren: children,
        );

  static const String name = 'FragmentVehicleSold';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<FragmentVehicleSoldArgs>(
          orElse: () => FragmentVehicleSoldArgs(
                page: queryParams.optInt('page'),
                orderByDirection: queryParams.optString('orderByDirection'),
                orderByField: queryParams.optString('orderByField'),
              ));
      return _i40.FragmentVehicleSold(
        key: args.key,
        page: args.page,
        orderByDirection: args.orderByDirection,
        orderByField: args.orderByField,
      );
    },
  );
}

class FragmentVehicleSoldArgs {
  const FragmentVehicleSoldArgs({
    this.key,
    this.page,
    this.orderByDirection,
    this.orderByField,
  });

  final _i56.Key? key;

  final int? page;

  final String? orderByDirection;

  final String? orderByField;

  @override
  String toString() {
    return 'FragmentVehicleSoldArgs{key: $key, page: $page, orderByDirection: $orderByDirection, orderByField: $orderByField}';
  }
}

/// generated route for
/// [_i41.FragmentVehiclesArchived]
class FragmentVehiclesArchived
    extends _i55.PageRouteInfo<FragmentVehiclesArchivedArgs> {
  FragmentVehiclesArchived({
    _i56.Key? key,
    int? page,
    String? orderByDirection,
    String? orderByField,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          FragmentVehiclesArchived.name,
          args: FragmentVehiclesArchivedArgs(
            key: key,
            page: page,
            orderByDirection: orderByDirection,
            orderByField: orderByField,
          ),
          rawQueryParams: {
            'page': page,
            'orderByDirection': orderByDirection,
            'orderByField': orderByField,
          },
          initialChildren: children,
        );

  static const String name = 'FragmentVehiclesArchived';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<FragmentVehiclesArchivedArgs>(
          orElse: () => FragmentVehiclesArchivedArgs(
                page: queryParams.optInt('page'),
                orderByDirection: queryParams.optString('orderByDirection'),
                orderByField: queryParams.optString('orderByField'),
              ));
      return _i41.FragmentVehiclesArchived(
        key: args.key,
        page: args.page,
        orderByDirection: args.orderByDirection,
        orderByField: args.orderByField,
      );
    },
  );
}

class FragmentVehiclesArchivedArgs {
  const FragmentVehiclesArchivedArgs({
    this.key,
    this.page,
    this.orderByDirection,
    this.orderByField,
  });

  final _i56.Key? key;

  final int? page;

  final String? orderByDirection;

  final String? orderByField;

  @override
  String toString() {
    return 'FragmentVehiclesArchivedArgs{key: $key, page: $page, orderByDirection: $orderByDirection, orderByField: $orderByField}';
  }
}

/// generated route for
/// [_i42.FragmentVehiclesMine]
class FragmentVehiclesMine
    extends _i55.PageRouteInfo<FragmentVehiclesMineArgs> {
  FragmentVehiclesMine({
    _i56.Key? key,
    int? page,
    String? orderByDirection,
    String? orderByField,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          FragmentVehiclesMine.name,
          args: FragmentVehiclesMineArgs(
            key: key,
            page: page,
            orderByDirection: orderByDirection,
            orderByField: orderByField,
          ),
          rawQueryParams: {
            'page': page,
            'orderByDirection': orderByDirection,
            'orderByField': orderByField,
          },
          initialChildren: children,
        );

  static const String name = 'FragmentVehiclesMine';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<FragmentVehiclesMineArgs>(
          orElse: () => FragmentVehiclesMineArgs(
                page: queryParams.optInt('page'),
                orderByDirection: queryParams.optString('orderByDirection'),
                orderByField: queryParams.optString('orderByField'),
              ));
      return _i42.FragmentVehiclesMine(
        key: args.key,
        page: args.page,
        orderByDirection: args.orderByDirection,
        orderByField: args.orderByField,
      );
    },
  );
}

class FragmentVehiclesMineArgs {
  const FragmentVehiclesMineArgs({
    this.key,
    this.page,
    this.orderByDirection,
    this.orderByField,
  });

  final _i56.Key? key;

  final int? page;

  final String? orderByDirection;

  final String? orderByField;

  @override
  String toString() {
    return 'FragmentVehiclesMineArgs{key: $key, page: $page, orderByDirection: $orderByDirection, orderByField: $orderByField}';
  }
}

/// generated route for
/// [_i43.FragmentVehiclesPurchased]
class FragmentVehiclesPurchased
    extends _i55.PageRouteInfo<FragmentVehiclesPurchasedArgs> {
  FragmentVehiclesPurchased({
    _i56.Key? key,
    int? page,
    String? orderByDirection,
    String? orderByField,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          FragmentVehiclesPurchased.name,
          args: FragmentVehiclesPurchasedArgs(
            key: key,
            page: page,
            orderByDirection: orderByDirection,
            orderByField: orderByField,
          ),
          rawQueryParams: {
            'page': page,
            'orderByDirection': orderByDirection,
            'orderByField': orderByField,
          },
          initialChildren: children,
        );

  static const String name = 'FragmentVehiclesPurchased';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<FragmentVehiclesPurchasedArgs>(
          orElse: () => FragmentVehiclesPurchasedArgs(
                page: queryParams.optInt('page'),
                orderByDirection: queryParams.optString('orderByDirection'),
                orderByField: queryParams.optString('orderByField'),
              ));
      return _i43.FragmentVehiclesPurchased(
        key: args.key,
        page: args.page,
        orderByDirection: args.orderByDirection,
        orderByField: args.orderByField,
      );
    },
  );
}

class FragmentVehiclesPurchasedArgs {
  const FragmentVehiclesPurchasedArgs({
    this.key,
    this.page,
    this.orderByDirection,
    this.orderByField,
  });

  final _i56.Key? key;

  final int? page;

  final String? orderByDirection;

  final String? orderByField;

  @override
  String toString() {
    return 'FragmentVehiclesPurchasedArgs{key: $key, page: $page, orderByDirection: $orderByDirection, orderByField: $orderByField}';
  }
}

/// generated route for
/// [_i44.ViewForgotPassword]
class RouteForgotPassword extends _i55.PageRouteInfo<RouteForgotPasswordArgs> {
  RouteForgotPassword({
    _i60.Key? key,
    bool isActiveLoadingIndicator = true,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          RouteForgotPassword.name,
          args: RouteForgotPasswordArgs(
            key: key,
            isActiveLoadingIndicator: isActiveLoadingIndicator,
          ),
          initialChildren: children,
        );

  static const String name = 'RouteForgotPassword';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RouteForgotPasswordArgs>(
          orElse: () => const RouteForgotPasswordArgs());
      return _i44.ViewForgotPassword(
        key: args.key,
        isActiveLoadingIndicator: args.isActiveLoadingIndicator,
      );
    },
  );
}

class RouteForgotPasswordArgs {
  const RouteForgotPasswordArgs({
    this.key,
    this.isActiveLoadingIndicator = true,
  });

  final _i60.Key? key;

  final bool isActiveLoadingIndicator;

  @override
  String toString() {
    return 'RouteForgotPasswordArgs{key: $key, isActiveLoadingIndicator: $isActiveLoadingIndicator}';
  }
}

/// generated route for
/// [_i45.ViewHome]
class RouteHome extends _i55.PageRouteInfo<RouteHomeArgs> {
  RouteHome({
    _i56.Key? key,
    bool isActiveLoadingIndicator = true,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          RouteHome.name,
          args: RouteHomeArgs(
            key: key,
            isActiveLoadingIndicator: isActiveLoadingIndicator,
          ),
          initialChildren: children,
        );

  static const String name = 'RouteHome';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<RouteHomeArgs>(orElse: () => const RouteHomeArgs());
      return _i45.ViewHome(
        key: args.key,
        isActiveLoadingIndicator: args.isActiveLoadingIndicator,
      );
    },
  );
}

class RouteHomeArgs {
  const RouteHomeArgs({
    this.key,
    this.isActiveLoadingIndicator = true,
  });

  final _i56.Key? key;

  final bool isActiveLoadingIndicator;

  @override
  String toString() {
    return 'RouteHomeArgs{key: $key, isActiveLoadingIndicator: $isActiveLoadingIndicator}';
  }
}

/// generated route for
/// [_i46.ViewLogin]
class RouteLogin extends _i55.PageRouteInfo<RouteLoginArgs> {
  RouteLogin({
    _i56.Key? key,
    bool isActiveLoadingIndicator = true,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          RouteLogin.name,
          args: RouteLoginArgs(
            key: key,
            isActiveLoadingIndicator: isActiveLoadingIndicator,
          ),
          initialChildren: children,
        );

  static const String name = 'RouteLogin';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<RouteLoginArgs>(orElse: () => const RouteLoginArgs());
      return _i46.ViewLogin(
        key: args.key,
        isActiveLoadingIndicator: args.isActiveLoadingIndicator,
      );
    },
  );
}

class RouteLoginArgs {
  const RouteLoginArgs({
    this.key,
    this.isActiveLoadingIndicator = true,
  });

  final _i56.Key? key;

  final bool isActiveLoadingIndicator;

  @override
  String toString() {
    return 'RouteLoginArgs{key: $key, isActiveLoadingIndicator: $isActiveLoadingIndicator}';
  }
}

/// generated route for
/// [_i47.ViewMarketPlace]
class RouteMarketPlace extends _i55.PageRouteInfo<RouteMarketPlaceArgs> {
  RouteMarketPlace({
    _i56.Key? key,
    bool isActiveLoadingIndicator = true,
    int? vehicleId,
    int? branchId,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          RouteMarketPlace.name,
          args: RouteMarketPlaceArgs(
            key: key,
            isActiveLoadingIndicator: isActiveLoadingIndicator,
            vehicleId: vehicleId,
            branchId: branchId,
          ),
          initialChildren: children,
        );

  static const String name = 'RouteMarketPlace';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RouteMarketPlaceArgs>(
          orElse: () => const RouteMarketPlaceArgs());
      return _i47.ViewMarketPlace(
        key: args.key,
        isActiveLoadingIndicator: args.isActiveLoadingIndicator,
        vehicleId: args.vehicleId,
        branchId: args.branchId,
      );
    },
  );
}

class RouteMarketPlaceArgs {
  const RouteMarketPlaceArgs({
    this.key,
    this.isActiveLoadingIndicator = true,
    this.vehicleId,
    this.branchId,
  });

  final _i56.Key? key;

  final bool isActiveLoadingIndicator;

  final int? vehicleId;

  final int? branchId;

  @override
  String toString() {
    return 'RouteMarketPlaceArgs{key: $key, isActiveLoadingIndicator: $isActiveLoadingIndicator, vehicleId: $vehicleId, branchId: $branchId}';
  }
}

/// generated route for
/// [_i48.ViewPublicDetail]
class RoutePublicDetail extends _i55.PageRouteInfo<RoutePublicDetailArgs> {
  RoutePublicDetail({
    _i59.Key? key,
    bool isActiveLoadingIndicator = true,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          RoutePublicDetail.name,
          args: RoutePublicDetailArgs(
            key: key,
            isActiveLoadingIndicator: isActiveLoadingIndicator,
          ),
          initialChildren: children,
        );

  static const String name = 'RoutePublicDetail';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RoutePublicDetailArgs>(
          orElse: () => const RoutePublicDetailArgs());
      return _i48.ViewPublicDetail(
        key: args.key,
        isActiveLoadingIndicator: args.isActiveLoadingIndicator,
      );
    },
  );
}

class RoutePublicDetailArgs {
  const RoutePublicDetailArgs({
    this.key,
    this.isActiveLoadingIndicator = true,
  });

  final _i59.Key? key;

  final bool isActiveLoadingIndicator;

  @override
  String toString() {
    return 'RoutePublicDetailArgs{key: $key, isActiveLoadingIndicator: $isActiveLoadingIndicator}';
  }
}

/// generated route for
/// [_i49.ViewPublicHome]
class RoutePublicHome extends _i55.PageRouteInfo<RoutePublicHomeArgs> {
  RoutePublicHome({
    _i59.Key? key,
    bool isActiveLoadingIndicator = true,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          RoutePublicHome.name,
          args: RoutePublicHomeArgs(
            key: key,
            isActiveLoadingIndicator: isActiveLoadingIndicator,
          ),
          initialChildren: children,
        );

  static const String name = 'RoutePublicHome';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RoutePublicHomeArgs>(
          orElse: () => const RoutePublicHomeArgs());
      return _i49.ViewPublicHome(
        key: args.key,
        isActiveLoadingIndicator: args.isActiveLoadingIndicator,
      );
    },
  );
}

class RoutePublicHomeArgs {
  const RoutePublicHomeArgs({
    this.key,
    this.isActiveLoadingIndicator = true,
  });

  final _i59.Key? key;

  final bool isActiveLoadingIndicator;

  @override
  String toString() {
    return 'RoutePublicHomeArgs{key: $key, isActiveLoadingIndicator: $isActiveLoadingIndicator}';
  }
}

/// generated route for
/// [_i50.ViewRegister]
class RouteRegister extends _i55.PageRouteInfo<RouteRegisterArgs> {
  RouteRegister({
    _i60.Key? key,
    bool isActiveLoadingIndicator = true,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          RouteRegister.name,
          args: RouteRegisterArgs(
            key: key,
            isActiveLoadingIndicator: isActiveLoadingIndicator,
          ),
          initialChildren: children,
        );

  static const String name = 'RouteRegister';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RouteRegisterArgs>(
          orElse: () => const RouteRegisterArgs());
      return _i50.ViewRegister(
        key: args.key,
        isActiveLoadingIndicator: args.isActiveLoadingIndicator,
      );
    },
  );
}

class RouteRegisterArgs {
  const RouteRegisterArgs({
    this.key,
    this.isActiveLoadingIndicator = true,
  });

  final _i60.Key? key;

  final bool isActiveLoadingIndicator;

  @override
  String toString() {
    return 'RouteRegisterArgs{key: $key, isActiveLoadingIndicator: $isActiveLoadingIndicator}';
  }
}

/// generated route for
/// [_i51.ViewSplash]
class RouteSplash extends _i55.PageRouteInfo<void> {
  const RouteSplash({List<_i55.PageRouteInfo>? children})
      : super(
          RouteSplash.name,
          initialChildren: children,
        );

  static const String name = 'RouteSplash';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      return const _i51.ViewSplash();
    },
  );
}

/// generated route for
/// [_i52.ViewVehicleCreate]
class RouteVehicleCreate extends _i55.PageRouteInfo<RouteVehicleCreateArgs> {
  RouteVehicleCreate({
    _i56.Key? key,
    bool isActiveLoadingIndicator = true,
    int? vehicleId,
    int? branchId,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          RouteVehicleCreate.name,
          args: RouteVehicleCreateArgs(
            key: key,
            isActiveLoadingIndicator: isActiveLoadingIndicator,
            vehicleId: vehicleId,
            branchId: branchId,
          ),
          rawPathParams: {'vehicleId': vehicleId},
          rawQueryParams: {'branchId': branchId},
          initialChildren: children,
        );

  static const String name = 'RouteVehicleCreate';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final queryParams = data.queryParams;
      final args = data.argsAs<RouteVehicleCreateArgs>(
          orElse: () => RouteVehicleCreateArgs(
                vehicleId: pathParams.optInt('vehicleId'),
                branchId: queryParams.optInt('branchId'),
              ));
      return _i52.ViewVehicleCreate(
        key: args.key,
        isActiveLoadingIndicator: args.isActiveLoadingIndicator,
        vehicleId: args.vehicleId,
        branchId: args.branchId,
      );
    },
  );
}

class RouteVehicleCreateArgs {
  const RouteVehicleCreateArgs({
    this.key,
    this.isActiveLoadingIndicator = true,
    this.vehicleId,
    this.branchId,
  });

  final _i56.Key? key;

  final bool isActiveLoadingIndicator;

  final int? vehicleId;

  final int? branchId;

  @override
  String toString() {
    return 'RouteVehicleCreateArgs{key: $key, isActiveLoadingIndicator: $isActiveLoadingIndicator, vehicleId: $vehicleId, branchId: $branchId}';
  }
}

/// generated route for
/// [_i53.ViewVehicleDetail]
class RouteVehicleDetail extends _i55.PageRouteInfo<RouteVehicleDetailArgs> {
  RouteVehicleDetail({
    required int vehicleId,
    int? branchId,
    _i60.Key? key,
    bool isActiveLoadingIndicator = true,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          RouteVehicleDetail.name,
          args: RouteVehicleDetailArgs(
            vehicleId: vehicleId,
            branchId: branchId,
            key: key,
            isActiveLoadingIndicator: isActiveLoadingIndicator,
          ),
          rawPathParams: {'vehicleId': vehicleId},
          rawQueryParams: {'branchId': branchId},
          initialChildren: children,
        );

  static const String name = 'RouteVehicleDetail';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final queryParams = data.queryParams;
      final args = data.argsAs<RouteVehicleDetailArgs>(
          orElse: () => RouteVehicleDetailArgs(
                vehicleId: pathParams.getInt('vehicleId'),
                branchId: queryParams.optInt('branchId'),
              ));
      return _i53.ViewVehicleDetail(
        vehicleId: args.vehicleId,
        branchId: args.branchId,
        key: args.key,
        isActiveLoadingIndicator: args.isActiveLoadingIndicator,
      );
    },
  );
}

class RouteVehicleDetailArgs {
  const RouteVehicleDetailArgs({
    required this.vehicleId,
    this.branchId,
    this.key,
    this.isActiveLoadingIndicator = true,
  });

  final int vehicleId;

  final int? branchId;

  final _i60.Key? key;

  final bool isActiveLoadingIndicator;

  @override
  String toString() {
    return 'RouteVehicleDetailArgs{vehicleId: $vehicleId, branchId: $branchId, key: $key, isActiveLoadingIndicator: $isActiveLoadingIndicator}';
  }
}

/// generated route for
/// [_i54.ViewVehicleDoping]
class RouteVehicleDoping extends _i55.PageRouteInfo<RouteVehicleDopingArgs> {
  RouteVehicleDoping({
    required int vehicleId,
    int? branchId,
    _i56.Key? key,
    bool isActiveLoadingIndicator = true,
    List<_i55.PageRouteInfo>? children,
  }) : super(
          RouteVehicleDoping.name,
          args: RouteVehicleDopingArgs(
            vehicleId: vehicleId,
            branchId: branchId,
            key: key,
            isActiveLoadingIndicator: isActiveLoadingIndicator,
          ),
          rawPathParams: {'vehicleId': vehicleId},
          rawQueryParams: {'branchId': branchId},
          initialChildren: children,
        );

  static const String name = 'RouteVehicleDoping';

  static _i55.PageInfo page = _i55.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final queryParams = data.queryParams;
      final args = data.argsAs<RouteVehicleDopingArgs>(
          orElse: () => RouteVehicleDopingArgs(
                vehicleId: pathParams.getInt('vehicleId'),
                branchId: queryParams.optInt('branchId'),
              ));
      return _i54.ViewVehicleDoping(
        vehicleId: args.vehicleId,
        branchId: args.branchId,
        key: args.key,
        isActiveLoadingIndicator: args.isActiveLoadingIndicator,
      );
    },
  );
}

class RouteVehicleDopingArgs {
  const RouteVehicleDopingArgs({
    required this.vehicleId,
    this.branchId,
    this.key,
    this.isActiveLoadingIndicator = true,
  });

  final int vehicleId;

  final int? branchId;

  final _i56.Key? key;

  final bool isActiveLoadingIndicator;

  @override
  String toString() {
    return 'RouteVehicleDopingArgs{vehicleId: $vehicleId, branchId: $branchId, key: $key, isActiveLoadingIndicator: $isActiveLoadingIndicator}';
  }
}
