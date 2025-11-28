import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int rating = 4;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is Map<String, dynamic>) {
      rating = args["ratingAwal"] ?? 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        title: const Text('Detail Sesi'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Stack(
        children: [
          // ---------------- BACKGROUND GAMBAR ----------------
          Positioned.fill(
            child: Image.asset(
              "assets/bg.png",
              fit: BoxFit.cover,
            ),
          ),

          // ---------------- OVERLAY PUTIH OPACITY ----------------
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.85),
            ),
          ),

          // ---------------- CARD PUTIH MELAYANG ----------------
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Tutor Info
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage("assets/tutor.png"),
                    ),
                    title: const Text(
                      "Khalila",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text("Dosen Pemrograman"),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text("Selesai"),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // RATING
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (i) {
                      return IconButton(
                        icon: Icon(
                          i < rating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 32,
                        ),
                        onPressed: () {
                          setState(() {
                            rating = i + 1;
                          });
                        },
                      );
                    }),
                  ),

                  const SizedBox(height: 12),

                  // TEXT REVIEW
                  const TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Tulis ulasan kamu...",
                    ),
                  ),

                  const SizedBox(height: 20),

                  // BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Terima kasih atas ulasannya!"),
                          ),
                        );

                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/',
                          (route) => false,
                          arguments: {
                            "hasRecording": true,
                            "sesiSelesai": true,
                            "ratingAwal": rating,
                          },
                        );
                      },
                      child: const Text("KIRIM ULASAN"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}