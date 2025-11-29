import 'package:flutter/material.dart';
import 'splash_page.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}



class AppColors {
  static const white = Color(0xFFFFFFFF);
  static const darkText = Color(0xFF343446);
  static const blue1 = Color(0xFF6B9AF1);
  static const blue2 = Color(0xFF749FEC);
  static const blue3 = Color(0xFF83A5E3);
  static const blue4 = Color(0xFFADC1FB);
  static const blue5 = Color(0xFFB8CAFD);
  static const blue6 = Color(0xFFCBD2FE);
  static const greyShadow = Color(0xFFD9D9D9);

  static const gradientTop = blue4;
  static const gradientBottom = blue2;

  static const dotMain = blue6;

  static const rippleFill = blue5;
  static const rippleRingMain = blue3;
  static const rippleRingStrong = blue1;

  static const logoCardBase = blue5;

  static const buttonBg = darkText;
}


double lerpD(double a, double b, double t) => a + (b - a) * t;



class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000), 
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  
  double _segment(double t, double start, double end) {
    if (t <= start) return 0.0;
    if (t >= end) return 1.0;
    return (t - start) / (end - start);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.gradientTop,
              AppColors.gradientBottom,
            ],
          ),
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final t = _controller.value.clamp(0.0, 1.0);

            // ================= FRAME 1: DOT =================
            // 0.00–0.20: dot muncul (scale+fade in)
            // 0.20–0.30: stay
            // 0.30–0.40: fade out
            double dotOpacity;
            if (t <= 0.2) {
              dotOpacity = Curves.easeIn.transform(_segment(t, 0.0, 0.2));
            } else if (t <= 0.3) {
              dotOpacity = 1.0;
            } else if (t <= 0.4) {
              dotOpacity = 1.0 - _segment(t, 0.3, 0.4);
            } else {
              dotOpacity = 0.0;
            }

            double dotScale =
                (t <= 0.2) ? Curves.easeOutBack.transform(_segment(t, 0.0, 0.2)) : 1.0;

            // ================= FRAME 2: TUTOR + DOT =================
            // 0.20–0.35: fade + slide in
            // 0.35–0.50: stay
            // 0.50–0.60: fade out
            double textOpacity;
            if (t < 0.2) {
              textOpacity = 0.0;
            } else if (t <= 0.35) {
              textOpacity = Curves.easeIn.transform(_segment(t, 0.2, 0.35));
            } else if (t <= 0.5) {
              textOpacity = 1.0;
            } else if (t <= 0.6) {
              textOpacity = 1.0 - _segment(t, 0.5, 0.6);
            } else {
              textOpacity = 0.0;
            }

            double textInProgress =
                (t >= 0.2 && t <= 0.35) ? _segment(t, 0.2, 0.35) : 1.0;
            double textDx =
                lerpD(-30.0, 0.0, Curves.easeOut.transform(textInProgress));
            double textDy =
                lerpD(40.0, 0.0, Curves.easeOut.transform(textInProgress));

            // ================= FRAME 3 & 4: RIPPLE =================
            // 0.40–0.60: ripple mulai muncul (frame 3)
            // 0.60–0.80: ripple membesar (frame 4)
            // 0.80–0.85: fade out
            double rippleOpacity;
            if (t < 0.4) {
              rippleOpacity = 0.0;
            } else if (t <= 0.6) {
              rippleOpacity = _segment(t, 0.4, 0.6);
            } else if (t <= 0.8) {
              rippleOpacity = 1.0;
            } else if (t <= 0.85) {
              rippleOpacity = 1.0 - _segment(t, 0.8, 0.85);
            } else {
              rippleOpacity = 0.0;
            }

            double rippleProgress = Curves.easeOutCubic
                .transform(_segment(t, 0.4, 0.8));

            // ================= FRAME 5: FINAL SCREEN =================
            // 0.80–1.00: card + tombol fade + slide up
            double finalProgress = _segment(t, 0.8, 1.0);
            double finalOpacity = Curves.easeIn.transform(finalProgress);
            double finalOffsetY =
                lerpD(40.0, 0.0, Curves.easeOut.transform(finalProgress));

            return Stack(
              children: [

                Opacity(
                  opacity: finalOpacity,
                  child: _buildBackgroundDecor(size),
                ),

                if (rippleOpacity > 0)
                  Opacity(
                    opacity: rippleOpacity,
                    child: CustomPaint(
                      size: size,
                      painter: RipplePainter(progress: rippleProgress),
                    ),
                  ),

                Align(
                  alignment: const Alignment(0, 0.5),
                  child: Opacity(
                    opacity: dotOpacity,
                    child: Transform.scale(
                      scale: dotScale,
                      child: _buildMainDot(),
                    ),
                  ),
                ),


                Align(
                  alignment: const Alignment(0, 0.45),
                  child: Opacity(
                    opacity: textOpacity,
                    child: Transform.translate(
                      offset: Offset(textDx, textDy),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'TUTOR',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 4,
                              color: AppColors.white.withOpacity(0.98),
                            ),
                          ),
                          const SizedBox(width: 12),
                          _buildMainDot(radius: 26),
                        ],
                      ),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Opacity(
                    opacity: finalOpacity,
                    child: Transform.translate(
                      offset: Offset(0, finalOffsetY),
                      child: _buildLogoCard(),
                    ),
                  ),
                ),

                Align(
                  alignment: const Alignment(0, 0.75),
                  child: Opacity(
                    opacity: finalOpacity,
                    child: Transform.translate(
                      offset: Offset(0, finalOffsetY),
                      child: _buildBottomSection(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildMainDot({double radius = 28}) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.dotMain,
      ),
    );
  }

  Widget _buildBackgroundDecor(Size size) {
    return Stack(
      children: [
        Positioned(
          top: -size.width * 0.6,
          left: -size.width * 0.3,
          child: SizedBox(
            width: size.width * 1.2,
            height: size.width * 1.2,
            child: CustomPaint(
              painter: CornerCirclePainter(
                baseColor: AppColors.blue6.withOpacity(0.5),
                extraInner: true,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -size.width * 0.6,
          right: -size.width * 0.2,
          child: SizedBox(
            width: size.width * 1.2,
            height: size.width * 1.2,
            child: CustomPaint(
              painter: CornerCirclePainter(
                baseColor: AppColors.blue3.withOpacity(0.7),
                extraInner: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoCard() {
    return Container(
      width: 190,
      height: 220,
      decoration: BoxDecoration(
        color: AppColors.logoCardBase.withOpacity(0.35),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: AppColors.logoCardBase.withOpacity(0.7),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 10),
            color: AppColors.greyShadow.withOpacity(0.7),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Image.asset(
            'assets/logo.png', 
            width: 64,
            height: 64,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 18),
          const Text(
            'TUTOR',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: 4,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.buttonBg,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                offset: const Offset(0, 6),
                color: AppColors.greyShadow.withOpacity(0.7),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'Create Account',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: AppColors.white.withOpacity(0.95),
              fontSize: 13,
            ),
            children: const [
              TextSpan(text: 'Already have an account? '
              style: const TextStyle(
    fontFamily: 'Poppins',    
  ),
  ),
              TextSpan(
                text: 'Login',
                style: TextStyle(
                   fontFamily: 'Poppins', 
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}



class RipplePainter extends CustomPainter {
  final double progress; 

  RipplePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.55);
    final baseRadius = size.width * 0.18;

    final fillPaint = Paint()..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;


    final innerRadius = baseRadius * (0.8 + 0.5 * progress);
    fillPaint.color = AppColors.rippleFill.withOpacity(0.95);
    canvas.drawCircle(center, innerRadius, fillPaint);

    const ringCount = 3;
    for (int i = 0; i < ringCount; i++) {
      final t = (i + 1) / ringCount;
      final radius = innerRadius + baseRadius * 1.4 * progress * t;

      Color c;
      if (i == 0) {
        c = AppColors.rippleRingMain;
      } else if (i == 1) {
        c = AppColors.rippleRingStrong;
      } else {
        c = AppColors.rippleRingMain.withOpacity(0.6);
      }

      strokePaint.color = c.withOpacity(0.7 - 0.15 * i);
      canvas.drawCircle(center, radius, strokePaint);
    }


    final outerRadius = innerRadius + baseRadius * 2.3 * progress;
    strokePaint
      ..color = AppColors.white.withOpacity(0.95)
      ..strokeWidth = 1.3;
    canvas.drawCircle(center, outerRadius, strokePaint);
  }

  @override
  bool shouldRepaint(covariant RipplePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}


class CornerCirclePainter extends CustomPainter {
  final Color baseColor;
  final bool extraInner;

  CornerCirclePainter({
    required this.baseColor,
    this.extraInner = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.5;

    final paintStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = baseColor;

    canvas.drawCircle(center, radius, paintStroke);

    if (extraInner) {
      canvas.drawCircle(
        center,
        radius * 0.7,
        paintStroke..color = baseColor.withOpacity(0.7),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CornerCirclePainter oldDelegate) {
    return oldDelegate.baseColor != baseColor ||
        oldDelegate.extraInner != extraInner;
  }
}

