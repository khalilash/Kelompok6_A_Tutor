import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// DEBUG PAGE
import 'screens/debug/users_debug_page.dart';

// HOMEPAGE KAMU
import 'screens/homepage/homepage.dart';

// FILE TEMAN (LOKASI BARU)
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
import 'screens/profilepage/profile_page.dart';
import 'splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Supabase
  await Supabase.initialize(
    url: 'https://hqcdhreharfszhsdmqlm.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhxY2RocmVoYXJmc3poc2RtcWxtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ0MDA5NjYsImV4cCI6MjA3OTk3Njk2Nn0.y2yNSnwidqJus5s4XiUTI2KnG0C6W6mXkP8WAUVt9N4',
  );

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
      // sementara kalau mau test Supabase bisa pake:
      // home: const UsersDebugPage(),
      //home: const SplashPage(),
      //home: const UsersDebugPage(),
      home: const SplashPage(),

      // ROUTES
      routes: {
        '/homepage': (context) => const HomePage(),
        '/search': (context) => const SearchPage(),
        '/chat': (context) => const ChatListScreen(),
        '/sesi': (context) => const DetailSesiPage(),
        '/popupBelumDimulai': (context) => const PopupBelumDimulai(),
        '/downloadSuccess': (context) => const DownloadSuccessPage(),
        '/callingPage': (context) => const CallingPage(),
        '/reviewPage': (context) => const ReviewPage(),
        '/tutorSelesaiPage': (context) => const TutorSelesaiPage(),
        '/videoCallPage': (context) => const VideoCallPage(),
        '/sesiSelesai': (context) => const DetailSesiSelesaiPage(),
        '/profile': (context) => const ProfilePage(),
        '/debugUsers': (context) => const UsersDebugPage(),
      },
    );
  }
}
