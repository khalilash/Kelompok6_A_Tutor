import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../homepage/homepage.dart';
import '../chat/chat_room_screen.dart'; 
import '../../supabase_client.dart'; // penting untuk currentUserId & supabase
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

  // =========================
  // DATA TUTOR
  // =========================
  List<Tutor> get tutors => [
        Tutor(
          name: "Khalila",
          subject: "Dasar Pemrograman",
          rating: "4.9",
          image: "assets/khalila.jpg",
          price: 50000,
          cardColor: const Color(0xFFFFA975),
          blobColor: const Color(0xFFD65609),
        ),
        Tutor(
          name: "Juno",
          subject: "Pemrograman Web",
          rating: "4.9",
          image: "assets/juno.jpg",
          price: 50000,
          cardColor: const Color(0xFFFEB8C3),
          blobColor: const Color(0xFFFF687F),
        ),
        Tutor(
          name: "Naura",
          subject: "Teknologi Berkembang",
          rating: "4.9",
          image: "assets/naura.jpg",
          price: 50000,
          cardColor: const Color(0xFFBCC6F6),
          blobColor: const Color(0xFF566CD8),
        ),
        Tutor(
          name: "Nabila",
          subject: "Desain Pengalaman Pengguna",
          rating: "4.9",
          image: "assets/nabila.png",
          price: 50000,
          cardColor: const Color(0xFFFFA975),
          blobColor: const Color(0xFFD65609),
        ),
        Tutor(
          name: "Jasmine",
          subject: "Sistem Enterprise",
          rating: "4.9",
          image: "assets/mine.png",
          price: 50000,
          cardColor: const Color(0xFFFEB8C3),
          blobColor: const Color(0xFFFF687F),
        ),
        Tutor(
          name: "Sahilah",
          subject: "Pemrograman Web",
          rating: "4.9",
          image: "assets/sahilah.png",
          price: 50000,
          cardColor: const Color(0xFFBCC6F6),
          blobColor: const Color(0xFF566CD8),
        ),
      ];

  // ============================
  // 🔥 CEK / BUAT THREAD CHAT
  // ============================
  Future<String> getOrCreateThread(String tutorName) async {
    if (currentUserId == null) {
      throw Exception("User belum login");
    }

    // cari tutor user account
    final tutorUser = await supabase
        .from('users')
        .select('id')
        .eq('username', tutorName)
        .maybeSingle();

    if (tutorUser == null) {
      throw Exception("Tutor tidak ditemukan di tabel users");
    }

    final tutorId = tutorUser['id'];

    // cek apakah thread sudah ada
    final existingThread = await supabase
        .from('threads')
        .select()
        .eq('student_id', currentUserId ?? "")
        .eq('tutor_id', tutorId ?? "")
        .maybeSingle();


    if (existingThread != null) {
      return existingThread['id'];
    }

    // jika belum ada → buat thread baru
    final newThread = await supabase
        .from('threads')
        .insert({
          'student_id': currentUserId,
          'tutor_id': tutorId,
          'last_message': '',
          'last_message_time': DateTime.now().toIso8601String(),
        })
        .select()
        .single();

    return newThread['id'];
  }

  // ============================
  // UI
  // ============================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _background(),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 12),

              // HEADER
              Row(
                children: [
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
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

              // CONTENT
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
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

  // ============================
  // CARD TUTOR
  // ============================
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

            // BLOBS
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

            // CONTENT
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // FOTO
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

                  // INFO + BUTTON
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
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),

                            const Spacer(),

                            // ============================
                            // 🔥 CHAT BUTTON
                            // ============================
                            _pillButton(
                              label: "Chat",
                              onTap: () async {
                                try {
                                  final threadId =
                                      await getOrCreateThread(t.name);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ChatRoomScreen(
                                        tutorName: t.name,
                                        threadId: threadId,
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Gagal membuka chat: $e")),
                                  );
                                }
                              },
                            ),

                            const SizedBox(width: 8),

                            // PESAN SESI
                            _pillButton(
                              label: "Pesan Sesi",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SelectDateScreen(tutor: t),
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

  // ============================
  // TOMBOL PUTIH
  // ============================
  Widget _pillButton({required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  // ============================
  // BLOB
  // ============================
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

  // ============================
  // BACKGROUND GRADIENT
  // ============================
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
