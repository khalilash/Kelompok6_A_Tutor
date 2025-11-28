import 'package:flutter/material.dart';

class PopupBelumDimulai extends StatelessWidget {
  const PopupBelumDimulai({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // semi-transparent background
      backgroundColor: Colors.black45,
      body: SafeArea(
        child: Center(
          child: Container(
            width: 320,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.access_time_outlined, size: 72, color: Color(0xFF3B82F6)),
                const SizedBox(height: 12),
                const Text('Sesi Anda belum dimulai', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Gabung sesi sesuai jadwal yang dipilih.'),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Kembali'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // close popup
                          Navigator.pushNamed(context, '/calling');
                        },
                        child: const Text('Coba Gabung'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
