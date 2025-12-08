import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'success_screen.dart';
import 'tutor_list_screen.dart';

class OrderDetailScreen extends StatelessWidget {
  final Tutor tutor;
  final DateTime date;
  final String timeSlot;

  const OrderDetailScreen({
    super.key,
    required this.tutor,
    required this.date,
    required this.timeSlot,
  });

  String get formattedDate =>
      "${date.day} Agustus ${date.year}, $timeSlot";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _bg(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // ==========================
              // HEADER
              // ==========================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back,
                          color: Colors.white, size: 26),
                    ),
                    const Spacer(),
                    Text(
                      "Detail Pesanan",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 26),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ==========================
              // WHITE CONTENT PANEL
              // ==========================
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: _whiteTop(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ==========================
                      // TITLE
                      // ==========================
                      Text(
                        "Detail",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // ==========================
                      // TUTOR CARD (SOLID + BLOB)
                      // ==========================
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: tutor.cardColor,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Stack(
                          children: [
                            // BLOB DEKORASI
                            Positioned(
                              right: -20,
                              bottom: -10,
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: tutor.blobColor.withOpacity(0.25),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // FOTO TUTOR
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: Image.asset(
                                      tutor.image,
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 12),

                                // TEXT INFO
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tutor.name,
                                        style: GoogleFonts.poppins(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        tutor.subject,
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
                                            tutor.rating,
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Rp${tutor.price}",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF343446),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // BUTTON "PESAN"
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 7),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.85),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Text(
                                    "Pesan",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // ==========================
                      // PEMBAYARAN
                      // ==========================
                      Text("Pembayaran",
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 12),

                      _payRow("Harga Pokok", "Rp${tutor.price}"),
                      _payRow("Biaya Admin", "Rp0"),
                      _payRow("Promo", "Rp0"),

                      const Divider(height: 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total",
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Text("Rp${tutor.price}",
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),

                      const Spacer(),

                      // ==========================
                      // BUTTON PESAN SEKARANG
                      // ==========================
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SuccessScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E2340),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(
                            "PESAN SEKARANG",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
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
  // ROW PEMBAYARAN
  // ==========================
  Widget _payRow(String left, String right) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(left, style: GoogleFonts.poppins(fontSize: 14)),
          Text(right, style: GoogleFonts.poppins(fontSize: 14)),
        ],
      ),
    );
  }

  // ==========================
  // BACKGROUND
  // ==========================
  BoxDecoration _bg() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFB9D7FF),
          Color(0xFF6FA8FF),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }

  BoxDecoration _whiteTop() {
    return const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
    );
  }
}
