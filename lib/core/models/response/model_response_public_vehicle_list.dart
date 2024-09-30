import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../model_public_vehicle_card_detail.dart';
import '../response_data.dart';
import 'model_response_marketplace.dart';

@jsonSerializable
class ModelResponsePublicVehicleList extends ResponseData {
  const ModelResponsePublicVehicleList({
    super.status = false,
    super.error,
    this.data,
  });
  final ModelPublicVehicleListResponse? data;
}

@jsonSerializable
class ModelPublicVehicleListResponse {
  const ModelPublicVehicleListResponse({this.ads, this.filters});

  final List<ModelPublicVehicleCardDetail>? ads;
  final ModelMarketplaceResponseFilter? filters;
}
