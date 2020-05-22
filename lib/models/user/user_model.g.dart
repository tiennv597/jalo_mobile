// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    sId: json['_id'] as String,
    provider: json['provider'] as String,
    id: json['id'] as String,
    enable: json['enable'] as bool,
    activationRequired: json['activationRequired'] as bool,
    activationHash: json['activationHash'] as String,
    activationStart: json['activationStart'] as String,
    recoverHash: json['recoverHash'] as String,
    recoverStart: json['recoverStart'] as String,
    username: json['username'] as String,
    password: json['password'] as String,
    displayName: json['displayName'] as String,
    name: json['name'] == null
        ? null
        : Name.fromJson(json['name'] as Map<String, dynamic>),
    emails: (json['emails'] as List)
        ?.map((e) =>
            e == null ? null : Emails.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    photos: (json['photos'] as List)
        ?.map((e) =>
            e == null ? null : Photos.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    creationDate: json['creationDate'] as String,
    gender: json['gender'] as String,
    profileUrl: json['profileUrl'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.sId,
      'provider': instance.provider,
      'id': instance.id,
      'enable': instance.enable,
      'activationRequired': instance.activationRequired,
      'activationHash': instance.activationHash,
      'activationStart': instance.activationStart,
      'recoverHash': instance.recoverHash,
      'recoverStart': instance.recoverStart,
      'username': instance.username,
      'password': instance.password,
      'displayName': instance.displayName,
      'name': instance.name,
      'emails': instance.emails,
      'photos': instance.photos,
      'creationDate': instance.creationDate,
      'gender': instance.gender,
      'profileUrl': instance.profileUrl,
    };
