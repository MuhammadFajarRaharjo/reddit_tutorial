import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
class PostModel with _$PostModel {
  factory PostModel({
    required String id,
    required String title,
    String? link,
    String? description,
    required String userName,
    required String uid,
    required String communityName,
    required String communityProfilePic,
    required List<String> upVotes,
    required List<String> downVotes,
    required int commentCount,
    required String type,
    required DateTime createdAt,
    required List<String> awards,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}
