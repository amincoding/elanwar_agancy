import 'package:elanwar_agancy_flutter/utils/api_client.dart';
import 'package:elanwar_agancy_flutter/utils/singeltons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TotalMoneyProvider extends StateNotifier<double?> {
  final reservationClient =
      singelton<ApiClient>().client.reservation; // Serverpod Client
  final Ref ref;

  TotalMoneyProvider(this.ref) : super(null) {
    getTotalPrices(); // Fetch max price reservation when initialized
  }

  // Method to retrieve the reservation with the maximum price from the server
  getTotalPrices() async {
    try {
      final totalMoney = await reservationClient.getTotalPrices();
      if (totalMoney != null) {
        state = totalMoney;
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
final totalMoneyProvider = StateNotifierProvider<TotalMoneyProvider, double?>(
  (ref) => TotalMoneyProvider(ref),
);
