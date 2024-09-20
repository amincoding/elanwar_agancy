import 'package:elanwar_agancy_client/elanwar_agancy_client.dart';
import 'package:elanwar_agancy_flutter/utils/api_client.dart';
import 'package:elanwar_agancy_flutter/utils/singeltons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatsProvider extends StateNotifier<Reservation?> {
  final reservationClient =
      singelton<ApiClient>().client.reservation; // Serverpod Client
  final Ref ref;

  StatsProvider(this.ref) : super(null) {
    getMaxPrices(); // Fetch max price reservation when initialized
  }

  // Method to retrieve the reservation with the maximum price from the server
  getMaxPrices() async {
    try {
      final maxReservation = await reservationClient.getMaxPrice();
      if (maxReservation != null) {
        state = maxReservation;
      } else {
        // Handle the case when no reservation is found
        print('No reservation with a maximum price found.');
      }
    } catch (e) {
      // Handle error, log it or show it in the UI
      print('Error retrieving max price reservation: $e');
    }
  }
}

// Riverpod provider for accessing the max price reservation
final maxPriceProvider = StateNotifierProvider<StatsProvider, Reservation?>(
  (ref) => StatsProvider(ref),
);
