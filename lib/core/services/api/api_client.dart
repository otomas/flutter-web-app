import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../constants/app_config.dart';
import '../../models/model_accounting_book.dart';
import '../../models/request/model_request_add_accounting_book.dart';
import '../../models/request/model_request_add_photo.dart';
import '../../models/request/model_request_filter_date.dart';
import '../../models/request/model_request_filter_marketplace.dart';
import '../../models/request/model_request_publish_ad.dart';
import '../../models/request/model_request_register.dart';
import '../../models/request/model_request_register_device.dart';
import '../../models/request/model_request_vehicle.dart';
import '../../models/request/model_request_vehicle_info.dart';
import '../../models/request/model_request_vehicle_sold.dart';
import '../../models/response/model_response_account_book_list.dart';
import '../../models/response/model_response_accounting_book.dart';
import '../../models/response/model_response_balance_top_up.dart';
import '../../models/response/model_response_bank_account_info.dart';
import '../../models/response/model_response_bank_account_list.dart';
import '../../models/response/model_response_bank_accounts.dart';
import '../../models/response/model_response_branch.dart';
import '../../models/response/model_response_branch_list.dart';
import '../../models/response/model_response_branch_pos_device.dart';
import '../../models/response/model_response_branch_pos_devices.dart';
import '../../models/response/model_response_branches.dart';
import '../../models/response/model_response_buy_sell_chart.dart';
import '../../models/response/model_response_city.dart';
import '../../models/response/model_response_country.dart';
import '../../models/response/model_response_customer.dart';
import '../../models/response/model_response_district.dart';
import '../../models/response/model_response_inspection_completion.dart';
import '../../models/response/model_response_insurance_completion.dart';
import '../../models/response/model_response_login.dart';
import '../../models/response/model_response_marketplace.dart';
import '../../models/response/model_response_marketplace_filters.dart';
import '../../models/response/model_response_neighbourhood.dart';
import '../../models/response/model_response_payment_type.dart';
import '../../models/response/model_response_photo.dart';
import '../../models/response/model_response_public_vehicle.dart';
import '../../models/response/model_response_public_vehicle_bar.dart';
import '../../models/response/model_response_public_vehicle_card.dart';
import '../../models/response/model_response_query.dart';
import '../../models/response/model_response_sidebar.dart';
import '../../models/response/model_response_string.dart';
import '../../models/response/model_response_till_report.dart';
import '../../models/response/model_response_transaction_categories.dart';
import '../../models/response/model_response_turnover.dart';
import '../../models/response/model_response_user.dart';
import '../../models/response/model_response_user_profile.dart';
import '../../models/response/model_response_users.dart';
import '../../models/response/model_response_vehicle.dart';
import '../../models/response/model_response_vehicle_body_type.dart';
import '../../models/response/model_response_vehicle_brand.dart';
import '../../models/response/model_response_vehicle_color.dart';
import '../../models/response/model_response_vehicle_color_flaw_groups.dart';
import '../../models/response/model_response_vehicle_count_detail.dart';
import '../../models/response/model_response_vehicle_detail.dart';
import '../../models/response/model_response_vehicle_fuel_type.dart';
import '../../models/response/model_response_vehicle_listing_info.dart';
import '../../models/response/model_response_vehicle_model.dart';
import '../../models/response/model_response_vehicle_model_detail.dart';
import '../../models/response/model_response_vehicle_report_checklist.dart';
import '../../models/response/model_response_vehicle_series.dart';
import '../../models/response/model_response_vehicle_status.dart';
import '../../models/response/model_response_vehicle_traction_type.dart';
import '../../models/response/model_response_vehicle_transmission_type.dart';
import '../../models/response/model_response_vehicle_type.dart';
import '../../models/response/model_response_vehicle_version.dart';
import '../../models/response_data.dart';
import '../../utils/isolate_helper.dart';

part 'api_client.g.dart';

