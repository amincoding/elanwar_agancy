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
import 'protocol.dart' as _i2;

abstract class Reservation implements _i1.SerializableModel {
  Reservation._({
    this.id,
    required this.userId,
    this.user,
    required this.fullName,
    required this.hotel,
    required this.room,
    required this.totalPrice,
    this.payed,
    this.debt,
    required this.startDate,
    required this.endDate,
    required this.isExpired,
    required this.createAt,
  });

  factory Reservation({
    int? id,
    required int userId,
    _i2.User? user,
    required String fullName,
    required String hotel,
    required int room,
    required double totalPrice,
    double? payed,
    double? debt,
    required DateTime startDate,
    required DateTime endDate,
    required bool isExpired,
    required DateTime createAt,
  }) = _ReservationImpl;

  factory Reservation.fromJson(Map<String, dynamic> jsonSerialization) {
    return Reservation(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i2.User.fromJson(
              (jsonSerialization['user'] as Map<String, dynamic>)),
      fullName: jsonSerialization['fullName'] as String,
      hotel: jsonSerialization['hotel'] as String,
      room: jsonSerialization['room'] as int,
      totalPrice: (jsonSerialization['totalPrice'] as num).toDouble(),
      payed: (jsonSerialization['payed'] as num?)?.toDouble(),
      debt: (jsonSerialization['debt'] as num?)?.toDouble(),
      startDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startDate']),
      endDate: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
      isExpired: jsonSerialization['isExpired'] as bool,
      createAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  _i2.User? user;

  String fullName;

  String hotel;

  int room;

  double totalPrice;

  double? payed;

  double? debt;

  DateTime startDate;

  DateTime endDate;

  bool isExpired;

  DateTime createAt;

  Reservation copyWith({
    int? id,
    int? userId,
    _i2.User? user,
    String? fullName,
    String? hotel,
    int? room,
    double? totalPrice,
    double? payed,
    double? debt,
    DateTime? startDate,
    DateTime? endDate,
    bool? isExpired,
    DateTime? createAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'fullName': fullName,
      'hotel': hotel,
      'room': room,
      'totalPrice': totalPrice,
      if (payed != null) 'payed': payed,
      if (debt != null) 'debt': debt,
      'startDate': startDate.toJson(),
      'endDate': endDate.toJson(),
      'isExpired': isExpired,
      'createAt': createAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReservationImpl extends Reservation {
  _ReservationImpl({
    int? id,
    required int userId,
    _i2.User? user,
    required String fullName,
    required String hotel,
    required int room,
    required double totalPrice,
    double? payed,
    double? debt,
    required DateTime startDate,
    required DateTime endDate,
    required bool isExpired,
    required DateTime createAt,
  }) : super._(
          id: id,
          userId: userId,
          user: user,
          fullName: fullName,
          hotel: hotel,
          room: room,
          totalPrice: totalPrice,
          payed: payed,
          debt: debt,
          startDate: startDate,
          endDate: endDate,
          isExpired: isExpired,
          createAt: createAt,
        );

  @override
  Reservation copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    String? fullName,
    String? hotel,
    int? room,
    double? totalPrice,
    Object? payed = _Undefined,
    Object? debt = _Undefined,
    DateTime? startDate,
    DateTime? endDate,
    bool? isExpired,
    DateTime? createAt,
  }) {
    return Reservation(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.User? ? user : this.user?.copyWith(),
      fullName: fullName ?? this.fullName,
      hotel: hotel ?? this.hotel,
      room: room ?? this.room,
      totalPrice: totalPrice ?? this.totalPrice,
      payed: payed is double? ? payed : this.payed,
      debt: debt is double? ? debt : this.debt,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isExpired: isExpired ?? this.isExpired,
      createAt: createAt ?? this.createAt,
    );
  }
}
