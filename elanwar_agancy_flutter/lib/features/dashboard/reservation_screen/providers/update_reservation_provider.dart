import 'package:elanwar_agancy_client/elanwar_agancy_client.dart';
import 'package:elanwar_agancy_flutter/utils/api_client.dart';
import 'package:elanwar_agancy_flutter/utils/singeltons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateReservationProvider extends StateNotifier<Reservation> {
  final reservationClient =
      singelton<ApiClient>().client.reservation; // Serverpod Client
  final Ref ref;

  UpdateReservationProvider(this.ref, Reservation reservation)
      : super(reservation) {
    updateReservation(); // Call update method during initialization
  }

  Future<void> updateReservation() async {
    try {
      final success = await reservationClient
          .update(state); // Call the server-side update method
      if (success!) {
        // If the server returns an updated reservation object, you can assign it to state
        // state = updatedReservation; // If the server returns the updated object
        // If you don't need to modify the state, you can simply log the success
        print('Reservation updated successfully.');
      }
    } catch (e) {
      // Handle the error, e.g., log or show a message to the user
      print('Error updating reservation: $e');
    }
  }
}

final updateReservationProvider = StateNotifierProvider.family<
    UpdateReservationProvider, Reservation, Reservation>(
  (ref, reservation) {
    return UpdateReservationProvider(ref, reservation);
  },
);
