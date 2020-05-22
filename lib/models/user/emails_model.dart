import 'package:json_annotation/json_annotation.dart';
part 'emails_model.g.dart';

@JsonSerializable()
class Emails {
  String value;
  String type;

  Emails({this.value, this.type});

  factory Emails.fromJson(Map<String, dynamic> json) => _$EmailsFromJson(json);

  Map<String, dynamic> toJson() => _$EmailsToJson(this);

}
