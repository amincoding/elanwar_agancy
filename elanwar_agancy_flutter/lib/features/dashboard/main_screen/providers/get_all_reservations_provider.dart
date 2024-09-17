import 'package:elanwar_agancy_client/elanwar_agancy_client.dart';
import 'package:elanwar_agancy_flutter/utils/api_client.dart';
import 'package:elanwar_agancy_flutter/utils/singeltons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetAllReservationsProvider extends StateNotifier<List<Reservation?>> {
  final reservationClient =
      singelton<ApiClient>().client.reservation; // Serverpod Client
  final Ref ref;

  GetAllReservationsProvider(this.ref) : super([]) {
    fetchReservations(); // Fetch suppliers when initialized
  }

  // Method to retrieve a list of suppliers from the server
  fetchReservations() async {
    try {
      final reservations = await reservationClient
          .getAll(); // Assuming you have a method to fetch all suppliers
      state = reservations;
    } catch (e) {
      // Handle error, log it or show it in the UI
      print('Error retrieving suppliers: $e');
      state = [];
    }
  }
}

final getAllReservationsProvider =
    StateNotifierProvider<GetAllReservationsProvider, List<Reservation?>>(
  (ref) => GetAllReservationsProvider(ref),
);
