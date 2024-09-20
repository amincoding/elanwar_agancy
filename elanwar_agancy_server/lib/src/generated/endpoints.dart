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
import '../endpoints/example_endpoint.dart' as _i2;
import '../endpoints/reservation_endpoint.dart' as _i3;
import '../endpoints/user_endpoint.dart' as _i4;
import 'package:elanwar_agancy_server/src/generated/reservation.dart' as _i5;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i6;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'example': _i2.ExampleEndpoint()
        ..initialize(
          server,
          'example',
          null,
        ),
      'reservation': _i3.ReservationEndpoint()
        ..initialize(
          server,
          'reservation',
          null,
        ),
      'user': _i4.UserEndpoint()
        ..initialize(
          server,
          'user',
          null,
        ),
    };
    connectors['example'] = _i1.EndpointConnector(
      name: 'example',
      endpoint: endpoints['example']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['example'] as _i2.ExampleEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
    connectors['reservation'] = _i1.EndpointConnector(
      name: 'reservation',
      endpoint: endpoints['reservation']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['reservation'] as _i3.ReservationEndpoint)
                  .getAll(session),
        ),
        'getByUserId': _i1.MethodConnector(
          name: 'getByUserId',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['reservation'] as _i3.ReservationEndpoint).getByUserId(
            session,
            params['userId'],
          ),
        ),
        'getByName': _i1.MethodConnector(
          name: 'getByName',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['reservation'] as _i3.ReservationEndpoint).getByName(
            session,
            params['name'],
          ),
        ),
        'getByRoomNumber': _i1.MethodConnector(
          name: 'getByRoomNumber',
          params: {
            'roomNumber': _i1.ParameterDescription(
              name: 'roomNumber',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['reservation'] as _i3.ReservationEndpoint)
                  .getByRoomNumber(
            session,
            params['roomNumber'],
          ),
        ),
        'getByTotalPrice': _i1.MethodConnector(
          name: 'getByTotalPrice',
          params: {
            'price': _i1.ParameterDescription(
              name: 'price',
              type: _i1.getType<double>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['reservation'] as _i3.ReservationEndpoint)
                  .getByTotalPrice(
            session,
            params['price'],
          ),
        ),
        'getMaxPrice': _i1.MethodConnector(
          name: 'getMaxPrice',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['reservation'] as _i3.ReservationEndpoint)
                  .getMaxPrice(session),
        ),
        'getIsExpired': _i1.MethodConnector(
          name: 'getIsExpired',
          params: {
            'isExpired': _i1.ParameterDescription(
              name: 'isExpired',
              type: _i1.getType<bool>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['reservation'] as _i3.ReservationEndpoint)
                  .getIsExpired(
            session,
            params['isExpired'],
          ),
        ),
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'reservation': _i1.ParameterDescription(
              name: 'reservation',
              type: _i1.getType<_i5.Reservation>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['reservation'] as _i3.ReservationEndpoint).create(
            session,
            params['reservation'],
          ),
        ),
      },
    );
    connectors['user'] = _i1.EndpointConnector(
      name: 'user',
      endpoint: endpoints['user']!,
      methodConnectors: {
        'get': _i1.MethodConnector(
          name: 'get',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i4.UserEndpoint).get(
            session,
            params['id'],
          ),
        ),
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'user': _i1.ParameterDescription(
              name: 'user',
              type: _i1.getType<dynamic>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i4.UserEndpoint).create(
            session,
            params['user'],
          ),
        ),
      },
    );
    modules['serverpod_auth'] = _i6.Endpoints()..initializeEndpoints(server);
  }
}
