import 'package:elanwar_agancy_flutter/core/providers/session_provider.dart';
import 'package:elanwar_agancy_flutter/features/dashboard/main_screen/screens/main_screen.dart';
import 'package:elanwar_agancy_flutter/features/login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppContainer extends ConsumerWidget {
  const AppContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(sessionProvider).isAuthenticated
        ? const MainScreen()
        : const LoginScreen();
  }
}
