import 'package:elanwar_agancy_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class UserEndpoint extends Endpoint {
  Future<User?> get(Session session, int id) async {
    return User.db.findById(session, id);
  }

  Future<User?> create(Session session, user) async {
    return User.db.insertRow(session, user);
  }
}
