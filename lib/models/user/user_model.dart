import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  bool success;
  String provider;
  String id;
  bool enable;
  String username;
  String displayName;
  String creationDate;
  String gender;
  String profileUrl;

  User(
      {this.success,
      this.provider,
      this.id,
      this.enable,
      this.username,
      this.displayName,
      this.creationDate,
      this.gender,
      this.profileUrl});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
