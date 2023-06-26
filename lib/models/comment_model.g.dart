// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CommentModel _$$_CommentModelFromJson(Map<String, dynamic> json) =>
    _$_CommentModel(
      id: json['id'] as String,
      text: json['text'] as String,
      postId: json['postId'] as String,
      username: json['username'] as String,
      profilePic: json['profilePic'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_CommentModelToJson(_$_CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'postId': instance.postId,
      'username': instance.username,
      'profilePic': instance.profilePic,
      'createdAt': instance.createdAt.toIso8601String(),
    };
