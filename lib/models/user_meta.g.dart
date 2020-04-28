// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMeta _$UserMetaFromJson(Map<String, dynamic> json) {
  return UserMeta(
    token: json['token'] as String,
    tokenType: json['tokenType'] as String,
    expiresIn: json['expiresIn'] as String,
  );
}

Map<String, dynamic> _$UserMetaToJson(UserMeta instance) => <String, dynamic>{
      'token': instance.token,
      'tokenType': instance.tokenType,
      'expiresIn': instance.expiresIn,
    };
