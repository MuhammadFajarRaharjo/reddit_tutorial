// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CommunityModel _$CommunityModelFromJson(Map<String, dynamic> json) {
  return _CommunityModel.fromJson(json);
}

/// @nodoc
mixin _$CommunityModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get avatar => throw _privateConstructorUsedError;
  String get banner => throw _privateConstructorUsedError;
  List<String> get members => throw _privateConstructorUsedError;
  List<String> get mods => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommunityModelCopyWith<CommunityModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunityModelCopyWith<$Res> {
  factory $CommunityModelCopyWith(
          CommunityModel value, $Res Function(CommunityModel) then) =
      _$CommunityModelCopyWithImpl<$Res, CommunityModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String avatar,
      String banner,
      List<String> members,
      List<String> mods});
}

/// @nodoc
class _$CommunityModelCopyWithImpl<$Res, $Val extends CommunityModel>
    implements $CommunityModelCopyWith<$Res> {
  _$CommunityModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatar = null,
    Object? banner = null,
    Object? members = null,
    Object? mods = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      banner: null == banner
          ? _value.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String,
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<String>,
      mods: null == mods
          ? _value.mods
          : mods // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CommunityModelCopyWith<$Res>
    implements $CommunityModelCopyWith<$Res> {
  factory _$$_CommunityModelCopyWith(
          _$_CommunityModel value, $Res Function(_$_CommunityModel) then) =
      __$$_CommunityModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String avatar,
      String banner,
      List<String> members,
      List<String> mods});
}

/// @nodoc
class __$$_CommunityModelCopyWithImpl<$Res>
    extends _$CommunityModelCopyWithImpl<$Res, _$_CommunityModel>
    implements _$$_CommunityModelCopyWith<$Res> {
  __$$_CommunityModelCopyWithImpl(
      _$_CommunityModel _value, $Res Function(_$_CommunityModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatar = null,
    Object? banner = null,
    Object? members = null,
    Object? mods = null,
  }) {
    return _then(_$_CommunityModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      banner: null == banner
          ? _value.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<String>,
      mods: null == mods
          ? _value._mods
          : mods // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CommunityModel implements _CommunityModel {
  _$_CommunityModel(
      {required this.id,
      required this.name,
      required this.avatar,
      required this.banner,
      required final List<String> members,
      required final List<String> mods})
      : _members = members,
        _mods = mods;

  factory _$_CommunityModel.fromJson(Map<String, dynamic> json) =>
      _$$_CommunityModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String avatar;
  @override
  final String banner;
  final List<String> _members;
  @override
  List<String> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  final List<String> _mods;
  @override
  List<String> get mods {
    if (_mods is EqualUnmodifiableListView) return _mods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mods);
  }

  @override
  String toString() {
    return 'CommunityModel(id: $id, name: $name, avatar: $avatar, banner: $banner, members: $members, mods: $mods)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CommunityModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.banner, banner) || other.banner == banner) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            const DeepCollectionEquality().equals(other._mods, _mods));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      avatar,
      banner,
      const DeepCollectionEquality().hash(_members),
      const DeepCollectionEquality().hash(_mods));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CommunityModelCopyWith<_$_CommunityModel> get copyWith =>
      __$$_CommunityModelCopyWithImpl<_$_CommunityModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CommunityModelToJson(
      this,
    );
  }
}

abstract class _CommunityModel implements CommunityModel {
  factory _CommunityModel(
      {required final String id,
      required final String name,
      required final String avatar,
      required final String banner,
      required final List<String> members,
      required final List<String> mods}) = _$_CommunityModel;

  factory _CommunityModel.fromJson(Map<String, dynamic> json) =
      _$_CommunityModel.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get avatar;
  @override
  String get banner;
  @override
  List<String> get members;
  @override
  List<String> get mods;
  @override
  @JsonKey(ignore: true)
  _$$_CommunityModelCopyWith<_$_CommunityModel> get copyWith =>
      throw _privateConstructorUsedError;
}
