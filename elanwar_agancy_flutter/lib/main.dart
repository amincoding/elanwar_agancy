import 'dart:io'; // Import to use Platform class
import 'package:elanwar_agancy_flutter/core/app_router.dart';
import 'package:elanwar_agancy_flutter/utils/singeltons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart'; // For Windows effects
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart'; // For window control (minimize, maximize, close)

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await intiSingeltons();

  // Check if the platform is Windows and apply Windows-specific configuration
  if (Platform.isWindows) {
    await Window.initialize();
    await Window.setEffect(
      effect: WindowEffect.mica, // Choose desired effect (mica, acrylic, etc.)
      dark: true,
    );
    doWhenWindowReady(() {
      final initialSize = Size(1280, 800);
      appWindow.minSize = initialSize;
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.title = "وكالة انوار الصباح للسياحة والأسفار ادرار";
      appWindow.show();
    });
  }

  runApp(
    const ProviderScope(
      child: SafeArea(child: MyApp()),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'وكالة انوار الصباح للسياحة والأسفار ادرار',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
      ),
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
    );
  }
}
