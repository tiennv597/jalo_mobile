import 'package:json_annotation/json_annotation.dart';
import 'package:shinro_int2/models/user/emails_model.dart';
import 'package:shinro_int2/models/user/photos_model.dart';

import 'name_model.dart';
part 'user_model.g.dart';

@JsonSerializable()
class User {
  String sId;
  String provider;
  String id;
  bool enable;
  bool activationRequired;
  String activationHash;
  String activationStart;
  String recoverHash;
  String recoverStart;
  String username;
  String password;
  String displayName;
  Name name;
  List<Emails> emails;
  List<Photos> photos;
  String creationDate;
  String gender;
  String profileUrl;

  User(
      {this.sId,
      this.provider,
      this.id,
      this.enable,
      this.activationRequired,
      this.activationHash,
      this.activationStart,
      this.recoverHash,
      this.recoverStart,
      this.username,
      this.password,
      this.displayName,
      this.name,
      this.emails,
      this.photos,
      this.creationDate,
      this.gender,
      this.profileUrl});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
