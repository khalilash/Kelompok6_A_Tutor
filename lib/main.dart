import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor/screens/booking/tutor_list_screen.dart';
import 'package:tutor/screens/sesi/detail_sesi_page.dart';

// HOMEPAGE KAMU
import 'screens/homepage/homepage.dart';

// FILE TEMAN (LOKASI BARU)
import 'screens/login-register/welcome_screen.dart';
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

      // THEME APP
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: false,
      ),

      // HALAMAN PERTAMA
      home: const WelcomeScreen(),

      // ROUTES
      routes: {
        '/homepage': (context) => const HomePage(),
        '/search': (context) => const SearchPage(),
        '/chat': (context) => const ChatListScreen(),
        '/booking': (context) => const TutorListScreen(),
        '/sesi': (context) => const DetailSesiPage(),
      },
    );
  }
}
