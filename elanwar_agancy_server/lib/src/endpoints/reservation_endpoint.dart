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
