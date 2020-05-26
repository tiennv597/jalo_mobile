// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    json['name'] as String,
    json['message'] as String,
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'name': instance.name,
      'message': instance.message,
    };
