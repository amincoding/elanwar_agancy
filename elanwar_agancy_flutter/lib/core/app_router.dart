import 'package:elanwar_agancy_flutter/features/dashboard/main_screen/screens/main_screen.dart';
import 'package:elanwar_agancy_flutter/features/login/screens/app_container.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
    ],
  );
}
