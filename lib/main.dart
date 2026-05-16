import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:srws_app/core/dependency_injection/injection_container.dart';
import 'package:srws_app/core/theme/srws_theme.dart';
import 'package:srws_app/features/splash/presentation/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDI();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const SrwsApp(),
    ),
  );
}

class SrwsApp extends StatelessWidget {
  const SrwsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Recycling Waste System',
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: SrwsTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
