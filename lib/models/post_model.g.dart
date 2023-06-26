// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostModel _$$_PostModelFromJson(Map<String, dynamic> json) => _$_PostModel(
      id: json['id'] as String,
      title: json['title'] as String,
      link: json['link'] as String?,
      description: json['description'] as String?,
      userName: json['userName'] as String,
      uid: json['uid'] as String,
      communityName: json['communityName'] as String,
      communityProfilePic: json['communityProfilePic'] as String,
      upVotes:
          (json['upVotes'] as List<dynamic>).map((e) => e as String).toList(),
      downVotes:
          (json['downVotes'] as List<dynamic>).map((e) => e as String).toList(),
      commentCount: json['commentCount'] as int,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      awards:
          (json['awards'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_PostModelToJson(_$_PostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'link': instance.link,
      'description': instance.description,
      'userName': instance.userName,
      'uid': instance.uid,
      'communityName': instance.communityName,
      'communityProfilePic': instance.communityProfilePic,
      'upVotes': instance.upVotes,
      'downVotes': instance.downVotes,
      'commentCount': instance.commentCount,
      'type': instance.type,
      'createdAt': instance.createdAt.toIso8601String(),
      'awards': instance.awards,
    };
