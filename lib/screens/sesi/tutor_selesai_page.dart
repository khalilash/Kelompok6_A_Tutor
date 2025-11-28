import 'package:flutter/material.dart';

class TutorSelesaiPage extends StatelessWidget {
  const TutorSelesaiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFFB3C7FF), Color(0xFFDCE6FF)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 320,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
                  child: Column(
                    children: [
                      const Icon(Icons.check_circle_outline, size: 64, color: Color(0xFF6C63FF)),
                      const SizedBox(height: 12),
                      const Text('Sesi Tutor Telah Selesai', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 14),
                      ElevatedButton(
                        onPressed: () {
                          // mark hasRecording true by sending arg when going back to detail
                          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false, arguments: {'hasRecording': true});
                        },
                        child: const Text('Selesai'),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/review');
                        },
                        child: const Text('Ulas Sekarang'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
