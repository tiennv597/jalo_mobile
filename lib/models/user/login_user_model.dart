import 'package:json_annotation/json_annotation.dart';
import 'package:shinro_int2/models/user/user_model.dart';

part 'login_user_model.g.dart';

@JsonSerializable()
class LoginUser {
  String msg;
  String token;
  User user;

  LoginUser({this.msg, this.token, this.user});

  factory LoginUser.fromJson(Map<String, dynamic> json)=> _$LoginUserFromJson(json);

  Map<String, dynamic> toJson()=> _$LoginUserToJson(this);
}