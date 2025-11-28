import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// gunakan WelcomeScreen milik kamu
import 'screens/login-register/welcome_screen.dart';

// gunakan ChatListScreen milik temanmu
import 'screens/chat/chat_list_screen.dart';

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
        useMaterial3: false, // pakai setting temanmu biar konsisten
      ),

      // Halaman pertama aplikasi → WelcomeScreen milik kamu
      home: const WelcomeScreen(),

      // Semua route digabung
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/chat': (context) => const ChatListScreen(),
      },
    );
  }
}
