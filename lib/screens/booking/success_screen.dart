import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tutor_list_screen.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen>
    with TickerProviderStateMixin {
  late AnimationController _circleCtrl;
  late AnimationController _checkCtrl;
  late AnimationController _fadeCtrl;

  late Animation<double> _circleScale;
  late Animation<double> _checkScale;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();

    // Circle pops in
    _circleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _circleScale =
        CurvedAnimation(parent: _circleCtrl, curve: Curves.easeOutBack);

    // Checkmark bounce
    _checkCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _checkScale =
        CurvedAnimation(parent: _checkCtrl, curve: Curves.elasticOut);

    // Text + button fade-in
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeIn =
        CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn);

    // Start animations with delay
    _circleCtrl.forward().then((_) {
      _checkCtrl.forward().then((_) {
        _fadeCtrl.forward();
      });
    });
  }

  @override
  void dispose() {
    _circleCtrl.dispose();
    _checkCtrl.dispose();
    _fadeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _bg(),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.symmetric(horizontal: 32),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(26),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // CIRCLE ANIMATION
                ScaleTransition(
                  scale: _circleScale,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: ScaleTransition(
                      scale: _checkScale,
                      child: const Icon(
                        Icons.check_rounded,
                        size: 60,
                        color: Color(0xFF46C48A),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // FADE IN TEXT
                FadeTransition(
                  opacity: _fadeIn,
                  child: Text(
                    "Sesi berhasil dipesan!",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E2340),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // FADE IN BUTTO
                FadeTransition(
                  opacity: _fadeIn,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const TutorListScreen()),
                          (route) => false,
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
                        "Selesai",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _bg() => const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFB9D7FF), Color(0xFF6FA8FF)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      );
}
