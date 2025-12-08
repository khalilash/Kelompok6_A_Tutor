import 'package:flutter/material.dart';
import '../booking/tutor_list_screen.dart';


class TrialPopup extends StatelessWidget {
  const TrialPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 26, 20, 22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            // ===== JUDUL =====
            const Text(
              'Dapatkan\nPercobaan Gratis',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: Color(0xff6A6FE9),
              ),
            ),

            const SizedBox(height: 18),

            // ===== GAMBAR / KARTU TUTOR =====
            SizedBox(
              height: 185, // BESARIN FOTO DI SINI
              width: double.infinity,
              child: Image.asset(
                'assets/popup.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image_not_supported,
                        size: 80, color: Colors.grey),
              ),
            ),

            const SizedBox(height: 18),

            // ===== DESKRIPSI =====
            const Text(
              'Dapatkan sesi gratis dengan tentor\nselama 3 kali',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 22),

            // ===== BUTTON GRADASI =====
            GestureDetector(
  onTap: () {
    Navigator.pop(context); // Tutup popup dulu
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TutorListScreen()),
    );
  },
  child: Container(
    width: double.infinity,
    height: 56,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      gradient: const LinearGradient(
        colors: [
          Color(0xff7078F0),
          Color(0xff9FA6FF),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
    child: const Center(
      child: Text(
        'PESAN SEKARANG',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
        ),
      ),
    ),
  ),
),


            const SizedBox(height: 10),

            // ===== BUTTON NANTI =====
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Nanti',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
