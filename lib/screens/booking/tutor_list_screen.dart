import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// IMPORT SCREEN-TARGET
import '../homepage/homepage.dart';
import '../chat/chat_list_screen.dart';
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
  final Color cardColor;
  final Color blobColor;

  Tutor({
    required this.name,
    required this.subject,
    required this.rating,
    required this.image,
    required this.price,
    required this.cardColor,
    required this.blobColor,
  });
}


// =========================
// TUTOR LIST SCREEN
// =========================
class TutorListScreen extends StatelessWidget {
  const TutorListScreen({super.key});

  List<Tutor> get tutors => [
        Tutor(
          name: "Khalila",
          subject: "Dasar Pemrograman",
          rating: "4.9",
          image: "assets/tutors/khalila.png",
          price: 50000,
          cardColor: const Color(0xFFFFA975),
          blobColor: const Color(0xFFD65609),
        ),
        Tutor(
          name: "Juno",
          subject: "Pemrograman Web",
          rating: "4.9",
          image: "assets/tutors/juno.png",
          price: 50000,
          cardColor: const Color(0xFFFEB8C3),
          blobColor: const Color(0xFFFFACB9),
        ),
        Tutor(
          name: "Adlin",
          subject: "Pilates",
          rating: "4.9",
          image: "assets/tutors/adlin.png",
          price: 50000,
          cardColor: const Color(0xFFBCC6F6),
          blobColor: const Color(0xFF566CD8),
        ),
        Tutor(
          name: "Lea",
          subject: "UX Design",
          rating: "4.9",
          image: "assets/tutors/lea.png",
          price: 50000,
          cardColor: const Color(0xFFFFA975),
          blobColor: const Color(0xFFD65609),
        ),
        Tutor(
          name: "Haryo",
          subject: "Sistem Enterprise",
          rating: "4.9",
          image: "assets/tutors/haryo.png",
          price: 50000,
          cardColor: const Color(0xFFFEB8C3),
          blobColor: const Color(0xFFFFACB9),
        ),
        Tutor(
          name: "Sasha",
          subject: "Pweb",
          rating: "4.9",
          image: "assets/tutors/sasha.png",
          price: 50000,
          cardColor: const Color(0xFFBCC6F6),
          blobColor: const Color(0xFF566CD8),
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
              const SizedBox(height: 12),

              // ==========================
              // HEADER
              // ==========================
              Row(
                children: [
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomePage(),
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Tutor",
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),

              const SizedBox(height: 12),

              // ==========================
              // CONTENT WHITE PANEL
              // ==========================
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
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
  // CARD TUTOR STYLE BARU
  // ==========================
  Widget _buildTutorCard(BuildContext context, Tutor t) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Stack(
          children: [
            // BACKGROUND SOLID
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: t.cardColor,
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
            ),

            // BLOBS
            Positioned(
              top: -40,
              left: -20,
              child: _Blob(
                color: Colors.white.withOpacity(0.22),
                size: 150,
              ),
            ),
            Positioned(
              top: 10,
              right: -50,
              child: _Blob(
                color: t.blobColor.withOpacity(0.25),
                size: 180,
              ),
            ),

            // CONTENT DALAM CARD
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // FOTO
                  Container(
                    width: 72,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        t.image,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),

                  // TEXTS + BUTTONS
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.name,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: t.blobColor,
                          ),
                        ),
                        Text(
                          t.subject,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: t.blobColor,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // HARGA + CHAT + PESAN SESI SEJAJAR
                        Row(
                          children: [
                            Text(
                              "Rp${t.price}",
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF343446),
                              ),
                            ),

                            const Spacer(),

                            // CHAT BUTTON
                            _pillButton(
                              label: "Chat",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const ChatListScreen(),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 8),

                            // PESAN SESI BUTTON
                            _pillButton(
                              label: "Pesan Sesi",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        SelectDateScreen(tutor: t),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================
  // TOMBOL PILL PUTIH
  // ==========================
  Widget _pillButton({required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF555555),
          ),
        ),
      ),
    );
  }

  // ==========================
  // BLOB DECORATION
  // ==========================
  Widget _Blob({required Color color, required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(size),
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
