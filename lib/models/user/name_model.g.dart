// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'name_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Name _$NameFromJson(Map<String, dynamic> json) {
  return Name(
    familyName: json['familyName'] as String,
    middleName: json['middleName'] as String,
    givenName: json['givenName'] as String,
  );
}

Map<String, dynamic> _$NameToJson(Name instance) => <String, dynamic>{
      'familyName': instance.familyName,
      'middleName': instance.middleName,
      'givenName': instance.givenName,
    };
