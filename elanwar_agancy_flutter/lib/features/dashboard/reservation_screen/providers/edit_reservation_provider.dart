import 'package:elanwar_agancy_client/elanwar_agancy_client.dart';
import 'package:elanwar_agancy_flutter/utils/api_client.dart';
import 'package:elanwar_agancy_flutter/utils/singeltons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditReservationProvider extends StateNotifier<Reservation> {
  final reservationClient =
      singelton<ApiClient>().client.reservation; // Serverpod Client
  final Ref ref;

  EditReservationProvider(this.ref, Reservation reservation)
      : super(reservation) {
    init();
  }

  init() async {
    // Initialization logic if needed
  }

  Future<bool> updateReservation(Reservation updatedReservation, {required int id}) async {
    try {
      final success = await reservationClient
          .update(updatedReservation); // Call the server-side update method
      if (success!) {
        state =
            updatedReservation; // Update the state with the new reservation data
        return true; // Indicate success
      }
    } catch (e) {
      // Handle the error, e.g., log or show a message to the user
      print('Error updating reservation: $e');
    }
    return false; // Indicate failure
  }
}

final editReservationProvider = StateNotifierProvider.family<
    EditReservationProvider, Reservation, Reservation>(
  (ref, reservation) {
    return EditReservationProvider(ref, reservation);
  },
);
