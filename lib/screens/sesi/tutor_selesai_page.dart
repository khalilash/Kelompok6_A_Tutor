import 'package:flutter/material.dart';




class TutorSelesaiPage extends StatelessWidget {
  const TutorSelesaiPage({super.key});




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bgsesi.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Container(
              width: 320,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 12)
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle_outline,
                      size: 64, color: Color(0xFF6C63FF)),
                  const SizedBox(height: 12),
                  const Text('Sesi Tutor Telah Selesai',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 16),




                  ///  Hanya tombol SELESAI
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/reviewPage');
                    },
                    child: const Text("Selesai"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
