import 'package:elanwar_agancy_client/elanwar_agancy_client.dart';
import 'package:elanwar_agancy_flutter/utils/api_client.dart';
import 'package:elanwar_agancy_flutter/utils/singeltons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TotalDebtsProvider extends StateNotifier<double?> {
  final reservationClient =
      singelton<ApiClient>().client.reservation; // Serverpod Client
  final Ref ref;

  TotalDebtsProvider(this.ref) : super(null) {
    getTotalDebts(); // Fetch max price reservation when initialized
  }

  // Method to retrieve the reservation with the maximum price from the server
  getTotalDebts() async {
    try {
      final totalDebts = await reservationClient.getTotalDebts();
      if (totalDebts != null) {
        state = totalDebts;
      } else {
        // Handle the case when no reservation is found
        print('No reservation with a maximum price found.');
      }
    } catch (e) {
      // Handle error, log it or show it in the UI
      print('Error retrieving total debts: $e');
    }
  }
}

// Riverpod provider for accessing the max price reservation
final totalDebtsProvider = StateNotifierProvider<TotalDebtsProvider, double?>(
  (ref) => TotalDebtsProvider(ref),
);
