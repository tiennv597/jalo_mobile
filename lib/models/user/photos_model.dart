import 'package:json_annotation/json_annotation.dart';
part 'photos_model.g.dart';

@JsonSerializable()

class Photos {
  String large;
  String medium;
  String thumbnail;

  Photos({this.large, this.medium, this.thumbnail});

  factory Photos.fromJson(Map<String, dynamic> json) => _$PhotosFromJson(json);

  Map<String, dynamic> toJson()=>  _$PhotosToJson(this);
}