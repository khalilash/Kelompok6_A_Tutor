import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Pilih yang sesuai lokasi WelcomeScreen milik kalian ↓
// Kalau welcome_screen.dart ada di screens/welcome:
import 'screens/welcome/welcome_screen.dart';

// Kalau welcome_screen di login-register, pakai ini (ganti yang atas):
// import 'screens/login-register/welcome_screen.dart';

import 'screens/chat/chat_list_screen.dart';
import 'screens/search/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: false,
      ),

      // HALAMAN YANG PERTAMA MUNCUL
      home: const SearchPage(),

      // Semua route lain tetap ada
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/chat': (context) => const ChatListScreen(),
      },
    );
  }
}
