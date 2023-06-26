// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PostModel _$PostModelFromJson(Map<String, dynamic> json) {
  return _PostModel.fromJson(json);
}

/// @nodoc
mixin _$PostModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get link => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get communityName => throw _privateConstructorUsedError;
  String get communityProfilePic => throw _privateConstructorUsedError;
  List<String> get upVotes => throw _privateConstructorUsedError;
  List<String> get downVotes => throw _privateConstructorUsedError;
  int get commentCount => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<String> get awards => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostModelCopyWith<PostModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostModelCopyWith<$Res> {
  factory $PostModelCopyWith(PostModel value, $Res Function(PostModel) then) =
      _$PostModelCopyWithImpl<$Res, PostModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? link,
      String? description,
      String userName,
      String uid,
      String communityName,
      String communityProfilePic,
      List<String> upVotes,
      List<String> downVotes,
      int commentCount,
      String type,
      DateTime createdAt,
      List<String> awards});
}

/// @nodoc
class _$PostModelCopyWithImpl<$Res, $Val extends PostModel>
    implements $PostModelCopyWith<$Res> {
  _$PostModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? link = freezed,
    Object? description = freezed,
    Object? userName = null,
    Object? uid = null,
    Object? communityName = null,
    Object? communityProfilePic = null,
    Object? upVotes = null,
    Object? downVotes = null,
    Object? commentCount = null,
    Object? type = null,
    Object? createdAt = null,
    Object? awards = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      communityName: null == communityName
          ? _value.communityName
          : communityName // ignore: cast_nullable_to_non_nullable
              as String,
      communityProfilePic: null == communityProfilePic
          ? _value.communityProfilePic
          : communityProfilePic // ignore: cast_nullable_to_non_nullable
              as String,
      upVotes: null == upVotes
          ? _value.upVotes
          : upVotes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      downVotes: null == downVotes
          ? _value.downVotes
          : downVotes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      commentCount: null == commentCount
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      awards: null == awards
          ? _value.awards
          : awards // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PostModelCopyWith<$Res> implements $PostModelCopyWith<$Res> {
  factory _$$_PostModelCopyWith(
          _$_PostModel value, $Res Function(_$_PostModel) then) =
      __$$_PostModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? link,
      String? description,
      String userName,
      String uid,
      String communityName,
      String communityProfilePic,
      List<String> upVotes,
      List<String> downVotes,
      int commentCount,
      String type,
      DateTime createdAt,
      List<String> awards});
}

/// @nodoc
class __$$_PostModelCopyWithImpl<$Res>
    extends _$PostModelCopyWithImpl<$Res, _$_PostModel>
    implements _$$_PostModelCopyWith<$Res> {
  __$$_PostModelCopyWithImpl(
      _$_PostModel _value, $Res Function(_$_PostModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? link = freezed,
    Object? description = freezed,
    Object? userName = null,
    Object? uid = null,
    Object? communityName = null,
    Object? communityProfilePic = null,
    Object? upVotes = null,
    Object? downVotes = null,
    Object? commentCount = null,
    Object? type = null,
    Object? createdAt = null,
    Object? awards = null,
  }) {
    return _then(_$_PostModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      communityName: null == communityName
          ? _value.communityName
          : communityName // ignore: cast_nullable_to_non_nullable
              as String,
      communityProfilePic: null == communityProfilePic
          ? _value.communityProfilePic
          : communityProfilePic // ignore: cast_nullable_to_non_nullable
              as String,
      upVotes: null == upVotes
          ? _value._upVotes
          : upVotes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      downVotes: null == downVotes
          ? _value._downVotes
          : downVotes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      commentCount: null == commentCount
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      awards: null == awards
          ? _value._awards
          : awards // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PostModel implements _PostModel {
  _$_PostModel(
      {required this.id,
      required this.title,
      this.link,
      this.description,
      required this.userName,
      required this.uid,
      required this.communityName,
      required this.communityProfilePic,
      required final List<String> upVotes,
      required final List<String> downVotes,
      required this.commentCount,
      required this.type,
      required this.createdAt,
      required final List<String> awards})
      : _upVotes = upVotes,
        _downVotes = downVotes,
        _awards = awards;

  factory _$_PostModel.fromJson(Map<String, dynamic> json) =>
      _$$_PostModelFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? link;
  @override
  final String? description;
  @override
  final String userName;
  @override
  final String uid;
  @override
  final String communityName;
  @override
  final String communityProfilePic;
  final List<String> _upVotes;
  @override
  List<String> get upVotes {
    if (_upVotes is EqualUnmodifiableListView) return _upVotes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_upVotes);
  }

  final List<String> _downVotes;
  @override
  List<String> get downVotes {
    if (_downVotes is EqualUnmodifiableListView) return _downVotes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_downVotes);
  }

  @override
  final int commentCount;
  @override
  final String type;
  @override
  final DateTime createdAt;
  final List<String> _awards;
  @override
  List<String> get awards {
    if (_awards is EqualUnmodifiableListView) return _awards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_awards);
  }

  @override
  String toString() {
    return 'PostModel(id: $id, title: $title, link: $link, description: $description, userName: $userName, uid: $uid, communityName: $communityName, communityProfilePic: $communityProfilePic, upVotes: $upVotes, downVotes: $downVotes, commentCount: $commentCount, type: $type, createdAt: $createdAt, awards: $awards)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PostModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.communityName, communityName) ||
                other.communityName == communityName) &&
            (identical(other.communityProfilePic, communityProfilePic) ||
                other.communityProfilePic == communityProfilePic) &&
            const DeepCollectionEquality().equals(other._upVotes, _upVotes) &&
            const DeepCollectionEquality()
                .equals(other._downVotes, _downVotes) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._awards, _awards));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      link,
      description,
      userName,
      uid,
      communityName,
      communityProfilePic,
      const DeepCollectionEquality().hash(_upVotes),
      const DeepCollectionEquality().hash(_downVotes),
      commentCount,
      type,
      createdAt,
      const DeepCollectionEquality().hash(_awards));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PostModelCopyWith<_$_PostModel> get copyWith =>
      __$$_PostModelCopyWithImpl<_$_PostModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PostModelToJson(
      this,
    );
  }
}

abstract class _PostModel implements PostModel {
  factory _PostModel(
      {required final String id,
      required final String title,
      final String? link,
      final String? description,
      required final String userName,
      required final String uid,
      required final String communityName,
      required final String communityProfilePic,
      required final List<String> upVotes,
      required final List<String> downVotes,
      required final int commentCount,
      required final String type,
      required final DateTime createdAt,
      required final List<String> awards}) = _$_PostModel;

  factory _PostModel.fromJson(Map<String, dynamic> json) =
      _$_PostModel.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get link;
  @override
  String? get description;
  @override
  String get userName;
  @override
  String get uid;
  @override
  String get communityName;
  @override
  String get communityProfilePic;
  @override
  List<String> get upVotes;
  @override
  List<String> get downVotes;
  @override
  int get commentCount;
  @override
  String get type;
  @override
  DateTime get createdAt;
  @override
  List<String> get awards;
  @override
  @JsonKey(ignore: true)
  _$$_PostModelCopyWith<_$_PostModel> get copyWith =>
      throw _privateConstructorUsedError;
}
