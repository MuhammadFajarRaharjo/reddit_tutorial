// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CommunityModel _$$_CommunityModelFromJson(Map<String, dynamic> json) =>
    _$_CommunityModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      banner: json['banner'] as String,
      members:
          (json['members'] as List<dynamic>).map((e) => e as String).toList(),
      mods: (json['mods'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_CommunityModelToJson(_$_CommunityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'banner': instance.banner,
      'members': instance.members,
      'mods': instance.mods,
    };
