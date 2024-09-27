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
import 'dart:async' as _i2;
import 'package:elanwar_agancy_client/src/protocol/reservation.dart' as _i3;
import 'package:elanwar_agancy_client/src/protocol/user.dart' as _i4;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i5;
import 'protocol.dart' as _i6;

/// {@category Endpoint}
class EndpointExample extends _i1.EndpointRef {
  EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  _i2.Future<String> hello(String name) => caller.callServerEndpoint<String>(
        'example',
        'hello',
        {'name': name},
      );
}

/// {@category Endpoint}
class EndpointReservation extends _i1.EndpointRef {
  EndpointReservation(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'reservation';

  _i2.Future<List<_i3.Reservation?>> getAll() =>
      caller.callServerEndpoint<List<_i3.Reservation?>>(
        'reservation',
        'getAll',
        {},
      );

  _i2.Future<_i3.Reservation?> getByUserId(int userId) =>
      caller.callServerEndpoint<_i3.Reservation?>(
        'reservation',
        'getByUserId',
        {'userId': userId},
      );

  _i2.Future<_i3.Reservation?> getByName(String name) =>
      caller.callServerEndpoint<_i3.Reservation?>(
        'reservation',
        'getByName',
        {'name': name},
      );

  _i2.Future<_i3.Reservation?> getByRoomNumber(int roomNumber) =>
      caller.callServerEndpoint<_i3.Reservation?>(
        'reservation',
        'getByRoomNumber',
        {'roomNumber': roomNumber},
      );

  _i2.Future<_i3.Reservation?> getByTotalPrice(double price) =>
      caller.callServerEndpoint<_i3.Reservation?>(
        'reservation',
        'getByTotalPrice',
        {'price': price},
      );

  _i2.Future<_i3.Reservation?> getMaxPrice() =>
      caller.callServerEndpoint<_i3.Reservation?>(
        'reservation',
        'getMaxPrice',
        {},
      );

  _i2.Future<double?> getTotalPrices() => caller.callServerEndpoint<double?>(
        'reservation',
        'getTotalPrices',
        {},
      );

  _i2.Future<double?> getTotalDebts() => caller.callServerEndpoint<double?>(
        'reservation',
        'getTotalDebts',
        {},
      );

  _i2.Future<Map<int, double>> getTotalPricesPerMonth() =>
      caller.callServerEndpoint<Map<int, double>>(
        'reservation',
        'getTotalPricesPerMonth',
        {},
      );

  _i2.Future<_i3.Reservation?> getIsExpired(bool isExpired) =>
      caller.callServerEndpoint<_i3.Reservation?>(
        'reservation',
        'getIsExpired',
        {'isExpired': isExpired},
      );

  _i2.Future<bool?> create(_i3.Reservation reservation) =>
      caller.callServerEndpoint<bool?>(
        'reservation',
        'create',
        {'reservation': reservation},
      );

  _i2.Future<bool?> update(_i3.Reservation reservation) =>
      caller.callServerEndpoint<bool?>(
        'reservation',
        'update',
        {'reservation': reservation},
      );

  _i2.Future<bool?> delete(int id) => caller.callServerEndpoint<bool?>(
        'reservation',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointUser extends _i1.EndpointRef {
  EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  _i2.Future<_i4.User?> get(int id) => caller.callServerEndpoint<_i4.User?>(
        'user',
        'get',
        {'id': id},
      );

  _i2.Future<_i4.User?> create(dynamic user) =>
      caller.callServerEndpoint<_i4.User?>(
        'user',
        'create',
        {'user': user},
      );
}

class _Modules {
  _Modules(Client client) {
    auth = _i5.Caller(client);
  }

  late final _i5.Caller auth;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i6.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    example = EndpointExample(this);
    reservation = EndpointReservation(this);
    user = EndpointUser(this);
    modules = _Modules(this);
  }

  late final EndpointExample example;

  late final EndpointReservation reservation;

  late final EndpointUser user;

  late final _Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'example': example,
        'reservation': reservation,
        'user': user,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
