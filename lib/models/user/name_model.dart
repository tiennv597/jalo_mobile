import 'package:json_annotation/json_annotation.dart';

part 'name_model.g.dart';

@JsonSerializable()
class Name {
  String familyName;
  String middleName;
  String givenName;

  Name({this.familyName, this.middleName, this.givenName});

 factory Name.fromJson(Map<String, dynamic> json) =>_$NameFromJson(json);

  Map<String, dynamic> toJson() => _$NameToJson(this);
}
