import 'package:elanwar_agancy_client/elanwar_agancy_client.dart';
import 'package:elanwar_agancy_flutter/utils/api_client.dart';
import 'package:elanwar_agancy_flutter/utils/singeltons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetUserProvider extends StateNotifier<User?> {
  final userClient = singelton<ApiClient>().client.user; // Serverpod Client
  final Ref ref;

  GetUserProvider(this.ref) : super(null);

  // Method to retrieve a user by ID from the server
  Future<void> fetchUserById(int userId) async {
    try {
      final user = await userClient
          .get(userId); // Assuming `getUserById` exists in your client
      state = user;
    } catch (e) {
      // Handle error, log it or show it in the UI
      print('Error retrieving user: $e');
    }
  }
}

// StateNotifierProvider to fetch the user by ID
final getUserByIdProvider = StateNotifierProvider<GetUserProvider, User?>(
  (ref) => GetUserProvider(ref),
);
