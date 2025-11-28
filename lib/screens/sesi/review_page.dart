import 'package:flutter/material.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Sesi'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: const CircleAvatar(backgroundImage: AssetImage("assets/tutor.png")),
              title: const Text('Khalila'),
              subtitle: const Text('Dosen Pemrograman'),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.greenAccent.shade100, borderRadius: BorderRadius.circular(8)),
                child: const Text('Selesai'),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.menu_book),
                title: const Text('Materi Java Object Oriented Programming'),
                trailing: IconButton(
                  icon: const Icon(Icons.download_outlined),
                  onPressed: () {
                    Navigator.pushNamed(context, '/downloadSuccess');
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              maxLines: 4,
              decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Tulis ulasan kamu...'),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Terima kasih atas ulasannya!')));
                  Navigator.pop(context);
                },
                child: const Text('KIRIM ULASAN'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
