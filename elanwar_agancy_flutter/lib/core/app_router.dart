import 'dart:ffi';
import 'package:elanwar_agancy_flutter/features/dashboard/main_screen/providers/get_all_reservations_provider.dart';
import 'package:elanwar_agancy_flutter/features/dashboard/main_screen/screens/main_screen.dart';
import 'package:elanwar_agancy_flutter/features/dashboard/reservation_screen/reservatoins_screen.dart';
import 'package:elanwar_agancy_flutter/features/dashboard/reservation_screen/reservatoins_screen_android.dart';
import 'package:elanwar_agancy_flutter/features/login/screens/app_container.dart';
import 'package:elanwar_agancy_flutter/features/stats/screens/stats_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/invoice_screen/screens/invoice_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    initialLocation: "/appContainer",
    routes: [
      GoRoute(
        path: "/appContainer",
        builder: (context, state) => const AppContainer(),
      ),
      GoRoute(
        path: "/mainScreen",
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: "/reservationScreen",
        builder: (context, state) => const ReservationsScreen(),
      ),
      GoRoute(
        path: "/reservationScreenAndroid",
        builder: (context, state) => const ReservatoinsScreenAndroid(),
      ),
      GoRoute(
        path: "/stats",
        builder: (context, state) => const StartsScreen(),
      ),
      GoRoute(
          path: '/invoice/:clientId',
          builder: (context, state) {
            final clientId = state.pathParameters['clientId']!;

            return InvoiceScreen(
              clientId: int.parse(clientId),
            );
          }),
    ],
  );
}
