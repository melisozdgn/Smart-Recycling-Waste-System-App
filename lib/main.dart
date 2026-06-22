import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:srws_app/core/l10n/app_localizations.dart'; 
import 'package:srws_app/core/dependency_injection/injection_container.dart';
import 'package:srws_app/core/theme/srws_theme.dart';
import 'package:srws_app/features/splash/presentation/pages/splash_screen.dart';

// 🎯 GLOBAL MOTOR: Ayarlar ekranından tıklandığında MaterialApp'e "Dili değiştir" diyecek anahtar
late Function(Locale) changeLocale;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDI();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      defaultDevice: Devices.ios.iPhone13,
      builder: (context) => const SrwsApp(),
    ),
  );
}

class SrwsApp extends StatefulWidget {
  const SrwsApp({super.key});

  @override
  State<SrwsApp> createState() => _SrwsAppState();
}

class _SrwsAppState extends State<SrwsApp> {
  // 🎯 BAŞLANGIÇ DİLİ: Tam istediğin gibi zorunlu olarak İngilizce (en) başlıyor
  Locale _currentLocale = const Locale('en');

  @override
  void initState() {
    super.initState();
    // Dışarıdan tetiklenebilecek fonksiyonumuzu MaterialApp'e bağlıyoruz
    changeLocale = (Locale newLocale) {
      setState(() {
        _currentLocale = newLocale;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Recycling Waste System',
      debugShowCheckedModeBanner: false,
      
      // Dil durumunu buradaki değişkenden okumasını sağlıyoruz
      locale: _currentLocale, 
      
      localizationsDelegates: AppLocalizations.localizationsDelegates, 
      supportedLocales: AppLocalizations.supportedLocales, 
      
      builder: DevicePreview.appBuilder,
      theme: SrwsTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}