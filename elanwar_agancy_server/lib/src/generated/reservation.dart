/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'protocol.dart' as _i2;

abstract class Reservation extends _i1.TableRow
    implements _i1.ProtocolSerialization {
  Reservation._({
    int? id,
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
    required this.idCardNumber,
    required this.phoneNumber,
    required this.adress,
  }) : super(id);

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
    required int idCardNumber,
    required String phoneNumber,
    required String adress,
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
      idCardNumber: jsonSerialization['idCardNumber'] as int,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      adress: jsonSerialization['adress'] as String,
    );
  }

  static final t = ReservationTable();

  static const db = ReservationRepository._();

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

  int idCardNumber;

  String phoneNumber;

  String adress;

  @override
  _i1.Table get table => t;

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
    int? idCardNumber,
    String? phoneNumber,
    String? adress,
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
      'idCardNumber': idCardNumber,
      'phoneNumber': phoneNumber,
      'adress': adress,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
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
      'idCardNumber': idCardNumber,
      'phoneNumber': phoneNumber,
      'adress': adress,
    };
  }

  static ReservationInclude include({_i2.UserInclude? user}) {
    return ReservationInclude._(user: user);
  }

  static ReservationIncludeList includeList({
    _i1.WhereExpressionBuilder<ReservationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReservationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReservationTable>? orderByList,
    ReservationInclude? include,
  }) {
    return ReservationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Reservation.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Reservation.t),
      include: include,
    );
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
    required int idCardNumber,
    required String phoneNumber,
    required String adress,
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
          idCardNumber: idCardNumber,
          phoneNumber: phoneNumber,
          adress: adress,
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
    int? idCardNumber,
    String? phoneNumber,
    String? adress,
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
      idCardNumber: idCardNumber ?? this.idCardNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      adress: adress ?? this.adress,
    );
  }
}

class ReservationTable extends _i1.Table {
  ReservationTable({super.tableRelation}) : super(tableName: 'reservation') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    fullName = _i1.ColumnString(
      'fullName',
      this,
    );
    hotel = _i1.ColumnString(
      'hotel',
      this,
    );
    room = _i1.ColumnInt(
      'room',
      this,
    );
    totalPrice = _i1.ColumnDouble(
      'totalPrice',
      this,
    );
    payed = _i1.ColumnDouble(
      'payed',
      this,
    );
    debt = _i1.ColumnDouble(
      'debt',
      this,
    );
    startDate = _i1.ColumnDateTime(
      'startDate',
      this,
    );
    endDate = _i1.ColumnDateTime(
      'endDate',
      this,
    );
    isExpired = _i1.ColumnBool(
      'isExpired',
      this,
    );
    createAt = _i1.ColumnDateTime(
      'createAt',
      this,
    );
    idCardNumber = _i1.ColumnInt(
      'idCardNumber',
      this,
    );
    phoneNumber = _i1.ColumnString(
      'phoneNumber',
      this,
    );
    adress = _i1.ColumnString(
      'adress',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  _i2.UserTable? _user;

  late final _i1.ColumnString fullName;

  late final _i1.ColumnString hotel;

  late final _i1.ColumnInt room;

  late final _i1.ColumnDouble totalPrice;

  late final _i1.ColumnDouble payed;

  late final _i1.ColumnDouble debt;

  late final _i1.ColumnDateTime startDate;

  late final _i1.ColumnDateTime endDate;

  late final _i1.ColumnBool isExpired;

  late final _i1.ColumnDateTime createAt;

  late final _i1.ColumnInt idCardNumber;

  late final _i1.ColumnString phoneNumber;

  late final _i1.ColumnString adress;

  _i2.UserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: Reservation.t.userId,
      foreignField: _i2.User.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.UserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        fullName,
        hotel,
        room,
        totalPrice,
        payed,
        debt,
        startDate,
        endDate,
        isExpired,
        createAt,
        idCardNumber,
        phoneNumber,
        adress,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    return null;
  }
}

class ReservationInclude extends _i1.IncludeObject {
  ReservationInclude._({_i2.UserInclude? user}) {
    _user = user;
  }

  _i2.UserInclude? _user;

  @override
  Map<String, _i1.Include?> get includes => {'user': _user};

  @override
  _i1.Table get table => Reservation.t;
}

class ReservationIncludeList extends _i1.IncludeList {
  ReservationIncludeList._({
    _i1.WhereExpressionBuilder<ReservationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Reservation.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Reservation.t;
}

class ReservationRepository {
  const ReservationRepository._();

  final attachRow = const ReservationAttachRowRepository._();

  Future<List<Reservation>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReservationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReservationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReservationTable>? orderByList,
    _i1.Transaction? transaction,
    ReservationInclude? include,
  }) async {
    return session.db.find<Reservation>(
      where: where?.call(Reservation.t),
      orderBy: orderBy?.call(Reservation.t),
      orderByList: orderByList?.call(Reservation.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<Reservation?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReservationTable>? where,
    int? offset,
    _i1.OrderByBuilder<ReservationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReservationTable>? orderByList,
    _i1.Transaction? transaction,
    ReservationInclude? include,
  }) async {
    return session.db.findFirstRow<Reservation>(
      where: where?.call(Reservation.t),
      orderBy: orderBy?.call(Reservation.t),
      orderByList: orderByList?.call(Reservation.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<Reservation?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ReservationInclude? include,
  }) async {
    return session.db.findById<Reservation>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  Future<List<Reservation>> insert(
    _i1.Session session,
    List<Reservation> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Reservation>(
      rows,
      transaction: transaction,
    );
  }

  Future<Reservation> insertRow(
    _i1.Session session,
    Reservation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Reservation>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Reservation>> update(
    _i1.Session session,
    List<Reservation> rows, {
    _i1.ColumnSelections<ReservationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Reservation>(
      rows,
      columns: columns?.call(Reservation.t),
      transaction: transaction,
    );
  }

  Future<Reservation> updateRow(
    _i1.Session session,
    Reservation row, {
    _i1.ColumnSelections<ReservationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Reservation>(
      row,
      columns: columns?.call(Reservation.t),
      transaction: transaction,
    );
  }

  Future<List<Reservation>> delete(
    _i1.Session session,
    List<Reservation> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Reservation>(
      rows,
      transaction: transaction,
    );
  }

  Future<Reservation> deleteRow(
    _i1.Session session,
    Reservation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Reservation>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Reservation>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ReservationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Reservation>(
      where: where(Reservation.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReservationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Reservation>(
      where: where?.call(Reservation.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ReservationAttachRowRepository {
  const ReservationAttachRowRepository._();

  Future<void> user(
    _i1.Session session,
    Reservation reservation,
    _i2.User user, {
    _i1.Transaction? transaction,
  }) async {
    if (reservation.id == null) {
      throw ArgumentError.notNull('reservation.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $reservation = reservation.copyWith(userId: user.id);
    await session.db.updateRow<Reservation>(
      $reservation,
      columns: [Reservation.t.userId],
      transaction: transaction,
    );
  }
}
