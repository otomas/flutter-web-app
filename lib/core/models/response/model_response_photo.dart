import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../model_photo.dart';
import '../response_data.dart';

@jsonSerializable
class ModelResponsePhotos extends ResponseData {
  const ModelResponsePhotos({
    super.status = false,
    super.error,
    this.data,
  });
  final ModelPhotosResponse? data;
}

@jsonSerializable
class ModelResponsePhoto extends ResponseData {
  const ModelResponsePhoto({
    super.status = false,
    super.error,
    this.data,
  });
  final ModelPhotoResponse? data;
}

@jsonSerializable
class ModelPhotosResponse {
  const ModelPhotosResponse({
    this.hasGeneratedConversions = false,
    this.photos,
  });
  @JsonProperty(name: 'has_generated_conversions')
  final bool hasGeneratedConversions;

  final List<ModelPhoto>? photos;
}

@jsonSerializable
class ModelPhotoResponse {
  const ModelPhotoResponse({
    this.hasGeneratedConversions = false,
    this.photos,
  });
  @JsonProperty(name: 'has_generated_conversions')
  final bool hasGeneratedConversions;

  final ModelPhoto? photos;
}
