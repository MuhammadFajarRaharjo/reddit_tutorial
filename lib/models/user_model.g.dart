// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      name: json['name'] as String,
      uid: json['uid'] as String,
      profileUrl: json['profileUrl'] as String,
      banner: json['banner'] as String,
      isAuth: json['isAuth'] as bool,
      karma: json['karma'] as int,
      awards:
          (json['awards'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'uid': instance.uid,
      'profileUrl': instance.profileUrl,
      'banner': instance.banner,
      'isAuth': instance.isAuth,
      'karma': instance.karma,
      'awards': instance.awards,
    };
