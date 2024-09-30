import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../enums/enum_api.dart';
import '../models/model_account_book_list.dart';
import '../models/model_accounting_book.dart';
import '../models/model_advert_owner_type.dart';
import '../models/model_balance_top_up.dart';
import '../models/model_branches.dart';
import '../models/model_buy_sell_chart.dart';
import '../models/model_customer.dart';
import '../models/model_district.dart';
import '../models/model_neighborhood.dart';
import '../models/model_payment_type.dart';
import '../models/model_photo.dart';
import '../models/model_pos_devices.dart';
import '../models/model_public_vehicle_bar.dart';
import '../models/model_public_vehicle_card_detail.dart';
import '../models/model_public_vehicle_list.dart';
import '../models/model_purchase_payment.dart';
import '../models/model_query.dart';
import '../models/model_sidebar.dart';
import '../models/model_turnover.dart';
import '../models/model_user_info.dart';
import '../models/model_value.dart';
import '../models/model_value_label.dart';
import '../models/model_vehicle.dart';
import '../models/model_vehicle_archive.dart';
import '../models/model_vehicle_body_type.dart';
import '../models/model_vehicle_brands.dart';
import '../models/model_vehicle_color.dart';
import '../models/model_vehicle_equipment.dart';
import '../models/model_vehicle_experties.dart';
import '../models/model_vehicle_fuel_type.dart';
import '../models/model_vehicle_model.dart';
import '../models/model_vehicle_series.dart';
import '../models/model_vehicle_traction_type.dart';
import '../models/model_vehicle_transmission_type.dart';
import '../models/model_vehicle_type.dart';
import '../models/model_vehicle_version.dart';
import '../models/request/model_request_payment_type.dart';
import '../models/request/model_request_vehicle.dart';
import '../models/response/model_response_bank_accounts.dart';
import '../models/response/model_response_city.dart';
import '../models/response/model_response_country.dart';
import '../models/response/model_response_inspection_completion.dart';
import '../models/response/model_response_insurance_completion.dart';
import '../models/response/model_response_marketplace.dart';
import '../models/response/model_response_vehicle_color_flaw_groups.dart';
import '../models/response/model_response_vehicle_report_checklist.dart';
import '../models/response/model_transaction_categories.dart';

