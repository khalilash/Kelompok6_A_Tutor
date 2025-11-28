import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {

    final categories = [
      CategoryData(
        title: 'Sistem\nBasis Data',
        tutorCount: 18,
        dark: const Color(0xFFD65609),
        light: const Color(0xFFFFA975),
        textColor: const Color(0xFFD65609),
        icon: Icons.storage_rounded,
      ),
      CategoryData(
        title: 'Data\nLakehouse',
        tutorCount: 18,
        dark: const Color(0xFF566CD8),
        light: const Color(0xFFBCC6F6),
        textColor: const Color(0xFF566CD8),
        icon: Icons.grid_view_rounded,
      ),
      CategoryData(
        title: 'Pemrograman\nDasar',
        tutorCount: 18,
        dark: const Color(0xFFFFACB9),
        light: const Color(0xFFFEB8C3),
        textColor: const Color(0xFFFF687F),
        icon: Icons.code_rounded,
      ),
      CategoryData(
        title: 'Matematika',
        tutorCount: 18,
        dark: const Color(0xFFD65609),
        light: const Color(0xFFFFA975),
        textColor: const Color(0xFFD65609),
        icon: Icons.calculate_rounded,
      ),
      CategoryData(
        title: 'Etika TI',
        tutorCount: 18,
        dark: const Color(0xFF566CD8),
        light: const Color(0xFFBCC6F6),
        textColor: const Color(0xFF566CD8),
        icon: Icons.lightbulb_outline,
      ),
      CategoryData(
        title: 'Pemrograman\nWeb',
        tutorCount: 18,
        dark: const Color(0xFFFFACB9),
        light: const Color(0xFFFEB8C3),
        textColor: const Color(0xFFFF687F),
        icon: Icons.web_rounded,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background tutor.png',
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const _Header(),
                const SizedBox(height: 16),
                const _SearchBar(),
                const SizedBox(height: 20),

                // BAGIAN PUTIH SAMPAI BAWAH
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.78,
                          ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return CategoryCard(data: categories[index]);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: const Color(0xFF2D2140),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Pencarian',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2D2140),
                ),
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Cari Tutor dan Kategori',
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 14,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: InputBorder.none,
            suffixIcon: const Icon(Icons.search_rounded),
          ),
        ),
      ),
    );
  }
}


/// =============================
///        DATA & CARD UI
/// =============================
class CategoryData {
  final String title;
  final int tutorCount;
  final Color dark;
  final Color light;
  final Color textColor;
  final IconData icon;

  CategoryData({
    required this.title,
    required this.tutorCount,
    required this.dark,
    required this.light,
    required this.textColor,
    required this.icon,
  });
}

class CategoryCard extends StatelessWidget {
  final CategoryData data;

  const CategoryCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: PuzzleClipper(),
      child: Container(
        decoration: BoxDecoration(
          color: data.light,
        ),
        child: Stack(
          children: [

            Positioned(
              top: -20,
              left: -10,
              child: _Blob(color: Colors.white.withOpacity(0.20), size: 70),
            ),
            Positioned(
              top: 30,
              right: -30,
              child: _Blob(color: Colors.white.withOpacity(0.18), size: 90),
            ),
            Positioned(
              bottom: -20,
              left: 10,
              child: _Blob(color: Colors.white.withOpacity(0.12), size: 80),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _IconBadge(
                    icon: data.icon,
                    bg: Colors.white.withOpacity(0.9),
                    iconColor: data.textColor,
                  ),

                  const SizedBox(height: 16),

                  Text(
                    data.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: data.textColor,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    '${data.tutorCount} Tutor',
                    style: TextStyle(
                      fontSize: 11,
                      color: data.textColor.withOpacity(0.75),
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
}

class _IconBadge extends StatelessWidget {
  final IconData icon;
  final Color bg;
  final Color iconColor;

  const _IconBadge({
    required this.icon,
    required this.bg,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 18, color: iconColor),
    );
  }
}

class _Blob extends StatelessWidget {
  final Color color;
  final double size;

  const _Blob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(size),
      ),
    );
  }
}

/// =============================
///        PUZZLE CLIPPER
/// =============================
class PuzzleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const borderRadius = 20.0;
    const notchRadius = 16.0;

    final w = size.width;
    final h = size.height;
    final centerY = h / 2;

    final path = Path();

    path.moveTo(borderRadius, 0);
    path.lineTo(w - borderRadius, 0);
    path.quadraticBezierTo(w, 0, w, borderRadius);

    path.lineTo(w, centerY - notchRadius);
    path.arcToPoint(
      Offset(w, centerY + notchRadius),
      radius: const Radius.circular(notchRadius),
      clockwise: false,
    );

    path.lineTo(w, h - borderRadius);
    path.quadraticBezierTo(w, h, w - borderRadius, h);

    path.lineTo(borderRadius, h);
    path.quadraticBezierTo(0, h, 0, h - borderRadius);

    path.lineTo(0, borderRadius);
    path.quadraticBezierTo(0, 0, borderRadius, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(PuzzleClipper oldClipper) => false;
}
