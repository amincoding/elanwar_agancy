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
      Platform.isAndroid
          ? 'http://$localIp:8080/' // Using the local IP address
          : 'http://localhost:8080/',
      authenticationKeyManager: FlutterAuthenticationKeyManager(),
    )..connectivityMonitor = FlutterConnectivityMonitor();

    sessionManager = SessionManager(caller: client.modules.auth);
    await sessionManager.initialize();
  }

  Future<String> _getLocalIpAddress() async {
    try {
      List<NetworkInterface> interfaces = await NetworkInterface.list(
        includeLoopback: false,
        type: InternetAddressType.IPv4,
      );
      for (var interface in interfaces) {
        for (var addr in interface.addresses) {
          if (!addr.isLoopback) {
            return addr.address; // Return the first non-loopback IP address
          }
        }
      }
    } catch (e) {
      print('Failed to get IP address: $e');
    }
    return '127.0.0.1'; // Fallback to localhost if IP address cannot be determined
  }
}
