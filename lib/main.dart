import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// import welcome (punya temenmu)
import 'screens/welcome/welcome_screen.dart';
// import chat list (punyamu)
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

      // 🔹 SEMUA TEXT DI APP DEFAULT PAKAI POPPINS
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: false,
      ),

      // 🔹 SEMENTARA: langsung buka halaman ChatList dulu
      // home: const WelcomeScreen(),   // ini nanti bisa dipakai lagi
      home: const ChatListScreen(),

      // 🔹 Optional: route kalau mau pakai pushNamed
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/chat': (context) => const ChatListScreen(),
      },
    );
  }
}
