import 'package:flutter/material.dart';
import 'screens/welcome/welcome_screen.dart';
import 'screens/search/search_page.dart';   // ← pastikan ini ada

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // HALAMAN YANG MUNCUL PERTAMA KALI
      home: const SearchPage(),   // ← halaman yang kamu kerjain tadi
    );
  }
}
