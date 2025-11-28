import 'package:flutter/material.dart';

class TutorBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const TutorBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [

          // BACKGROUND PUTIH BAWAH
          Container(
            height: 44,
            color: Colors.white,
          ),

          // NAVBAR PILL
          Positioned(
            bottom: 12,
            left: 20,
            right: 20,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFBFC9FF),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 46),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _navIcon(Icons.home_rounded, 0),
                  _navIcon(Icons.chat_bubble_rounded, 1),
                  _navIcon(Icons.person_rounded, 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navIcon(IconData icon, int index) {
    final bool isActive = index == currentIndex;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic, // GERAKAN LEMBUT
        transform: isActive
            ? (Matrix4.identity()..translate(0.0, -10.0))
            : Matrix4.identity(),
        padding: const EdgeInsets.all(10),
        decoration: isActive
            ? const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              )
            : null,
        child: Icon(
          icon,
          size: 30, // ICON LEBIH BESAR
          color: isActive
              ? const Color(0xFF6A6FE9)
              : Colors.white70,
        ),
      ),
    );
  }
}