class ServiceJsonMapperContext {
  ServiceJsonMapperContext() {
    JsonMapper().useAdapter(
      JsonMapperAdapter(
        enumValues: {
          PaymentType: EnumDescriptor(
            values: PaymentType.values,
            mapping: {...Map.fromEntries(List.generate(PaymentType.values.length, (index) => MapEntry(PaymentType.values[index], PaymentType.values[index].id)))},
          ),
          QueryType: EnumDescriptor(
            values: QueryType.values,
            mapping: {...Map.fromEntries(List.generate(QueryType.values.length, (index) => MapEntry(QueryType.values[index], QueryType.values[index].id)))},
          ),
          VehicleStatus: EnumDescriptor(
            values: VehicleStatus.values,
            mapping: {...Map.fromEntries(List.generate(VehicleStatus.values.length, (index) => MapEntry(VehicleStatus.values[index], VehicleStatus.values[index].id)))},
          ),
        },
        valueDecorators: {
          typeOf<List<String>>(): (value) => value.cast<String>(),
          typeOf<List<int>>(): (value) => value.cast<int>(),
          typeOf<List<ModelCountry>>(): (value) => value.cast<ModelCountry>(),
          typeOf<List<ModelCity>>(): (value) => value.cast<ModelCity>(),
          typeOf<List<ModelDistrict>>(): (value) => value.cast<ModelDistrict>(),
          typeOf<List<ModelVehicle>>(): (value) => value.cast<ModelVehicle>(),
          typeOf<List<ModelVehicleArchive>>(): (value) => value.cast<ModelVehicleArchive>(),
          typeOf<List<ModelSellChartDataSet>>(): (value) => value.cast<ModelSellChartDataSet>(),
          typeOf<List<ModelBankAccounts>>(): (value) => value.cast<ModelBankAccounts>(),
          typeOf<List<ModelBranchPosDevice>>(): (value) => value.cast<ModelBranchPosDevice>(),
          typeOf<List<ModelBalanceTopUp>>(): (value) => value.cast<ModelBalanceTopUp>(),
          typeOf<List<ModelCustomer>>(): (value) => value.cast<ModelCustomer>(),
          typeOf<List<ModelBranch>>(): (value) => value.cast<ModelBranch>(),
          typeOf<List<ModelUserInfo>>(): (value) => value.cast<ModelUserInfo>(),
          typeOf<List<ModelAutoGalleryBankAccount>>(): (value) => value.cast<ModelAutoGalleryBankAccount>(),
          typeOf<List<ModelVehicleBrand>>(): (value) => value.cast<ModelVehicleBrand>(),
          typeOf<List<ModelVehicleSeries>>(): (value) => value.cast<ModelVehicleSeries>(),
          typeOf<List<ModelVehicleModel>>(): (value) => value.cast<ModelVehicleModel>(),
          typeOf<List<ModelVehicleTransmissionType>>(): (value) => value.cast<ModelVehicleTransmissionType>(),
          typeOf<List<ModelVehicleFuelType>>(): (value) => value.cast<ModelVehicleFuelType>(),
          typeOf<List<ModelVehicleBodyType>>(): (value) => value.cast<ModelVehicleBodyType>(),
          typeOf<List<ModelPurchasePayment>>(): (value) => value.cast<ModelPurchasePayment>(),
          typeOf<List<ModelAccountingBook>>(): (value) => value.cast<ModelAccountingBook>(),
          typeOf<List<ModelTurnoverItem>>(): (value) => value.cast<ModelTurnoverItem>(),
          typeOf<List<ModelTurnover>>(): (value) => value.cast<ModelTurnover>(),
          typeOf<List<ModelTurnoverData>>(): (value) => value.cast<ModelTurnoverData>(),
          typeOf<List<ModelAutoGalleryBranch>>(): (value) => value.cast<ModelAutoGalleryBranch>(),
          typeOf<List<ModelPaymentType>>(): (value) => value.cast<ModelPaymentType>(),
          typeOf<List<ModelValue>>(): (value) => value.cast<ModelValue>(),
          typeOf<List<ModelCategoryItem>>(): (value) => value.cast<ModelCategoryItem>(),
          typeOf<List<ModelPhoto>>(): (value) => value.cast<ModelPhoto>(),
          typeOf<List<ModelNeighborhood>>(): (value) => value.cast<ModelNeighborhood>(),
          typeOf<List<ModelVehicleTractionType>>(): (value) => value.cast<ModelVehicleTractionType>(),
          typeOf<List<ModelRequestPaymentType>>(): (value) => value.cast<ModelRequestPaymentType>(),
          typeOf<List<ModelSideBar>>(): (value) => value.cast<ModelSideBar>(),
          typeOf<List<ModelQuery>>(): (value) => value.cast<ModelQuery>(),
          typeOf<List<ModelTransactionCategories>>(): (value) => value.cast<ModelTransactionCategories>(),
          typeOf<List<ModelAccountBookList>>(): (value) => value.cast<ModelAccountBookList>(),
          typeOf<List<ModelVehicleType>>(): (value) => value.cast<ModelVehicleType>(),
          typeOf<List<ModelVehicleColor>>(): (value) => value.cast<ModelVehicleColor>(),
          typeOf<List<ModelInspectionCompletion>>(): (value) => value.cast<ModelInspectionCompletion>(),
          typeOf<List<ModelInsuranceCompletion>>(): (value) => value.cast<ModelInsuranceCompletion>(),
          typeOf<List<ModelVehicleVersion>>(): (value) => value.cast<ModelVehicleVersion>(),
          typeOf<List<ModelVehicleReportChecklist>>(): (value) => value.cast<ModelVehicleReportChecklist>(),
          typeOf<List<ModelVehicleColorFlawGroup>>(): (value) => value.cast<ModelVehicleColorFlawGroup>(),
          typeOf<List<ModelRequestColorFlaws>>(): (value) => value.cast<ModelRequestColorFlaws>(),
          typeOf<List<ModelVehicleExperties>>(): (value) => value.cast<ModelVehicleExperties>(),
          typeOf<List<ModelValueLabel>>(): (value) => value.cast<ModelValueLabel>(),
          typeOf<List<ModelMarketplaceAds>>(): (value) => value.cast<ModelMarketplaceAds>(),
          typeOf<List<ModelVehicleResponse>>(): (value) => value.cast<ModelVehicleResponse>(),
          typeOf<List<ModelPublicVehicleBar>>(): (value) => value.cast<ModelPublicVehicleBar>(),
          typeOf<List<ModelPublicVehicleCardDetail>>(): (value) => value.cast<ModelPublicVehicleCardDetail>(),
          typeOf<List<ModelVehicleEquipment>>(): (value) => value.cast<ModelVehicleEquipment>(),
          typeOf<List<ModelAdwertOwnerType>>(): (value) => value.cast<ModelAdwertOwnerType>(),
        },
      ),
    );
  }
}
