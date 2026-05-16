import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp/splash.dart';

// Professional Color Palette
const kBackgroundColor = Color(0xFF0F172A); // Deep Midnight
const kSurfaceColor = Color(0xFF1E293B);    // Slate Surface
const kPrimaryColor = Color(0xFF6366F1);    // Indigo
const kAccentColor = Color(0xFFF59E0B);     // Amber
const kSuccessColor = Color(0xFF10B981);    // Emerald
const kErrorColor = Color(0xFFF43F5E);      // Rose
const kTextPrimary = Color(0xFFF8FAFC);     // Ghost White
const kTextSecondary = Color(0xFF94A3B8);   // Slate Gray

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Professional Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        colorScheme: const ColorScheme.dark(
          primary: kPrimaryColor,
          secondary: kAccentColor,
          surface: kSurfaceColor,
          error: kErrorColor,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.dark().textTheme.apply(
                bodyColor: kTextPrimary,
                displayColor: kTextPrimary,
              ),
        ),
        useMaterial3: true,
      ),
      home: const Splash(),
    );
  }
}

