import 'package:elanwar_agancy_client/elanwar_agancy_client.dart';
import 'package:elanwar_agancy_flutter/utils/api_client.dart';
import 'package:elanwar_agancy_flutter/utils/singeltons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteReservationProvider extends StateNotifier<bool> {
  final reservationClient =
      singelton<ApiClient>().client.reservation; // Serverpod Client
  final Ref ref;
  final int id;

  DeleteReservationProvider(this.ref, this.id) : super(false) {
    deleteReservation(); // Call delete method during initialization
  }

  Future<bool> deleteReservation() async {
    try {
      final success = await reservationClient
          .delete(id); // Call the server-side delete method
      if (success!) {
        state = true; // Set state to true if deletion was successful
        return state;
      } else {
        state = false; // Set state to false if deletion failed
        return state;
      }
    } catch (e) {
      // Handle the error, e.g., log or show a message to the user
      print('Error deleting reservation: $e');
      state = false; // Indicate failure if an error occurs
      return state;
    }
  }
}

final deleteReservationProvider =
    StateNotifierProvider.family<DeleteReservationProvider, bool, int>(
  (ref, id) {
    return DeleteReservationProvider(ref, id);
  },
);
