import 'dart:io';
import 'package:elanwar_agancy_client/elanwar_agancy_client.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

abstract class ApiClient {
  late SessionManager sessionManager;

  late Client client;

  Future<void> init();
}

class ApiClientImplementation extends ApiClient {
  @override
  Future<void> init() async {
    String localIp = await _getLocalIpAddress();

    client = Client(
      'http://localhost:8080/',
      authenticationKeyManager: FlutterAuthenticationKeyManager(),
    )..connectivityMonitor = FlutterConnectivityMonitor();

    sessionManager = SessionManager(caller: client.modules.auth);
    await sessionManager.initialize();
  } 

}
