/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i2;

abstract class User implements _i1.SerializableModel {
  User._({
    this.id,
    required this.userInfoId,
    this.userInfo,
    this.fullName,
    this.role,
    this.contactInfo,
    this.adress,
    this.createdAt,
  });

  factory User({
    int? id,
    required int userInfoId,
    _i2.UserInfo? userInfo,
    String? fullName,
    String? role,
    String? contactInfo,
    String? adress,
    String? createdAt,
  }) = _UserImpl;

  factory User.fromJson(Map<String, dynamic> jsonSerialization) {
    return User(
      id: jsonSerialization['id'] as int?,
      userInfoId: jsonSerialization['userInfoId'] as int,
      userInfo: jsonSerialization['userInfo'] == null
          ? null
          : _i2.UserInfo.fromJson(
              (jsonSerialization['userInfo'] as Map<String, dynamic>)),
      fullName: jsonSerialization['fullName'] as String?,
      role: jsonSerialization['role'] as String?,
      contactInfo: jsonSerialization['contactInfo'] as String?,
      adress: jsonSerialization['adress'] as String?,
      createdAt: jsonSerialization['createdAt'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userInfoId;

  _i2.UserInfo? userInfo;

  String? fullName;

  String? role;

  String? contactInfo;

  String? adress;

  String? createdAt;

  User copyWith({
    int? id,
    int? userInfoId,
    _i2.UserInfo? userInfo,
    String? fullName,
    String? role,
    String? contactInfo,
    String? adress,
    String? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userInfoId': userInfoId,
      if (userInfo != null) 'userInfo': userInfo?.toJson(),
      if (fullName != null) 'fullName': fullName,
      if (role != null) 'role': role,
      if (contactInfo != null) 'contactInfo': contactInfo,
      if (adress != null) 'adress': adress,
      if (createdAt != null) 'createdAt': createdAt,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserImpl extends User {
  _UserImpl({
    int? id,
    required int userInfoId,
    _i2.UserInfo? userInfo,
    String? fullName,
    String? role,
    String? contactInfo,
    String? adress,
    String? createdAt,
  }) : super._(
          id: id,
          userInfoId: userInfoId,
          userInfo: userInfo,
          fullName: fullName,
          role: role,
          contactInfo: contactInfo,
          adress: adress,
          createdAt: createdAt,
        );

  @override
  User copyWith({
    Object? id = _Undefined,
    int? userInfoId,
    Object? userInfo = _Undefined,
    Object? fullName = _Undefined,
    Object? role = _Undefined,
    Object? contactInfo = _Undefined,
    Object? adress = _Undefined,
    Object? createdAt = _Undefined,
  }) {
    return User(
      id: id is int? ? id : this.id,
      userInfoId: userInfoId ?? this.userInfoId,
      userInfo:
          userInfo is _i2.UserInfo? ? userInfo : this.userInfo?.copyWith(),
      fullName: fullName is String? ? fullName : this.fullName,
      role: role is String? ? role : this.role,
      contactInfo: contactInfo is String? ? contactInfo : this.contactInfo,
      adress: adress is String? ? adress : this.adress,
      createdAt: createdAt is String? ? createdAt : this.createdAt,
    );
  }
}
