// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    decks: (json['decks'] as List)?.map((e) => e as String)?.toList(),
    gender: json['gender'] as String,
    languageSpoken:
        (json['languageSpoken'] as List)?.map((e) => e as String)?.toList(),
    jobType: json['jobType'] as String,
    homeTown: json['homeTown'] as String,
    creationDate: json['creationDate'] as String,
    profileUrl: json['profileUrl'] as String,
    displayName: json['displayName'] as String,
    provider: json['provider'] as String,
    sId: json['_id'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    email: json['email'] as String,
    iV: json['__v'] as int,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'decks': instance.decks,
      'gender': instance.gender,
      'languageSpoken': instance.languageSpoken,
      'jobType': instance.jobType,
      'homeTown': instance.homeTown,
      'creationDate': instance.creationDate,
      'profileUrl': instance.profileUrl,
      'displayName': instance.displayName,
      'provider': instance.provider,
      '_id': instance.sId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      '__v': instance.iV,
    };
