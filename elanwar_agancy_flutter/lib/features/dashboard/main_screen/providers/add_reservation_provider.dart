import 'package:elanwar_agancy_client/elanwar_agancy_client.dart';
import 'package:elanwar_agancy_flutter/utils/api_client.dart';
import 'package:elanwar_agancy_flutter/utils/singeltons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddReservationProvider extends StateNotifier<Reservation> {
  final reservationClient =
      singelton<ApiClient>().client.reservation; // Serverpod Client
  final Ref ref;

  AddReservationProvider(this.ref, Reservation reservation)
      : super(reservation) {
    init();
  }

  init() async {
    try {
      final success = await reservationClient
          .create(state); // Call the server-side create method
      if (success!) {
        state =
            state; // Serverpod returns true, so no need to update state in this case unless the server modifies data
      }
    } catch (e) {
      // Handle the error, e.g. log or show a message to the user
      print('Error creating supplier: $e');
    }
  }
}

final addReservationProvider = StateNotifierProvider.family<AddReservationProvider,
    Reservation, Reservation>(
  (ref, supplier) {
    return AddReservationProvider(ref, supplier);
  },
);
