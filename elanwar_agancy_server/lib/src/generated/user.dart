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
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i2;

abstract class User extends _i1.TableRow implements _i1.ProtocolSerialization {
  User._({
    int? id,
    required this.userInfoId,
    this.userInfo,
    this.fullName,
    this.role,
    this.contactInfo,
    this.adress,
    this.createdAt,
  }) : super(id);

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

  static final t = UserTable();

  static const db = UserRepository._();

  int userInfoId;

  _i2.UserInfo? userInfo;

  String? fullName;

  String? role;

  String? contactInfo;

  String? adress;

  String? createdAt;

  @override
  _i1.Table get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userInfoId': userInfoId,
      if (userInfo != null) 'userInfo': userInfo?.toJsonForProtocol(),
      if (fullName != null) 'fullName': fullName,
      if (role != null) 'role': role,
      if (contactInfo != null) 'contactInfo': contactInfo,
      if (adress != null) 'adress': adress,
      if (createdAt != null) 'createdAt': createdAt,
    };
  }

  static UserInclude include({_i2.UserInfoInclude? userInfo}) {
    return UserInclude._(userInfo: userInfo);
  }

  static UserIncludeList includeList({
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    UserInclude? include,
  }) {
    return UserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(User.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(User.t),
      include: include,
    );
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

class UserTable extends _i1.Table {
  UserTable({super.tableRelation}) : super(tableName: 'user') {
    userInfoId = _i1.ColumnInt(
      'userInfoId',
      this,
    );
    fullName = _i1.ColumnString(
      'fullName',
      this,
    );
    role = _i1.ColumnString(
      'role',
      this,
    );
    contactInfo = _i1.ColumnString(
      'contactInfo',
      this,
    );
    adress = _i1.ColumnString(
      'adress',
      this,
    );
    createdAt = _i1.ColumnString(
      'createdAt',
      this,
    );
  }

  late final _i1.ColumnInt userInfoId;

  _i2.UserInfoTable? _userInfo;

  late final _i1.ColumnString fullName;

  late final _i1.ColumnString role;

  late final _i1.ColumnString contactInfo;

  late final _i1.ColumnString adress;

  late final _i1.ColumnString createdAt;

  _i2.UserInfoTable get userInfo {
    if (_userInfo != null) return _userInfo!;
    _userInfo = _i1.createRelationTable(
      relationFieldName: 'userInfo',
      field: User.t.userInfoId,
      foreignField: _i2.UserInfo.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.UserInfoTable(tableRelation: foreignTableRelation),
    );
    return _userInfo!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        userInfoId,
        fullName,
        role,
        contactInfo,
        adress,
        createdAt,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'userInfo') {
      return userInfo;
    }
    return null;
  }
}

class UserInclude extends _i1.IncludeObject {
  UserInclude._({_i2.UserInfoInclude? userInfo}) {
    _userInfo = userInfo;
  }

  _i2.UserInfoInclude? _userInfo;

  @override
  Map<String, _i1.Include?> get includes => {'userInfo': _userInfo};

  @override
  _i1.Table get table => User.t;
}

class UserIncludeList extends _i1.IncludeList {
  UserIncludeList._({
    _i1.WhereExpressionBuilder<UserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(User.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => User.t;
}

class UserRepository {
  const UserRepository._();

  final attachRow = const UserAttachRowRepository._();

  Future<List<User>> find(
    _i1.DatabaseAccessor databaseAccessor, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    _i1.Transaction? transaction,
    UserInclude? include,
  }) async {
    return databaseAccessor.db.find<User>(
      where: where?.call(User.t),
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction ?? databaseAccessor.transaction,
      include: include,
    );
  }

  Future<User?> findFirstRow(
    _i1.DatabaseAccessor databaseAccessor, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    _i1.Transaction? transaction,
    UserInclude? include,
  }) async {
    return databaseAccessor.db.findFirstRow<User>(
      where: where?.call(User.t),
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction ?? databaseAccessor.transaction,
      include: include,
    );
  }

  Future<User?> findById(
    _i1.DatabaseAccessor databaseAccessor,
    int id, {
    _i1.Transaction? transaction,
    UserInclude? include,
  }) async {
    return databaseAccessor.db.findById<User>(
      id,
      transaction: transaction ?? databaseAccessor.transaction,
      include: include,
    );
  }

  Future<List<User>> insert(
    _i1.DatabaseAccessor databaseAccessor,
    List<User> rows, {
    _i1.Transaction? transaction,
  }) async {
    return databaseAccessor.db.insert<User>(
      rows,
      transaction: transaction ?? databaseAccessor.transaction,
    );
  }

  Future<User> insertRow(
    _i1.DatabaseAccessor databaseAccessor,
    User row, {
    _i1.Transaction? transaction,
  }) async {
    return databaseAccessor.db.insertRow<User>(
      row,
      transaction: transaction ?? databaseAccessor.transaction,
    );
  }

  Future<List<User>> update(
    _i1.DatabaseAccessor databaseAccessor,
    List<User> rows, {
    _i1.ColumnSelections<UserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return databaseAccessor.db.update<User>(
      rows,
      columns: columns?.call(User.t),
      transaction: transaction ?? databaseAccessor.transaction,
    );
  }

  Future<User> updateRow(
    _i1.DatabaseAccessor databaseAccessor,
    User row, {
    _i1.ColumnSelections<UserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return databaseAccessor.db.updateRow<User>(
      row,
      columns: columns?.call(User.t),
      transaction: transaction ?? databaseAccessor.transaction,
    );
  }

  Future<List<User>> delete(
    _i1.DatabaseAccessor databaseAccessor,
    List<User> rows, {
    _i1.Transaction? transaction,
  }) async {
    return databaseAccessor.db.delete<User>(
      rows,
      transaction: transaction ?? databaseAccessor.transaction,
    );
  }

  Future<User> deleteRow(
    _i1.DatabaseAccessor databaseAccessor,
    User row, {
    _i1.Transaction? transaction,
  }) async {
    return databaseAccessor.db.deleteRow<User>(
      row,
      transaction: transaction ?? databaseAccessor.transaction,
    );
  }

  Future<List<User>> deleteWhere(
    _i1.DatabaseAccessor databaseAccessor, {
    required _i1.WhereExpressionBuilder<UserTable> where,
    _i1.Transaction? transaction,
  }) async {
    return databaseAccessor.db.deleteWhere<User>(
      where: where(User.t),
      transaction: transaction ?? databaseAccessor.transaction,
    );
  }

  Future<int> count(
    _i1.DatabaseAccessor databaseAccessor, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return databaseAccessor.db.count<User>(
      where: where?.call(User.t),
      limit: limit,
      transaction: transaction ?? databaseAccessor.transaction,
    );
  }
}

class UserAttachRowRepository {
  const UserAttachRowRepository._();

  Future<void> userInfo(
    _i1.DatabaseAccessor databaseAccessor,
    User user,
    _i2.UserInfo userInfo, {
    _i1.Transaction? transaction,
  }) async {
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }
    if (userInfo.id == null) {
      throw ArgumentError.notNull('userInfo.id');
    }

    var $user = user.copyWith(userInfoId: userInfo.id);
    await databaseAccessor.db.updateRow<User>(
      $user,
      columns: [User.t.userInfoId],
      transaction: transaction ?? databaseAccessor.transaction,
    );
  }
}
