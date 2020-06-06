// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    success: json['success'] as bool,
    provider: json['provider'] as String,
    id: json['id'] as String,
    enable: json['enable'] as bool,
    username: json['username'] as String,
    displayName: json['displayName'] as String,
    creationDate: json['creationDate'] as String,
    gender: json['gender'] as String,
    profileUrl: json['profileUrl'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'success': instance.success,
      'provider': instance.provider,
      'id': instance.id,
      'enable': instance.enable,
      'username': instance.username,
      'displayName': instance.displayName,
      'creationDate': instance.creationDate,
      'gender': instance.gender,
      'profileUrl': instance.profileUrl,
    };
