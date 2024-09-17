import 'package:elanwar_agancy_flutter/core/models/session.dart';
import 'package:elanwar_agancy_flutter/utils/api_client.dart';
import 'package:elanwar_agancy_flutter/utils/singeltons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionProvider extends StateNotifier<Session> {
  final Ref ref;

  final sessionManager = singelton<ApiClient>().sessionManager;
  final client = singelton<ApiClient>().client;

  SessionProvider(this.ref, Session initial) : super(initial) {
    init();
  }

  init() {
    updateUser();
  }

  updateUser() async {
    final user = sessionManager.signedInUser;
    state = state.copyWith(user: user);
  }

  logOut() async {
    await sessionManager.signOut();
    updateUser();
  }
}

final sessionProvider = StateNotifierProvider<SessionProvider, Session>(
    (ref) => SessionProvider(ref, Session()));
