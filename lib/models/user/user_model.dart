import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  List<String> decks;
  String gender;
  List<String> languageSpoken;
  String jobType;
  String homeTown;
  String creationDate;
  String profileUrl;
  String displayName;
  String provider;
  String sId;
  String firstName;
  String lastName;
  String email;
  int iV;

  User(
      {this.decks,
      this.gender,
      this.languageSpoken,
      this.jobType,
      this.homeTown,
      this.creationDate,
      this.profileUrl,
      this.displayName,
      this.provider,
      this.sId,
      this.firstName,
      this.lastName,
      this.email,
      this.iV});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
