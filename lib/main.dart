import 'package:flutter/material.dart';

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

      // 🔹 SEMENTARA: langsung buka halaman ChatList dulu
      // home: const WelcomeScreen(),   // ini nanti bisa dipakai lagi
      home: const ChatListScreen(),

      // 🔹 Optional: sekalian daftarin route, kalau mau pakai Navigator.pushNamed
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/chat': (context) => const ChatListScreen(),
      },
    );
  }
}
