import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'booking/select_date_screen.dart';
import 'chat/chat_room_screen.dart';
import '../../supabase_client.dart';
import 'homepage/homepage.dart';
import 'booking/tutor_list_screen.dart';

// =========================
// TUTOR BY CATEGORY SCREEN
// =========================
class TutorByCategoryScreen extends StatelessWidget {
  final String categoryName;

  const TutorByCategoryScreen({
    super.key,
    required this.categoryName,
  });

  // 🔥 LIST TUTOR (TETAP SAMA)
  List<Tutor> get tutors => [
        Tutor(
          name: "Khalila",
          subject: categoryName,
          rating: "4.9",
          image: "assets/khalila.jpg",
          price: 50000,
          cardColor: const Color(0xFFFFA975),
          blobColor: const Color(0xFFD65609),
        ),
        Tutor(
          name: "Juno",
          subject: categoryName,
          rating: "4.9",
          image: "assets/juno.jpg",
          price: 50000,
          cardColor: const Color(0xFFFEB8C3),
          blobColor: const Color(0xFFFF687F),
        ),
        Tutor(
          name: "Naura",
          subject: categoryName,
          rating: "4.9",
          image: "assets/naura.jpg",
          price: 50000,
          cardColor: const Color(0xFFBCC6F6),
          blobColor: const Color(0xFF566CD8),
        ),
        Tutor(
          name: "Nabila",
          subject: categoryName,
          rating: "4.9",
          image: "assets/nabila.png",
          price: 50000,
          cardColor: const Color(0xFFFFA975),
          blobColor: const Color(0xFFD65609),
        ),
        Tutor(
          name: "Jasmine",
          subject: categoryName,
          rating: "4.9",
          image: "assets/mine.png",
          price: 50000,
          cardColor: const Color(0xFFFEB8C3),
          blobColor: const Color(0xFFFF687F),
        ),
        Tutor(
          name: "Sahilah",
          subject: categoryName,
          rating: "4.9",
          image: "assets/sahilah.png",
          price: 50000,
          cardColor: const Color(0xFFBCC6F6),
          blobColor: const Color(0xFF566CD8),
        ),
      ];

  // =========================
  // UI
  // =========================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _background(),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 12),

              // =========================
              // HEADER (KATEGORI DINAMIS)
              // =========================
              Row(
                children: [
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        categoryName,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),

              const SizedBox(height: 12),

              // =========================
              // LIST TUTOR
              // =========================
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
                    itemBuilder: (context, i) =>
                        _buildTutorCard(context, tutors[i]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // TUTOR CARD (SAMA)
  // =========================
  Widget _buildTutorCard(BuildContext context, Tutor t) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: t.cardColor,
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
            ),
            Positioned(
              top: -30,
              left: -30,
              child: _Blob(color: Colors.white.withOpacity(0.22), size: 130),
            ),
            Positioned(
              top: 20,
              right: -45,
              child: _Blob(color: t.blobColor.withOpacity(0.25), size: 145),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 72,
                    height: 82,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(t.image, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 14),
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
                            color: t.blobColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              "Rp${t.price}",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
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
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pillButton({required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(fontSize: 12),
        ),
      ),
    );
  }

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
