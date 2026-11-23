import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const GoldShopApp());
}

class GoldShopApp extends StatelessWidget {
  const GoldShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'محل الذهب',
      debugShowCheckedModeBanner: false,

      // === إعدادات اللغة والاتجاه (RTL) ===
      locale: const Locale('ar', 'SA'),
      supportedLocales: const [
        Locale('ar', 'SA'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // === الثيم (Material 3 + خط IBM Plex Sans Arabic) ===
      theme: _buildArabicTheme(),

      home: const Scaffold(
        body: Center(
          child: Text(
            'مرحبًا بمحل الذهب',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

ThemeData _buildArabicTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFD4AF37), // لون ذهبي
      brightness: Brightness.light,
    ),
  );

  // تطبيق الخط العربي على كل عناصر النص في الثيم
  return base.copyWith(
    textTheme: GoogleFonts.ibmPlexSansArabicTextTheme(base.textTheme),
    primaryTextTheme: GoogleFonts.ibmPlexSansArabicTextTheme(base.primaryTextTheme),
  );
}