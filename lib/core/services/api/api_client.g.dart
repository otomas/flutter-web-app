// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiClient implements ApiClient {
  _ApiClient(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ResponseData<dynamic>> register(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = JsonMapper.serialize(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseData<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'user/auth/register',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ResponseData<dynamic>>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseString> deviceRegister({
    required deviceId,
    required fcmToken,
    required platform,
    required locale,
    macAddress,
    latitude = 0,
    longitude = 0,
    isActive = true,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'device_id': deviceId,
      'fcm_token': fcmToken,
      'platform': platform,
      'locale': locale,
      'mac_address': macAddress,
      'latitude': latitude,
      'longitude': longitude,
      'is_active': isActive,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseString>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/system/devices',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseString>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseString> deviceUpdate(
    deviceId,
    body,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = JsonMapper.serialize(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseString>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/Device/${deviceId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseString>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseLogin> login({
    required username,
    required password,
    required taxNumber,
    grantType = 'password',
    clientId = clientId,
    clientSecret = clientSecret,
    scope = '',
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'username': username,
      'password': password,
      'tax_number': taxNumber,
      'grant_type': grantType,
      'client_id': clientId,
      'client_secret': clientSecret,
      'scope': scope,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ModelResponseLogin>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/oauth/token',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseLogin>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseString> forgotPassword({
    required taxNo,
    required email,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'auto_gallery_tax_no': taxNo,
      'email': email,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseString>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/auth/password/forgot',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseString>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseCountryList> getCountries() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseCountryList>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/countries',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseCountryList>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseCityList> getCities(countryId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseCityList>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/countries/${countryId}/provinces',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseCityList>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseCityList> getCitiesList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseCityList>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/provinces',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseCityList>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseDistrictList> getDistricts(cityId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseDistrictList>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/provinces/${cityId}/districts',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseDistrictList>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseNeighbourhoodList> getNeighbourhood(districtId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseNeighbourhoodList>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/districts/${districtId}/neighborhoods',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelResponseNeighbourhoodList>(
        _result.data!);
    return value;
  }

  @override
  Future<ModelResponseAdvertOwnerType> getAdvertOwnerType() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseAdvertOwnerType>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/advert-owner-types',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelResponseAdvertOwnerType>(
        _result.data!);
    return value;
  }

  @override
  Future<ModelResponseTillReport> getTillReport() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseTillReport>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/for-me/till-report',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseTillReport>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseBuySellChart> getBuySellChart() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseBuySellChart>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/for-me/buy-sell-chart',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseBuySellChart>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleList> getVehicles({
    start,
    length,
    search,
    orderByField,
    orderByDirection,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start,
      r'length': length,
      r'search[value]': search,
      r'order[0][column]': orderByField,
      r'order[0][dir]': orderByDirection,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleList>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/vehicles',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseVehicleList>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleList> getVehiclesSales({
    start,
    length,
    search,
    orderByField,
    orderByDirection,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start,
      r'length': length,
      r'search[value]': search,
      r'order[0][column]': orderByField,
      r'order[0][dir]': orderByDirection,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleList>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/vehicles/sales',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseVehicleList>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleList> getVehiclesInventory({
    start,
    length,
    search,
    orderByField,
    orderByDirection,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start,
      r'length': length,
      r'search[value]': search,
      r'order[0][column]': orderByField,
      r'order[0][dir]': orderByDirection,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleList>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/vehicles/inventory',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseVehicleList>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleList> getVehiclesConsignment({
    start,
    length,
    search,
    orderByField,
    orderByDirection,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start,
      r'length': length,
      r'search[value]': search,
      r'order[0][column]': orderByField,
      r'order[0][dir]': orderByDirection,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleList>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/vehicles/consignee',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseVehicleList>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleList> getVehiclesDeleted({
    start,
    length,
    search,
    orderByField,
    orderByDirection,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start,
      r'length': length,
      r'search[value]': search,
      r'order[0][column]': orderByField,
      r'order[0][dir]': orderByDirection,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleList>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/vehicles/deleted',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseVehicleList>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseCustomerList> getCustomers({
    start,
    length,
    search,
    orderByField,
    orderByDirection,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start,
      r'length': length,
      r'search[value]': search,
      r'order[0][column]': orderByField,
      r'order[0][dir]': orderByDirection,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseCustomerList>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/customers',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseCustomerList>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseCustomer> getCustomer(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseCustomer>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/customers/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseCustomer>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseBankAccounts> getBankAccounts(
    start,
    length,
    search,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start,
      r'length': length,
      r'search[value]': search,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseBankAccounts>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/accounting/bank-accounts',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseBankAccounts>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseBranchPosDevices> getBranchPosDevices(
    start,
    length,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start,
      r'length': length,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseBranchPosDevices>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/accounting/branch-pos-devices',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelResponseBranchPosDevices>(
        _result.data!);
    return value;
  }

  @override
  Future<ModelResponseBranchPosDevice> getBranchPosDeviceDetail(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseBranchPosDevice>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/accounting/branch-pos-devices/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelResponseBranchPosDevice>(
        _result.data!);
    return value;
  }

  @override
  Future<ModelResponseBalanceTopUp> getBalanceTopUp(
    start,
    length,
    search,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start,
      r'length': length,
      r'search[value]': search,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseBalanceTopUp>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/accounting/balance-payments',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseBalanceTopUp>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseBranches> getBranches(
    start,
    length,
    search,
    orderByField,
    orderByDirection,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start,
      r'length': length,
      r'search[value]': search,
      r'order[0][column]': orderByField,
      r'order[0][dir]': orderByDirection,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseBranches>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/branches',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseBranches>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseBranch> createBranch(
    neighborhoodId,
    name,
    phoneNumber,
    address,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'neighborhood_id': neighborhoodId,
      'name': name,
      'phone_number': phoneNumber,
      'address': address,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseBranch>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/branches',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseBranch>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseBranch> updateBranch(
    branchId,
    neighborhoodId,
    name,
    phoneNumber,
    address,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'neighborhood_id': neighborhoodId,
      'name': name,
      'phone_number': phoneNumber,
      'address': address,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseBranch>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/branches/${branchId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseBranch>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseUsers> getUsers(
    start,
    length,
    search,
    orderByField,
    orderByDirection,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start': start,
      r'length': length,
      r'search[value]': search,
      r'order[0][column]': orderByField,
      r'order[0][dir]': orderByDirection,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ModelResponseUsers>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/users',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseUsers>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseUser> getUser(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ModelResponseUser>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/users/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseUser>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseUserProfile> getUserProfile() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseUserProfile>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/auth/profile',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseUserProfile>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseBankAccountList> getBankAccountList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseBankAccountList>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/banks',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelResponseBankAccountList>(
        _result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleTypes> getVehicleTypes() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleTypes>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/vehicle/vehicle-types',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseVehicleTypes>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleBrands> getVehicleBrands(vehicleTypeId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleBrands>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/vehicle/vehicle-types/${vehicleTypeId}/brands',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelResponseVehicleBrands>(
        _result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleSeries> getVehicleSeries(
    brandId,
    vehicleTypeId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'vehicle_type_id': vehicleTypeId
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleSeries>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/vehicle/brands/${brandId}/series',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelResponseVehicleSeries>(
        _result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleVersions> getVehicleVersions(modelId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleVersions>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/vehicle/models/${modelId}/versions',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelResponseVehicleVersions>(
        _result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleModels> getVehicleModels(seriesId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleModels>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/vehicle/series/${seriesId}/models',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelResponseVehicleModels>(
        _result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleModelDetail> getVehicleModelDetail(modelId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleModelDetail>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/vehicle/models/${modelId}/details',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseVehicleModelDetail>(
            _result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleFuelTypes> getVehicleFuelTypes() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleFuelTypes>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/vehicle/fuel-types',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelResponseVehicleFuelTypes>(
        _result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleBodyTypes> getVehicleBodyTypes() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleBodyTypes>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/vehicle/body-types',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelResponseVehicleBodyTypes>(
        _result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleTranmissionType>
      getVehicleTranmissionTypes() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleTranmissionType>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/vehicle/transmission-types',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseVehicleTranmissionType>(
            _result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleTractionType> getVehicleTractionTypes() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleTractionType>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/vehicle/traction-types',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseVehicleTractionType>(
            _result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleDetail> getVehicleDetail(vehicleId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleDetail>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/vehicles/${vehicleId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelResponseVehicleDetail>(
        _result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleDetail> getVehicleInfo(vehicleId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleDetail>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/vehicles/${vehicleId}/basic-info',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelResponseVehicleDetail>(
        _result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleColors> getVehicleColors() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleColors>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/vehicle/colors',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelResponseVehicleColors>(
        _result.data!);
    return value;
  }

  @override
  Future<ModelResponseAccountingBook> getAccountingBooks({
    startDate,
    endDate,
    versusType,
    versusId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'filter[date][start]': startDate,
      r'filter[date][end]': endDate,
      r'filter[versus_type]': versusType,
      r'filter[versus_id]': versusId,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseAccountingBook>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/accounting/accounting-book/get-report',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelResponseAccountingBook>(
        _result.data!);
    return value;
  }

  @override
  Future<ModelResponseTurnover> getAccountingTurnover(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = JsonMapper.serialize(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseTurnover>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/accounting/turnover',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseTurnover>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseBranch> getBranch(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseBranch>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/branches/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseBranch>(_result.data!);
    return value;
  }

  @override
  Future<ResponseData<dynamic>> deleteBranch(branchId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseData<dynamic>>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/branches/${branchId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ResponseData<dynamic>>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseBranchList> getAutoGalleryBranch(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseBranchList>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/banks/${id}/branches',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseBranchList>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponsePaymentTypes> getPaymentTypes() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponsePaymentTypes>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/payment-types',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponsePaymentTypes>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponsePhotos> getVehiclePhotos(vehicleId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponsePhotos>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/vehicles/${vehicleId}/photos',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponsePhotos>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponsePhoto> makeCoverPhoto(
    vehicleId,
    photoId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ModelResponsePhoto>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/vehicles/${vehicleId}/photos/${photoId}/make-cover-photo',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponsePhoto>(_result.data!);
    return value;
  }

  @override
  Future<ResponseData<dynamic>> deletePhoto(
    vehicleId,
    photoId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseData<dynamic>>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/vehicles/${vehicleId}/photos/${photoId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ResponseData<dynamic>>(_result.data!);
    return value;
  }

  @override
  Future<ResponseData<dynamic>> deleteUser(
    userId, {
    isRecovery = true,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'is_recovery': isRecovery};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseData<dynamic>>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/users/${userId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ResponseData<dynamic>>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseUser> updateUser(
    userId, {
    required neighborhoodId,
    required firstName,
    required lastName,
    required dateOfBirth,
    required citizenNo,
    required mobileNumber,
    required email,
    required address,
    autoGalleryBranchId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'neighborhood_id': neighborhoodId,
      'first_name': firstName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth,
      'citizen_no': citizenNo,
      'mobile_number': mobileNumber,
      'email': email,
      'address': address,
      'auto_gallery_branch_id': autoGalleryBranchId,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ModelResponseUser>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/users/${userId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseUser>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseUser> addUser({
    required neighborhoodId,
    required firstName,
    required lastName,
    required dateOfBirth,
    required citizenNo,
    required mobileNumber,
    required email,
    required address,
    autoGalleryBranchId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'neighborhood_id': neighborhoodId,
      'first_name': firstName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth,
      'citizen_no': citizenNo,
      'mobile_number': mobileNumber,
      'email': email,
      'address': address,
      'auto_gallery_branch_id': autoGalleryBranchId,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ModelResponseUser>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/users',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseUser>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseCustomer> addCustomer({
    required companyTypeId,
    required firstName,
    required lastName,
    required mobileNumber,
    required email,
    title,
    dateOfBirth,
    neighborhoodId,
    citizenNo,
    address,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'company_type_id': companyTypeId,
      'first_name': firstName,
      'last_name': lastName,
      'mobile_number': mobileNumber,
      'email': email,
      'title': title,
      'date_of_birth': dateOfBirth,
      'neighborhood_id': neighborhoodId,
      'citizen_no': citizenNo,
      'address': address,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseCustomer>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/customers',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseCustomer>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseCustomer> updateCustomer(
    customerId, {
    required companyTypeId,
    required firstName,
    required lastName,
    required mobileNumber,
    required email,
    title,
    dateOfBirth,
    neighborhoodId,
    citizenNo,
    address,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'company_type_id': companyTypeId,
      'first_name': firstName,
      'last_name': lastName,
      'mobile_number': mobileNumber,
      'email': email,
      'title': title,
      'date_of_birth': dateOfBirth,
      'neighborhood_id': neighborhoodId,
      'citizen_no': citizenNo,
      'address': address,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseCustomer>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/customers/${customerId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseCustomer>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleDetail> createVehicle(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = JsonMapper.serialize(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleDetail>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/vehicles',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelResponseVehicleDetail>(
        _result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleDetail> updateVehicle(
    vehicleId,
    body,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = JsonMapper.serialize(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleDetail>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/vehicles/${vehicleId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelResponseVehicleDetail>(
        _result.data!);
    return value;
  }

  @override
  Future<ResponseData<dynamic>> deleteVehicle() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseData<dynamic>>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/vehicles/{id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ResponseData<dynamic>>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseQuery> getVehiclePartChangeRecords(vehicleId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ModelResponseQuery>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/vehicles/${vehicleId}/queries/part-change-records',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseQuery>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseQuery> getVehicleKilometerRecords(vehicleId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ModelResponseQuery>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/vehicles/${vehicleId}/queries/kilometer-records',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseQuery>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseQuery> getVehicleDamageRecords(vehicleId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ModelResponseQuery>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/vehicles/${vehicleId}/queries/damage-records',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseQuery>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseQueryDetail> getVehicleDamageRecordDetail(
    vehicleId,
    queryId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseQueryDetail>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'user/vehicles/${vehicleId}/queries/damage-records/${queryId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseQueryDetail>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseQueryDetail> getVehicleKilometerRecordDetail(
    vehicleId,
    queryId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseQueryDetail>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'user/vehicles/${vehicleId}/queries/kilometer-records/${queryId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseQueryDetail>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseQueryDetail> getVehiclePartChangeRecordDetail(
    vehicleId,
    queryId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseQueryDetail>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'user/vehicles/${vehicleId}/queries/part-change-records/${queryId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseQueryDetail>(_result.data!);
    return value;
  }

  @override
  Future<ResponseData<dynamic>> archiveVehicle(
    vehicleId,
    isRecovery,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'is_recovery': isRecovery};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseData<dynamic>>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/vehicles/${vehicleId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ResponseData<dynamic>>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleDetail> soldVehicle(
    vehicleId,
    body,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = JsonMapper.serialize(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleDetail>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/vehicles/${vehicleId}/sold',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelResponseVehicleDetail>(
        _result.data!);
    return value;
  }

  @override
  Future<ModelResponsePhotos> addPhoto(
    vehicleId,
    files,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = JsonMapper.serialize(files);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponsePhotos>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/vehicles/${vehicleId}/photos',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponsePhotos>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseUser> addPosDevice({
    required autoGalleryBranchId,
    required autoGalleryBankAccountId,
    required name,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'auto_gallery_branch_id': autoGalleryBranchId,
      'auto_gallery_bank_account_id': autoGalleryBankAccountId,
      'name': name,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ModelResponseUser>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/accounting/branch-pos-devices',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseUser>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseUser> updatePosDevice(
    accountId, {
    required autoGalleryBankAccountId,
    required autoGalleryBranchId,
    required name,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'auto_gallery_bank_account_id': autoGalleryBankAccountId,
      'auto_gallery_branch_id': autoGalleryBranchId,
      'name': name,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ModelResponseUser>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/accounting/branch-pos-devices/${accountId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseUser>(_result.data!);
    return value;
  }

  @override
  Future<ModelBankAccounts> addBankAccount({
    required bankBranchId,
    required name,
    required iban,
    required accountNumber,
    balance,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'bank_branch_id': bankBranchId,
      'name': name,
      'iban': iban,
      'account_number': accountNumber,
      'balance': balance,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ModelBankAccounts>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/accounting/bank-accounts/',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelBankAccounts>(_result.data!);
    return value;
  }

  @override
  Future<ModelBankAccounts> updateBankAccount(
    bankAccountId, {
    required name,
    required iban,
    required accountNumber,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'name': name,
      'iban': iban,
      'account_number': accountNumber,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ModelBankAccounts>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/accounting/bank-accounts/${bankAccountId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelBankAccounts>(_result.data!);
    return value;
  }

  @override
  Future<ModelBankAccounts> deleteBankAccount(bankAccountId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ModelBankAccounts>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/accounting/bank-accounts/${bankAccountId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelBankAccounts>(_result.data!);
    return value;
  }

  @override
  Future<ModelREsponseBankAccountInfo> getBankAccount(bankAccountId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelREsponseBankAccountInfo>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/accounting/bank-accounts/${bankAccountId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelREsponseBankAccountInfo>(
        _result.data!);
    return value;
  }

  @override
  Future<ModelResponseSideBar> getSidebar() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseSideBar>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/accounting/accounting-book/get-sidebar',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseSideBar>(_result.data!);
    return value;
  }

  @override
  Future<ResponseData<dynamic>> addAccountingBookData(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = JsonMapper.serialize(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseData<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/accounting/accounting-book',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ResponseData<dynamic>>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseAccountBookList> accountBookDetail(
    bankAccountId, {
    accountModel,
    accountId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'account_model': accountModel,
      'account_id': accountId,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseAccountBookList>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/accounting/accounting-book/{accountingBookId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelResponseAccountBookList>(
        _result.data!);
    return value;
  }

  @override
  Future<ModelResponseAccountBookList> getSelectedAccountBookDetail(
    accountModel,
    accountId,
    startDate,
    endDate,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'account_model': accountModel,
      r'account_id': accountId,
      r'filter[date[start]]': startDate,
      r'filter[date][end]': endDate,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseAccountBookList>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/accounting/accounting-book',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelResponseAccountBookList>(
        _result.data!);
    return value;
  }

  @override
  Future<ModelResponseTransactionCategories> getTransactionCategories() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseTransactionCategories>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/account-transaction-categories',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseTransactionCategories>(
            _result.data!);
    return value;
  }

  @override
  Future<ModelAccountingBook> updateAccountingBook(
    accountingBookId, {
    accountId,
    accountModel,
    transactionDate,
    transactionType,
    credit,
    amount,
    description,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'account_id': accountId,
      'account_model': accountModel,
      'transaction_date': transactionDate,
      'transaction_type': transactionType,
      'credit': credit,
      'amount': amount,
      'description': description,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelAccountingBook>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/accounting/{accountingBookId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelAccountingBook>(_result.data!);
    return value;
  }

  @override
  Future<ModelAccountingBook> deleteAccountingBook(
    accountingBookId, {
    accountId,
    accountModel,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'account_id': accountId,
      'account_model': accountModel,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelAccountingBook>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/accounting/{accountingBookId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelAccountingBook>(_result.data!);
    return value;
  }

  @override
  Future<ModelAccountingBook> addAccountingBook({
    accountId,
    accountModel,
    transactionDate,
    transactionType,
    credit,
    amount,
    description,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'account_id': accountId,
      'account_model': accountModel,
      'transaction_date': transactionDate,
      'transaction_type': transactionType,
      'credit': credit,
      'amount': amount,
      'description': description,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelAccountingBook>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/accounting',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelAccountingBook>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseQuery> getDamageRecordQueries() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ModelResponseQuery>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/queries/damage-record-queries',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseQuery>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseQueryDetail> getDamageRecordQuery(queryId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseQueryDetail>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/queries/damage-record-queries/${queryId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseQueryDetail>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseQuery> getKMRecordQueries() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ModelResponseQuery>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/queries/kilometer-record-queries',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseQuery>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseQueryDetail> getKMRecordQuery(queryId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseQueryDetail>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/queries/kilometer-record-queries/${queryId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseQueryDetail>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseQuery> getPartChangeRecordQueries() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ModelResponseQuery>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/queries/part-change-record-queries',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseQuery>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseQueryDetail> getPartChangeRecordQuery(queryId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseQueryDetail>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/queries/part-change-record-queries/${queryId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseQueryDetail>(_result.data!);
    return value;
  }

  @override
  Future<ResponseData<dynamic>> updateVehicleListingInformation(
    vehicleId,
    body,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = JsonMapper.serialize(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseData<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/vehicles/${vehicleId}/vehicle-listing-information',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ResponseData<dynamic>>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleCountDetail> getVehicleCountDetail() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleCountDetail>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/for-me/vehicle-count-detail',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseVehicleCountDetail>(
            _result.data!);
    return value;
  }

  @override
  Future<ModelResponseInspectionCompletion> getInspectionCompletion() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseInspectionCompletion>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/for-me/vehicle-inspection-completion',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseInspectionCompletion>(
            _result.data!);
    return value;
  }

  @override
  Future<ModelResponseInsuranceCompletion> getInsuranceCompletion() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseInsuranceCompletion>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/for-me/vehicle-insurance-completion',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseInsuranceCompletion>(
            _result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleReportChecklist>
      getVehicleReportChecklist() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleReportChecklist>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/color-report-checklists',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseVehicleReportChecklist>(
            _result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleColorFlawGroups>
      getVehicleColorFlawGroups() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleColorFlawGroups>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/color-flaw-groups',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseVehicleColorFlawGroups>(
            _result.data!);
    return value;
  }

  @override
  Future<ModelResponseMarketPlaceFilters> getMarketplaceFilters() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseMarketPlaceFilters>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/market-place/filters',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseMarketPlaceFilters>(
            _result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleListingInfo> getVehicleListingInfo(
      vehicleId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleListingInfo>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/vehicles/${vehicleId}/vehicle-listing-information',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseVehicleListingInfo>(
            _result.data!);
    return value;
  }

  @override
  Future<ModelResponseMarketplace> getMarketplace(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = JsonMapper.serialize(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseMarketplace>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/market-place',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ModelResponseMarketplace>(_result.data!);
    return value;
  }

  @override
  Future<ResponseData<dynamic>> publishAdd(
    vehicleId,
    body,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = JsonMapper.serialize(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseData<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/vehicles/${vehicleId}/publish',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ResponseData<dynamic>>(_result.data!);
    return value;
  }

  @override
  Future<ResponseData<dynamic>> updatePublishedAdd(
    vehicleId,
    body,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = JsonMapper.serialize(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseData<dynamic>>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/vehicles/${vehicleId}/publish',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ResponseData<dynamic>>(_result.data!);
    return value;
  }

  @override
  Future<ModelResponsePublicVehicle> getPublicVehicleDetail(vehicleId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponsePublicVehicle>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/public/market-place/${vehicleId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelResponsePublicVehicle>(
        _result.data!);
    return value;
  }

  @override
  Future<ModelResponsePublicVehicleList> getPublicVehicleList(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = JsonMapper.serialize(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponsePublicVehicleList>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/public/market-place',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelResponsePublicVehicleList>(
        _result.data!);
    return value;
  }

  @override
  Future<ModelResponsePublicVehicleBar> getPublicVehicleBar() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponsePublicVehicleBar>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/public/number-by-vehicle-type',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelResponsePublicVehicleBar>(
        _result.data!);
    return value;
  }

  @override
  Future<ModelResponsePublicVehicleCard> getPublicVehicleCards() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponsePublicVehicleCard>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/public/new-adverts',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelResponsePublicVehicleCard>(
        _result.data!);
    return value;
  }

  @override
  Future<ModelResponseVehicleStatus> getVehicleStatus(vehicleId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelResponseVehicleStatus>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/vehicles/${vehicleId}/archive-status',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = await IsolateHelper.parseJson<ModelResponseVehicleStatus>(
        _result.data!);
    return value;
  }

  @override
  Future<ResponseData<dynamic>> deleteAccountBookDetail(
    accountBookId,
    accountModel,
    accountId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'account_model': accountModel,
      'account_id': accountId,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseData<dynamic>>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/accounting/accounting-book/${accountBookId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        await IsolateHelper.parseJson<ResponseData<dynamic>>(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
