import 'package:elanwar_agancy_client/elanwar_agancy_client.dart';
import 'package:elanwar_agancy_flutter/utils/api_client.dart';
import 'package:elanwar_agancy_flutter/utils/singeltons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TotalPricePerMonthProvider extends StateNotifier<Map<int, double>> {
  final totalPricePerMonthClient =
      singelton<ApiClient>().client.reservation; // Serverpod Client
  final Ref ref;

  TotalPricePerMonthProvider(this.ref) : super({}) {
    getTotalPricePerMonth(); // Fetch total prices per month when initialized
  }

  // Method to retrieve the total prices per month from the server
  getTotalPricePerMonth() async {
    try {
      final totalPricePerMonth =
          await totalPricePerMonthClient.getTotalPricesPerMonth();
      if (totalPricePerMonth != null && totalPricePerMonth.isNotEmpty) {
        state = totalPricePerMonth; // Store total prices per month in the state
      } else {
        // Handle the case when no data is found
        print('No total price data found.');
      }
    } catch (e) {
      // Handle error, log it or show it in the UI
      print('Error retrieving total prices per month: $e');
    }
  }
}

// Riverpod provider for accessing total prices per month
final totalPricePerMonthProvider =
    StateNotifierProvider<TotalPricePerMonthProvider, Map<int, double>>(
  (ref) => TotalPricePerMonthProvider(ref),
);
