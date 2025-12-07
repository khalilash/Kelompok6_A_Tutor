import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'select_time_screen.dart';
import 'tutor_list_screen.dart';

class SelectDateScreen extends StatefulWidget {
  final Tutor tutor;

  const SelectDateScreen({super.key, required this.tutor});

  @override
  State<SelectDateScreen> createState() => _SelectDateScreenState();
}

class _SelectDateScreenState extends State<SelectDateScreen> {
  DateTime _focusedDay = DateTime(2025, 8, 1);
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [

            // ================= HEADER =================
            Stack(
              clipBehavior: Clip.none,
              children: [

                // ---------- BACKGROUND IMAGE ----------
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

                // ---------- BACK BUTTON (MINIMALIS) ----------
                Positioned(
                  top: 20,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 26,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TutorListScreen(),
                        ),
                      );
                    },
                  ),
                ),

                // ---------- FLOATING PHOTO ----------
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
                ),
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

                  // ---------- TITLE ----------
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

                      // ONLINE BADGE
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

                  // ---------- TAGS ----------
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

                  // ---------- MONTH TITLE ----------
                  Text(
                    "August, 2025",
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E2340),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ---------- CALENDAR ----------
                  TableCalendar(
                    firstDay: DateTime.utc(2020),
                    lastDay: DateTime.utc(2030),
                    focusedDay: _focusedDay,
                    headerVisible: false,
                    calendarFormat: CalendarFormat.month,

                    selectedDayPredicate: (day) =>
                        isSameDay(_selectedDay, day),

                    onDaySelected: (selected, focused) {
                      setState(() {
                        _selectedDay = selected;
                        _focusedDay = focused;
                      });
                    },

                    calendarStyle: CalendarStyle(
                      defaultTextStyle: GoogleFonts.poppins(),
                      weekendTextStyle: GoogleFonts.poppins(),
                      todayDecoration: const BoxDecoration(
                        color: Color(0xFF8DBDFF),
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: const BoxDecoration(
                        color: Color(0xFF1E2340),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ---------- BUTTON ----------
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _selectedDay == null
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SelectTimeScreen(
                                    tutor: widget.tutor,
                                    date: _selectedDay!,
                                  ),
                                ),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        padding:
                            const EdgeInsets.symmetric(vertical: 16),
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TAG UI
  Widget _tag(String txt) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
