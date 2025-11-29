import 'package:flutter/material.dart';

class DownloadSuccessPage extends StatelessWidget {
  const DownloadSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const Icon(Icons.check_circle, size: 70, color: Color(0xFF3B82F6)),
                const SizedBox(height: 12),
                const Text('Materi berhasil diunduh', textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
                const SizedBox(height: 14),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Kembali'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