@RestApi(parser: Parser.DartJsonMapper)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST('user/auth/register')
  Future<ResponseData> register(@Body() ModelRequestRegister body);

  @FormUrlEncoded()
  @POST('/system/devices')
  Future<ModelResponseString> deviceRegister({
    @Field('device_id') required String deviceId,
    @Field('fcm_token') required String fcmToken,
    @Field('platform') required String platform,
    @Field('locale') required String locale,
    @Field('mac_address') String? macAddress,
    @Field('latitude') num? latitude = 0,
    @Field('longitude') num? longitude = 0,
    @Field('is_active') bool isActive = true,
  });

  @PUT('/Device/{id}')
  Future<ModelResponseString> deviceUpdate(@Path('id') String deviceId, @Body() ModelRequestDeviceUpdate body);

  @FormUrlEncoded()
  @POST('/user/oauth/token')
  Future<ModelResponseLogin> login({
    @Field('username') required String username,
    @Field('password') required String password,
    @Field('tax_number') required String taxNumber,
    @Field('grant_type') String grantType = 'password',
    @Field('client_id') String clientId = clientId,
    @Field('client_secret') String clientSecret = clientSecret,
    @Field('scope') String scope = '',
  });

  @FormUrlEncoded()
  @POST('/user/auth/password/forgot')
  Future<ModelResponseString> forgotPassword({
    @Field('auto_gallery_tax_no') required String taxNo,
    @Field('email') required String email,
  });

  @GET('/common/countries')
  Future<ModelResponseCountryList> getCountries();

  @GET('/common/countries/{countryId}/provinces')
  Future<ModelResponseCityList> getCities(@Path('countryId') int countryId);

  @GET('/common/provinces')
  Future<ModelResponseCityList> getCitiesList();

  @GET('/common/provinces/{cityId}/districts')
  Future<ModelResponseDistrictList> getDistricts(@Path('cityId') int cityId);

  @GET('/common/districts/{districtId}/neighborhoods')
  Future<ModelResponseNeighbourhoodList> getNeighbourhood(@Path('districtId') int districtId);

  @GET('/user/for-me/till-report')
  Future<ModelResponseTillReport> getTillReport();

  @GET('/user/for-me/buy-sell-chart')
  Future<ModelResponseBuySellChart> getBuySellChart();

  @GET('/user/vehicles')
  Future<ModelResponseVehicleList> getVehicles({
    @Query('start') int? start,
    @Query('length') int? length,
    @Query('search[value]') String? search,
    @Query('order[0][column]') String? orderByField,
    @Query('order[0][dir]') String? orderByDirection,
  });

  @GET('/user/vehicles/sales')
  Future<ModelResponseVehicleList> getVehiclesSales({
    @Query('start') int? start,
    @Query('length') int? length,
    @Query('search[value]') String? search,
    @Query('order[0][column]') String? orderByField,
    @Query('order[0][dir]') String? orderByDirection,
  });

  @GET('/user/vehicles/inventory')
  Future<ModelResponseVehicleList> getVehiclesInventory({
    @Query('start') int? start,
    @Query('length') int? length,
    @Query('search[value]') String? search,
    @Query('order[0][column]') String? orderByField,
    @Query('order[0][dir]') String? orderByDirection,
  });

  @GET('/user/vehicles/consignee')
  Future<ModelResponseVehicleList> getVehiclesConsignment({
    @Query('start') int? start,
    @Query('length') int? length,
    @Query('search[value]') String? search,
    @Query('order[0][column]') String? orderByField,
    @Query('order[0][dir]') String? orderByDirection,
  });

  @GET('/user/vehicles/deleted')
  Future<ModelResponseVehicleList> getVehiclesDeleted({
    @Query('start') int? start,
    @Query('length') int? length,
    @Query('search[value]') String? search,
    @Query('order[0][column]') String? orderByField,
    @Query('order[0][dir]') String? orderByDirection,
  });

  @GET('/user/customers')
  Future<ModelResponseCustomerList> getCustomers({
    @Query('start') int? start,
    @Query('length') int? length,
    @Query('search[value]') String? search,
    @Query('order[0][column]') String? orderByField,
    @Query('order[0][dir]') String? orderByDirection,
  });

  @GET('/user/customers/{id}')
  Future<ModelResponseCustomer> getCustomer(@Path('id') int id);

  @GET('/user/accounting/bank-accounts')
  Future<ModelResponseBankAccounts> getBankAccounts(
    @Query('start') int? start,
    @Query('length') int? length,
    @Query('search[value]') String? search,
  );

  @GET('/user/accounting/branch-pos-devices')
  Future<ModelResponseBranchPosDevices> getBranchPosDevices(
    @Query('start') int? start,
    @Query('length') int? length,
  );

  @GET('/user/accounting/branch-pos-devices/{id}')
  Future<ModelResponseBranchPosDevice> getBranchPosDeviceDetail(@Path('id') int id);

  @GET('/user/accounting/balance-payments')
  Future<ModelResponseBalanceTopUp> getBalanceTopUp(
    @Query('start') int? start,
    @Query('length') int? length,
    @Query('search[value]') String? search,
  );

  @GET('/user/branches')
  Future<ModelResponseBranches> getBranches(
    @Query('start') int? start,
    @Query('length') int? length,
    @Query('search[value]') String? search,
  );

  @FormUrlEncoded()
  @POST('/user/branches')
  Future<ModelResponseBranch> createBranch(
    @Field('neighborhood_id') int neighborhoodId,
    @Field('name') String name,
    @Field('phone_number') String phoneNumber,
    @Field('address') String address,
  );

  @FormUrlEncoded()
  @PUT('/user/branches/{branchId}')
  Future<ModelResponseBranch> updateBranch(
    @Path('branchId') int branchId,
    @Field('neighborhood_id') int neighborhoodId,
    @Field('name') String name,
    @Field('phone_number') String phoneNumber,
    @Field('address') String address,
  );

  @GET('/user/users')
  Future<ModelResponseUsers> getUsers(
    @Query('start') int? start,
    @Query('length') int? length,
    @Query('search[value]') String? search,
    @Query('order[0][column]') String? orderByField,
    @Query('order[0][dir]') String? orderByDirection,
  );

  @GET('/user/users/{id}')
  Future<ModelResponseUser> getUser(@Path('id') int id);

  @GET('/user/auth/profile')
  Future<ModelResponseUserProfile> getUserProfile();

  @GET('/common/banks')
  Future<ModelResponseBankAccountList> getBankAccountList();

  @GET('/common/vehicle/vehicle-types')
  Future<ModelResponseVehicleTypes> getVehicleTypes();

  @GET('/common/vehicle/vehicle-types/{vehicleTypeId}/brands')
  Future<ModelResponseVehicleBrands> getVehicleBrands(@Path('vehicleTypeId') int vehicleTypeId);

  @GET('/common/vehicle/brands/{brandId}/series')
  Future<ModelResponseVehicleSeries> getVehicleSeries(@Path('brandId') int brandId, @Query('vehicle_type_id') int vehicleTypeId);

  @GET('/common/vehicle/models/{modelId}/versions')
  Future<ModelResponseVehicleVersions> getVehicleVersions(@Path('modelId') int modelId);

  @GET('/common/vehicle/series/{seriesId}/models')
  Future<ModelResponseVehicleModels> getVehicleModels(@Path('seriesId') int seriesId);

  @GET('/common/vehicle/models/{modelId}/details')
  Future<ModelResponseVehicleModelDetail> getVehicleModelDetail(@Path('modelId') int modelId);

  @GET('/common/vehicle/fuel-types')
  Future<ModelResponseVehicleFuelTypes> getVehicleFuelTypes();

  @GET('/common/vehicle/body-types')
  Future<ModelResponseVehicleBodyTypes> getVehicleBodyTypes();

  @GET('/common/vehicle/transmission-types')
  Future<ModelResponseVehicleTranmissionType> getVehicleTranmissionTypes();

  @GET('/common/vehicle/traction-types')
  Future<ModelResponseVehicleTractionType> getVehicleTractionTypes();

  @GET('/user/vehicles/{vehicleId}')
  Future<ModelResponseVehicleDetail> getVehicleDetail(@Path('vehicleId') int vehicleId);

  @GET('/user/vehicles/{vehicleId}/basic-info')
  Future<ModelResponseVehicleDetail> getVehicleInfo(@Path('vehicleId') int vehicleId);

  @GET('/common/vehicle/colors')
  Future<ModelResponseVehicleColors> getVehicleColors();

  @GET('/user/accounting/accounting-book/get-report')
  Future<ModelResponseAccountingBook> getAccountingBooks({
    @Query('filter[date][start]') String? startDate,
    @Query('filter[date][end]') String? endDate,
    @Query('filter[versus_type]') String? versusType,
    @Query('filter[versus_id]') num? versusId,
  });

  @GET('/user/accounting/turnover')
  Future<ModelResponseTurnover> getAccountingTurnover(@Body() ModelRequestFilteredDate? body);

  @GET('/user/branches/{id}')
  Future<ModelResponseBranch> getBranch(@Path('id') int id);

  @DELETE('/user/branches/{branchId}')
  Future<ResponseData> deleteBranch(@Path('branchId') int branchId);

  @GET('/common/banks/{bankId}/branches')
  Future<ModelResponseBranchList> getAutoGalleryBranch(@Path('bankId') int id);

  @GET('/user/payment-types')
  Future<ModelResponsePaymentTypes> getPaymentTypes();

  @GET('/user/vehicles/{vehicleId}/photos')
  Future<ModelResponsePhotos> getVehiclePhotos(@Path('vehicleId') int vehicleId);

  @POST('/user/vehicles/{vehicleId}/photos/{photoId}/make-cover-photo')
  Future<ModelResponsePhoto> makeCoverPhoto(@Path('vehicleId') int vehicleId, @Path('photoId') int photoId);

  @DELETE('/user/vehicles/{vehicleId}/photos/{photoId}')
  Future<ResponseData> deletePhoto(@Path('vehicleId') int vehicleId, @Path('photoId') int photoId);

  @FormUrlEncoded()
  @DELETE('/user/users/{userId}')
  Future<ResponseData> deleteUser(@Path('userId') int userId, {@Field('is_recovery') bool isRecovery = true});

  @FormUrlEncoded()
  @PUT('/user/users/{userId}')
  Future<ModelResponseUser> updateUser(
    @Path('userId') int userId, {
    @Field('neighborhood_id') required int neighborhoodId,
    @Field('first_name') required String firstName,
    @Field('last_name') required String lastName,
    @Field('date_of_birth') required String dateOfBirth,
    @Field('citizen_no') required String citizenNo,
    @Field('mobile_number') required String mobileNumber,
    @Field('email') required String email,
    @Field('address') required String address,
    @Field('auto_gallery_branch_id') int? autoGalleryBranchId,
  });

  @FormUrlEncoded()
  @POST('/user/users')
  Future<ModelResponseUser> addUser({
    @Field('neighborhood_id') required int neighborhoodId,
    @Field('first_name') required String firstName,
    @Field('last_name') required String lastName,
    @Field('date_of_birth') required String dateOfBirth,
    @Field('citizen_no') required String citizenNo,
    @Field('mobile_number') required String mobileNumber,
    @Field('email') required String email,
    @Field('address') required String address,
    @Field('auto_gallery_branch_id') int? autoGalleryBranchId,
  });

  @FormUrlEncoded()
  @POST('/user/customers')
  Future<ModelResponseCustomer> addCustomer({
    @Field('company_type_id') required int companyTypeId,
    @Field('first_name') required String firstName,
    @Field('last_name') required String lastName,
    @Field('mobile_number') required String mobileNumber,
    @Field('email') required String email,
    @Field('title') String? title,
    @Field('date_of_birth') String? dateOfBirth,
    @Field('neighborhood_id') int? neighborhoodId,
    @Field('citizen_no') String? citizenNo,
    @Field('address') String? address,
  });

  @FormUrlEncoded()
  @PUT('/user/customers/{customerId}')
  Future<ModelResponseCustomer> updateCustomer(
    @Path('customerId') int customerId, {
    @Field('company_type_id') required int companyTypeId,
    @Field('first_name') required String firstName,
    @Field('last_name') required String lastName,
    @Field('mobile_number') required String mobileNumber,
    @Field('email') required String email,
    @Field('title') String? title,
    @Field('date_of_birth') String? dateOfBirth,
    @Field('neighborhood_id') int? neighborhoodId,
    @Field('citizen_no') String? citizenNo,
    @Field('address') String? address,
  });

  @POST('/user/vehicles')
  Future<ModelResponseVehicleDetail> createVehicle(@Body() ModelRequestVehicle body);

  @PUT('/user/vehicles/{vehicleId}')
  Future<ModelResponseVehicleDetail> updateVehicle(@Path('vehicleId') int vehicleId, @Body() ModelRequestVehicle body);

  @DELETE('/user/vehicles/{id}')
  Future<ResponseData> deleteVehicle();

  @GET('/user/vehicles/{vehicleId}/queries/part-change-records')
  Future<ModelResponseQuery> getVehiclePartChangeRecords(@Path('vehicleId') int vehicleId);

  @GET('/user/vehicles/{vehicleId}/queries/kilometer-records')
  Future<ModelResponseQuery> getVehicleKilometerRecords(@Path('vehicleId') int vehicleId);

  @GET('/user/vehicles/{vehicleId}/queries/damage-records')
  Future<ModelResponseQuery> getVehicleDamageRecords(@Path('vehicleId') int vehicleId);

  @GET('user/vehicles/{vehicleId}/queries/damage-records/{queryId}')
  Future<ModelResponseQueryDetail> getVehicleDamageRecordDetail(@Path('vehicleId') int vehicleId, @Path('queryId') int queryId);

  @GET('user/vehicles/{vehicleId}/queries/kilometer-records/{queryId}')
  Future<ModelResponseQueryDetail> getVehicleKilometerRecordDetail(@Path('vehicleId') int vehicleId, @Path('queryId') int queryId);

  @GET('user/vehicles/{vehicleId}/queries/part-change-records/{queryId}')
  Future<ModelResponseQueryDetail> getVehiclePartChangeRecordDetail(@Path('vehicleId') int vehicleId, @Path('queryId') int queryId);

  @FormUrlEncoded()
  @DELETE('/user/vehicles/{vehicleId}')
  Future<ResponseData> archiveVehicle(@Path('vehicleId') int vehicleId, @Field('is_recovery') bool isRecovery);

  @POST('/user/vehicles/{vehicleId}/sold')
  Future<ModelResponseVehicleDetail> soldVehicle(@Path('vehicleId') int vehicleId, @Body() ModelRequestVehicleSold body);

  @POST('/user/vehicles/{vehicleId}/photos')
  Future<ModelResponsePhotos> addPhoto(@Path('vehicleId') int vehicleId, @Body() ModelRequestAddPhoto files);

  @FormUrlEncoded()
  @POST('/user/accounting/branch-pos-devices')
  Future<ModelResponseUser> addPosDevice({
    @Field('auto_gallery_branch_id') required int autoGalleryBranchId,
    @Field('auto_gallery_bank_account_id') required int autoGalleryBankAccountId,
    @Field('name') required String name,
  });

  @FormUrlEncoded()
  @PUT('/user/accounting/branch-pos-devices/{accountId}')
  Future<ModelResponseUser> updatePosDevice(
    @Path('accountId') int accountId, {
    @Field('auto_gallery_bank_account_id') required int autoGalleryBankAccountId,
    @Field('auto_gallery_branch_id') required int autoGalleryBranchId,
    @Field('name') required String name,
  });

  @FormUrlEncoded()
  @POST('/user/accounting/bank-accounts/')
  Future<ModelBankAccounts> addBankAccount({
    @Field('bank_branch_id') required int bankBranchId,
    @Field('name') required String name,
    @Field('iban') required String iban,
    @Field('account_number') required String accountNumber,
    @Field('balance') num? balance,
  });

  @FormUrlEncoded()
  @PUT('/user/accounting/bank-accounts/{bankAccountId}')
  Future<ModelBankAccounts> updateBankAccount(
    @Path('bankAccountId') int bankAccountId, {
    @Field('name') required String name,
    @Field('iban') required String iban,
    @Field('account_number') required String accountNumber,
  });

  @FormUrlEncoded()
  @DELETE('/user/accounting/bank-accounts/{bankAccountId}')
  Future<ModelBankAccounts> deleteBankAccount(@Path('bankAccountId') int bankAccountId);

  @FormUrlEncoded()
  @GET('/user/accounting/bank-accounts/{bankAccountId}')
  Future<ModelREsponseBankAccountInfo> getBankAccount(@Path('bankAccountId') int bankAccountId);

  @GET('/user/accounting/accounting-book/get-sidebar')
  Future<ModelResponseSideBar> getSidebar();

  @POST('/user/accounting/accounting-book')
  Future<ResponseData> addAccountingBookData(@Body() ModelRequestAddAccountingBook body);

  @GET('/user/accounting/accounting-book/{accountingBookId}')
  Future<ModelResponseAccountBookList> accountBookDetail(
    @Path('bankAccountId') int bankAccountId, {
    @Field('account_model') String? accountModel,
    @Field('account_id') num? accountId,
  });

  @GET('/user/accounting/accounting-book')
  Future<ModelResponseAccountBookList> getSelectedAccountBookDetail(
    @Query('account_model') String accountModel,
    @Query('account_id') num accountId,
    @Query('filter[date[start]]') String? startDate,
    @Query('filter[date][end]') String? endDate,
  );

  @GET('/common/account-transaction-categories')
  Future<ModelResponseTransactionCategories> getTransactionCategories();

  @FormUrlEncoded()
  @PUT('/user/accounting/{accountingBookId}')
  Future<ModelAccountingBook> updateAccountingBook(
    @Path('account_model') num? accountingBookId, {
    @Field('account_id') num? accountId,
    @Field('account_model') String? accountModel,
    @Field('transaction_date') String? transactionDate,
    @Field('transaction_type') String? transactionType,
    @Field('credit') num? credit,
    @Field('amount') num? amount,
    @Field('description') String? description,
  });

  @FormUrlEncoded()
  @DELETE('/user/accounting/{accountingBookId}')
  Future<ModelAccountingBook> deleteAccountingBook(
    @Path('account_model') num? accountingBookId, {
    @Field('account_id') num? accountId,
    @Field('account_model') String? accountModel,
  });

  @FormUrlEncoded()
  @POST('/user/accounting')
  Future<ModelAccountingBook> addAccountingBook({
    @Field('account_id') num? accountId,
    @Field('account_model') String? accountModel,
    @Field('transaction_date') String? transactionDate,
    @Field('transaction_type') String? transactionType,
    @Field('credit') num? credit,
    @Field('amount') num? amount,
    @Field('description') String? description,
  });

  @GET('/user/queries/damage-record-queries')
  Future<ModelResponseQuery> getDamageRecordQueries();

  @GET('/user/queries/damage-record-queries/{queryId}')
  Future<ModelResponseQueryDetail> getDamageRecordQuery(@Path('queryId') int queryId);

  @GET('/user/queries/kilometer-record-queries')
  Future<ModelResponseQuery> getKMRecordQueries();

  @GET('/user/queries/kilometer-record-queries/{queryId}')
  Future<ModelResponseQueryDetail> getKMRecordQuery(@Path('queryId') int queryId);

  @GET('/user/queries/part-change-record-queries')
  Future<ModelResponseQuery> getPartChangeRecordQueries();

  @GET('/user/queries/part-change-record-queries/{queryId}')
  Future<ModelResponseQueryDetail> getPartChangeRecordQuery(@Path('queryId') int queryId);

  @POST('/user/vehicles/{vehicleId}/vehicle-listing-information')
  Future<ResponseData> updateVehicleListingInformation(@Path('vehicleId') int vehicleId, @Body() ModelRequestVehicleInfo body);

  @GET('/user/for-me/vehicle-count-detail')
  Future<ModelResponseVehicleCountDetail> getVehicleCountDetail();

  @GET('/user/for-me/vehicle-inspection-completion')
  Future<ModelResponseInspectionCompletion> getInspectionCompletion();

  @GET('/user/for-me/vehicle-insurance-completion')
  Future<ModelResponseInsuranceCompletion> getInsuranceCompletion();

  @GET('/common/color-report-checklists')
  Future<ModelResponseVehicleReportChecklist> getVehicleReportChecklist();

  @GET('/common/color-flaw-groups')
  Future<ModelResponseVehicleColorFlawGroups> getVehicleColorFlawGroups();

  @GET('/user/market-place/filters')
  Future<ModelResponseMarketPlaceFilters> getMarketplaceFilters();

  @GET('/user/vehicles/{vehicleId}/vehicle-listing-information')
  Future<ModelResponseVehicleListingInfo> getVehicleListingInfo(@Path('vehicleId') int vehicleId);

  @POST('/user/market-place')
  Future<ModelResponseMarketplace> getMarketplace(@Body() ModelRequestFilterMarketplace body);

  @POST('/user/vehicles/{vehicleId}/publish')
  Future<ResponseData> publishAdd(@Path('vehicleId') int vehicleId, @Body() ModelRequestPublishAd body);

  @PUT('/user/vehicles/{vehicleId}/publish')
  Future<ResponseData> updatePublishedAdd(@Path('vehicleId') int vehicleId, @Body() ModelRequestPublishAd body);

  @GET('/public/market-place/{vehicleId}')
  Future<ModelResponsePublicVehicle> getPublicVehicleDetail(@Path('vehicleId') int vehicleId);

  @GET('/public/number-by-vehicle-type')
  Future<ModelResponsePublicVehicleBar> getPublicVehicleBar();

  @GET('/public/new-adverts')
  Future<ModelResponsePublicVehicleCard> getPublicVehicleCards();
  
  @GET('/user/vehicles/{vehicleId}/archive-status')
  Future<ModelResponseVehicleStatus> getVehicleStatus(@Path('vehicleId') int vehicleId);

}
