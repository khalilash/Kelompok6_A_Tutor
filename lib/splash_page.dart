import 'package:flutter/material.dart';
import 'screens/login-register/login_screen.dart';
import 'screens/login-register/register_screen.dart';
import 'screens/login-register/welcome_screen.dart';

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

    Future.delayed(const Duration(milliseconds: 4000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
    });
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
            colors: [AppColors.gradientTop, AppColors.gradientBottom],
          ),
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final t = _controller.value.clamp(0.0, 1.0);

            double rippleOpacity = t >= 0.4 && t <= 0.85 ? 1.0 : 0.0;
            double rippleProgress =
                Curves.easeOutCubic.transform(_segment(t, 0.4, 0.8));

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
                  CustomPaint(
                    size: size,
                    painter: RipplePainter(progress: rippleProgress),
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
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo.png',
            width: 64,
            height: 64,
          ),
          const SizedBox(height: 18),
          const Text(
            'TUTOR',
            style: TextStyle(
              fontFamily: 'Poppins',
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
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RegisterScreen()),
            );
          },
          child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              color: AppColors.buttonBg,
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Center(
              child: Text(
                'Create Account',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an account? ',
              style: TextStyle(
                color: AppColors.white.withOpacity(0.95),
                fontSize: 13,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  fontSize: 13,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ===================== RIPPLE =====================

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

    for (int i = 0; i < 3; i++) {
      final radius = innerRadius + baseRadius * progress * (i + 1);
      strokePaint.color =
          AppColors.rippleRingMain.withOpacity(0.6 - 0.1 * i);
      canvas.drawCircle(center, radius, strokePaint);
    }
  }

  @override
  bool shouldRepaint(RipplePainter oldDelegate) =>
      oldDelegate.progress != progress;
}

// ===================== BACKGROUND DECOR =====================

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

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = baseColor;

    canvas.drawCircle(center, radius, paint);

    if (extraInner) {
      canvas.drawCircle(
        center,
        radius * 0.7,
        paint..color = baseColor.withOpacity(0.6),
      );
    }
  }

  @override
  bool shouldRepaint(CornerCirclePainter oldDelegate) =>
      oldDelegate.baseColor != baseColor || oldDelegate.extraInner != extraInner;
}
