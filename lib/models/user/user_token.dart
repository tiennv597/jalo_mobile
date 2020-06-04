import 'package:json_annotation/json_annotation.dart';
part 'user_token.g.dart';

@JsonSerializable()
class UserToken {
  bool success;
  String token;

  UserToken({this.success, this.token});

  factory UserToken.fromJson(Map<String, dynamic> json) =>
      _$UserTokenFromJson(json);

  Map<String, dynamic> toJson() => _$UserTokenToJson(this);
}
