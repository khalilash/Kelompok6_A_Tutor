import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'order_detail_screen.dart';
import 'tutor_list_screen.dart';

class SelectTimeScreen extends StatefulWidget {
  final Tutor tutor;
  final DateTime date;

  const SelectTimeScreen({
    super.key,
    required this.tutor,
    required this.date,
  });

  @override
  State<SelectTimeScreen> createState() => _SelectTimeScreenState();
}

class _SelectTimeScreenState extends State<SelectTimeScreen> {
  String? selectedSlot;

  // ==============================
  //    SLOT DATA + STATUS
  // ==============================
  final List<Map<String, dynamic>> slots = [
    {"time": "10.00–10.50", "available": true},
    {"time": "11.00–11.50", "available": true},
    {"time": "12.00–12.50", "available": true},
    {"time": "13.00–13.50", "available": true},

    {"time": "14.00–14.50", "available": true},
    {"time": "15.00–15.50", "available": true},
    {"time": "16.00–16.50", "available": true},
    {"time": "17.00–17.50", "available": true},

    {"time": "18.00–18.50", "available": true},
    {"time": "19.00–19.50", "available": false}, // merah
    {"time": "20.00–20.50", "available": true},
    {"time": "21.00–21.50", "available": true},

    {"time": "22.00–22.50", "available": true},
    {"time": "23.00–23.50", "available": true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [

            // ================= HEADER STACK (SAMA 100%) =================
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/background_tutor.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: Image.asset(
                        widget.tutor.image,
                        width: 180,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 30),

            // ================= WHITE CARD =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ========== TITLE & BADGE ==========
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tutor.subject,
                              style: GoogleFonts.poppins(
                                fontSize: 21,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1E2340),
                              ),
                            ),
                            Text(
                              widget.tutor.name,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: const Color(0xFF1E2340),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFC8F5D3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "ONLINE",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF389F4D),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // ========== TAGS ==========
                  Row(
                    children: [
                      _tag("IT"),
                      const SizedBox(width: 8),
                      _tag("Business"),
                      const SizedBox(width: 8),
                      _tag("Computer Science"),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // ========== TITLE "PILIH JAM" ==========
                  Text(
                    "Pilih Jam",
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E2340),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // ========== INDIKATOR TERSEDIA / TIDAK ==========
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0E7FF),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text("Tersedia",
                          style: GoogleFonts.poppins(fontSize: 13)),
                      const SizedBox(width: 20),

                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD6D9),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text("Tidak Tersedia",
                          style: GoogleFonts.poppins(fontSize: 13)),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ========== SLOT WRAP ==========
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: slots.map((slot) => _buildSlot(slot)).toList(),
                  ),

                  const SizedBox(height: 40),

                  // ========== BUTTON ==========
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: selectedSlot == null
                              ? null
                              : () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => OrderDetailScreen(
                                        tutor: widget.tutor,
                                        date: widget.date,
                                        timeSlot: selectedSlot!,
                                      ),
                                    ),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: const Color(0xFF2D3246),
                            disabledBackgroundColor: Colors.grey.shade400,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(
                            "KONFIRMASI",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const Positioned(
                        right: -6,
                        bottom: -6,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: Color(0xFF6FA8FF),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ======================== SLOT UI BUILDER ========================
  Widget _buildSlot(Map<String, dynamic> slot) {
    final String time = slot["time"];
    final bool available = slot["available"];
    final bool isSelected = selectedSlot == time;

    Color bgColor;

    if (!available) {
      bgColor = const Color(0xFFFFD6D9); // merah soft
    } else if (isSelected) {
      bgColor = const Color(0xFF1E2340); // dark
    } else {
      bgColor = const Color(0xFFE0E7FF); // biru soft
    }

    return GestureDetector(
      onTap: available
          ? () => setState(() => selectedSlot = time)
          : null, // merah tidak bisa dipilih
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          time,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: !available
                ? const Color(0xFFB52A34)
                : (isSelected ? Colors.white : const Color(0xFF1E2340)),
          ),
        ),
      ),
    );
  }

  // ======================== TAG COMPONENT ========================
  Widget _tag(String txt) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EDFF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        txt,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: const Color(0xFF1E2340),
        ),
      ),
    );
  }
}
