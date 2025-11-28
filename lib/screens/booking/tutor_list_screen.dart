import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'select_date_screen.dart';

// =========================
// MODEL TUTOR
// =========================
class Tutor {
  final String name;
  final String subject;
  final String rating;
  final String image;
  final int price;
  final List<Color> gradient;

  Tutor({
    required this.name,
    required this.subject,
    required this.rating,
    required this.image,
    required this.price,
    required this.gradient,
  });
}

// =========================
// TUTOR LIST SCREEN
// =========================
class TutorListScreen extends StatelessWidget {
  const TutorListScreen({super.key});

  List<Tutor> get tutors => [
        Tutor(
          name: "Juno",
          subject: "Geometri Analitik",
          rating: "4.9",
          image: "assets/tutor1.png",
          price: 50000,
          gradient: const [Color(0xFFFF8FA9), Color(0xFFFFC3D0)],
        ),
        Tutor(
          name: "Lea",
          subject: "Geometri Analitik",
          rating: "4.9",
          image: "assets/tutor2.png",
          price: 50000,
          gradient: const [Color(0xFFFFB678), Color(0xFFFFD5AE)],
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _background(),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 25),

              // HEADER
              Text(
                "Tutor",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              // CONTENT
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(26)),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: tutors.length,
                    itemBuilder: (context, i) {
                      return _buildTutorCard(context, tutors[i]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================
  // CARD TUTOR
  // ==========================
  Widget _buildTutorCard(BuildContext context, Tutor t) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SelectDateScreen(tutor: t),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: t.gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
        ),

        // pakai Stack supaya tombol bisa di bawah kanan
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // FOTO PAKAI BACKGROUND PUTIH
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      t.image,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // TEXT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.name,
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        t.subject,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.yellow, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            t.rating,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Rp${t.price}",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // TOMBOL PESAN SESI (KANAN BAWAH)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2340), // navy
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  "Pesan Sesi",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================
  // BACKGROUND GRADIENT
  // ==========================
  BoxDecoration _background() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFBACEFF), Color(0xFF79A9FF)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }
}
