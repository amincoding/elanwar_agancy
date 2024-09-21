import 'dart:math';

import 'package:elanwar_agancy_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart';

class ReservationEndpoint extends Endpoint {
  Future<List<Reservation?>> getAll(Session session) async {
    return Reservation.db.find(session,
        include: Reservation.include(
            user: User.include(userInfo: UserInfo.include())));
  }

  Future<Reservation?> getByUserId(Session session, int userId) async {
    return Reservation.db.findFirstRow(
      session,
      where: (row) => row.userId.equals(userId),
    );
  }

  Future<Reservation?> getByName(Session session, String name) async {
    return Reservation.db.findFirstRow(
      session,
      where: (row) => row.hotel.equals(name),
    );
  }

  Future<Reservation?> getByRoomNumber(Session session, int roomNumber) async {
    return Reservation.db.findFirstRow(
      session,
      where: (row) => row.room.equals(roomNumber),
    );
  }

  Future<Reservation?> getByTotalPrice(Session session, double price) async {
    return Reservation.db.findFirstRow(
      session,
      where: (row) => row.totalPrice.equals(price),
    );
  }

  Future<Reservation?> getMaxPrice(Session session) async {
    // Get all reservations
    final List<Reservation> reservations = await Reservation.db.find(session);

    // Find the reservation with the maximum totalPrice
    if (reservations.isEmpty) return null;

    Reservation maxReservation = reservations[0];
    for (var reservation in reservations) {
      if (reservation.totalPrice > maxReservation.totalPrice) {
        maxReservation = reservation;
      }
    }

    return maxReservation;
  }

  Future<double?> getTotalPrices(Session session) async {
    // Get all reservations
    final List<Reservation> reservations = await Reservation.db.find(session);

    // Find the reservation with the maximum totalPrice
    if (reservations.isEmpty) return null;

    double totalPrices = 0;
    for (var reservation in reservations) {
      totalPrices += reservation.totalPrice;
    }

    return totalPrices;
  }

  Future<double?> getTotalDebts(Session session) async {
    // Get all reservations
    final List<Reservation> reservations = await Reservation.db.find(session);

    // Find the reservation with the maximum totalPrice
    if (reservations.isEmpty) return null;

    double totalDebts = 0;
    for (var reservation in reservations) {
      if (reservation.debt == null) {
        totalDebts += 0;
      }
      totalDebts += reservation.debt!;
    }

    return totalDebts;
  }

  Future<Map<int, double>> getTotalPricesPerMonth(Session session) async {
    // Get all reservations
    final List<Reservation> reservations = await Reservation.db.find(session);

    // Create a map to hold the total prices for each month
    Map<int, double> totalPricesPerMonth = {};

    // Iterate through each reservation
    for (var reservation in reservations) {
      // Get the month from the reservation's createdDate
      int month = reservation.createAt.month;

      // Add the totalPrice to the corresponding month
      if (totalPricesPerMonth.containsKey(month)) {
        totalPricesPerMonth[month] =
            totalPricesPerMonth[month]! + reservation.totalPrice;
      } else {
        totalPricesPerMonth[month] = reservation.totalPrice;
      }
    }

    // Return the map with the total prices for each month
    return totalPricesPerMonth;
  }

  Future<Reservation?> getIsExpired(Session session, bool isExpired) async {
    return Reservation.db.findFirstRow(
      session,
      where: (row) => row.isExpired.equals(isExpired),
    );
  }

  Future<bool?> create(Session session, Reservation reservation) async {
    await Reservation.db.insertRow(session, reservation);
    return true;
  }
}
