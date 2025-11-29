import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


// HOMEPAGE KAMU
import 'screens/homepage/homepage.dart';


// FILE TEMAN (LOKASI BARU)
import 'screens/login-register/welcome_screen.dart';
import 'screens/chat/chat_list_screen.dart';
import 'screens/search/search_page.dart';
import 'screens/sesi/detail_sesi_page.dart';
import 'screens/sesi/popup_belum_dimulai.dart';
import 'screens/sesi/download_success_page.dart';
import 'screens/sesi/video_call_page.dart';
import 'screens/sesi/tutor_selesai_page.dart';
import 'screens/sesi/review_page.dart';
import 'screens/sesi/calling_page.dart';
import 'screens/sesi/detail_sesi_selesai_page.dart';




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
        '/sesi' : (context) => const DetailSesiPage(),
        '/popupBelumDimulai': (context) => const PopupBelumDimulai(),
        '/downloadSuccess': (context) => const DownloadSuccessPage(),
        '/callingPage': (context) => const CallingPage(),
        '/reviewPage': (context) => const ReviewPage(),
        '/tutorSelesaiPage': (context) => const TutorSelesaiPage(),
        '/videoCallPage': (context) => const VideoCallPage(),
        '/sesiSelesai': (context) => const DetailSesiSelesaiPage(),
      },
    );
  }
}