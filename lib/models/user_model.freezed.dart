// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get name => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get profileUrl => throw _privateConstructorUsedError;
  String get banner => throw _privateConstructorUsedError;
  bool get isAuth => throw _privateConstructorUsedError; // if guest or no
  int get karma => throw _privateConstructorUsedError;
  List<String> get awards => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String name,
      String uid,
      String profileUrl,
      String banner,
      bool isAuth,
      int karma,
      List<String> awards});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? uid = null,
    Object? profileUrl = null,
    Object? banner = null,
    Object? isAuth = null,
    Object? karma = null,
    Object? awards = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      profileUrl: null == profileUrl
          ? _value.profileUrl
          : profileUrl // ignore: cast_nullable_to_non_nullable
              as String,
      banner: null == banner
          ? _value.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String,
      isAuth: null == isAuth
          ? _value.isAuth
          : isAuth // ignore: cast_nullable_to_non_nullable
              as bool,
      karma: null == karma
          ? _value.karma
          : karma // ignore: cast_nullable_to_non_nullable
              as int,
      awards: null == awards
          ? _value.awards
          : awards // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$$_UserModelCopyWith(
          _$_UserModel value, $Res Function(_$_UserModel) then) =
      __$$_UserModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String uid,
      String profileUrl,
      String banner,
      bool isAuth,
      int karma,
      List<String> awards});
}

/// @nodoc
class __$$_UserModelCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$_UserModel>
    implements _$$_UserModelCopyWith<$Res> {
  __$$_UserModelCopyWithImpl(
      _$_UserModel _value, $Res Function(_$_UserModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? uid = null,
    Object? profileUrl = null,
    Object? banner = null,
    Object? isAuth = null,
    Object? karma = null,
    Object? awards = null,
  }) {
    return _then(_$_UserModel(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      profileUrl: null == profileUrl
          ? _value.profileUrl
          : profileUrl // ignore: cast_nullable_to_non_nullable
              as String,
      banner: null == banner
          ? _value.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String,
      isAuth: null == isAuth
          ? _value.isAuth
          : isAuth // ignore: cast_nullable_to_non_nullable
              as bool,
      karma: null == karma
          ? _value.karma
          : karma // ignore: cast_nullable_to_non_nullable
              as int,
      awards: null == awards
          ? _value._awards
          : awards // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserModel implements _UserModel {
  _$_UserModel(
      {required this.name,
      required this.uid,
      required this.profileUrl,
      required this.banner,
      required this.isAuth,
      required this.karma,
      required final List<String> awards})
      : _awards = awards;

  factory _$_UserModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserModelFromJson(json);

  @override
  final String name;
  @override
  final String uid;
  @override
  final String profileUrl;
  @override
  final String banner;
  @override
  final bool isAuth;
// if guest or no
  @override
  final int karma;
  final List<String> _awards;
  @override
  List<String> get awards {
    if (_awards is EqualUnmodifiableListView) return _awards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_awards);
  }

  @override
  String toString() {
    return 'UserModel(name: $name, uid: $uid, profileUrl: $profileUrl, banner: $banner, isAuth: $isAuth, karma: $karma, awards: $awards)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.profileUrl, profileUrl) ||
                other.profileUrl == profileUrl) &&
            (identical(other.banner, banner) || other.banner == banner) &&
            (identical(other.isAuth, isAuth) || other.isAuth == isAuth) &&
            (identical(other.karma, karma) || other.karma == karma) &&
            const DeepCollectionEquality().equals(other._awards, _awards));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, uid, profileUrl, banner,
      isAuth, karma, const DeepCollectionEquality().hash(_awards));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      __$$_UserModelCopyWithImpl<_$_UserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserModelToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  factory _UserModel(
      {required final String name,
      required final String uid,
      required final String profileUrl,
      required final String banner,
      required final bool isAuth,
      required final int karma,
      required final List<String> awards}) = _$_UserModel;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$_UserModel.fromJson;

  @override
  String get name;
  @override
  String get uid;
  @override
  String get profileUrl;
  @override
  String get banner;
  @override
  bool get isAuth;
  @override // if guest or no
  int get karma;
  @override
  List<String> get awards;
  @override
  @JsonKey(ignore: true)
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
