import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// HOME PAGE PUNYAMU
import 'screens/homepage/homepage.dart';

// PAGE PUNYA TEMAN
import 'screens/welcome/welcome_screen.dart';
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

      // THEME
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: false,
      ),

      // HALAMAN AWAL (boleh ganti kalau mau Welcome/Home langsung)
      home: const WelcomeScreen(),

      // ROUTE TAMBAHAN
      routes: {
        '/homepage': (context) => const HomePage(),
        '/search': (context) => const SearchPage(),
        '/chat': (context) => const ChatListScreen(),
      },
    );
  }
}
