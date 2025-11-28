import 'package:flutter/material.dart';
import 'screens/sesi/detail_sesi_page.dart';
import 'screens/sesi/popup_belum_dimulai.dart';
import 'screens/sesi/calling_page.dart';
import 'screens/sesi/video_call_page.dart';
import 'screens/sesi/tutor_selesai_page.dart';
import 'screens/sesi/review_page.dart';
import 'screens/sesi/download_success_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tutor Session',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      // initialRoute masih '/', tapi kita akan pass arg saat kembali dari selesai
      initialRoute: '/',
      routes: {
        '/': (_) => const DetailSesiPage(),
        '/popupBelumDimulai': (_) => const PopupBelumDimulai(),
        '/calling': (_) => const CallingPage(),
        '/videoCall': (_) => const VideoCallPage(),
        '/tutorSelesai': (_) => const TutorSelesaiPage(),
        '/review': (_) => const ReviewPage(),
        '/downloadSuccess': (_) => const DownloadSuccessPage(),
      },
    );
  }
}
