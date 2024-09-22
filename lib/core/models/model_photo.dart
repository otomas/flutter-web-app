import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ModelPhoto {

  ModelPhoto({
    this.id,
    this.name,
    this.fileName,
    this.extension,
    this.isCover = false,
    this.originalUrl,
    this.photo1920x1080Url,
    this.photo680x428Url,
    this.thumbnailUrl,
    this.imageNotFound,
  });
  final int? id;
  final String? name;

  @JsonProperty(name: 'file_name')
  final String? fileName;

  final String? extension;

  @JsonProperty(name: 'is_cover')
  bool? isCover;

  @JsonProperty(name: 'original_url')
  final String? originalUrl;

  @JsonProperty(name: 'photo-1920x1080_url')
  final String? photo1920x1080Url;

  @JsonProperty(name: 'photo-680x428_url')
  final String? photo680x428Url;

  @JsonProperty(name: 'thumbnail_url')
  final String? thumbnailUrl;

  @JsonProperty(name: 'image_not_found')
  final String? imageNotFound;

  String? get url => originalUrl;
}
