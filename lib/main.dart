import 'package:flutter/material.dart';
import 'screens/discover_screen.dart';

void main() {
  runApp(const ChapterApp());
}

class ChapterApp extends StatelessWidget {
  const ChapterApp({super.key});

  @override
  Widget build(BuildContext context) {
    const cream = Color(0xFFF4E8D8);
    const burgundy = Color(0xFF7B302F);
    const terracotta = Color(0xFFB86F50);
    const olive = Color(0xFF7B8060);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chapter',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: cream,
        colorScheme: ColorScheme.fromSeed(
          seedColor: terracotta,
          primary: burgundy,
          secondary: olive,
          surface: const Color(0xFFFFFAF4),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: cream,
          foregroundColor: burgundy,
          elevation: 0,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFFFFFAF4),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: burgundy,
            fontSize: 30,
            fontWeight: FontWeight.w800,
            height: 1.1,
          ),
          headlineMedium: TextStyle(
            color: burgundy,
            fontSize: 23,
            fontWeight: FontWeight.w800,
          ),
          titleLarge: TextStyle(
            color: burgundy,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          bodyMedium: TextStyle(
            color: Color(0xFF5E5147),
            fontSize: 14,
            height: 1.45,
          ),
        ),
      ),
      home: const DiscoverScreen(),
    );
  }
}
