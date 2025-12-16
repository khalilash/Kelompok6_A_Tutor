import 'package:flutter/material.dart';
import '/screens/tutor_list_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectedTab = 1; // 0: Matematika, 1: IT, 2: Fisika

  // ===== DATA PER TAB =====
  List<CategoryData> get _mathCategories => [
        CategoryData(
          title: 'Kalkulus 1',
          tutorCount: 6,
          dark: const Color(0xFFD65609),
          light: const Color(0xFFFFA975),
          textColor: const Color(0xFFD65609),
          icon: Icons.calculate_rounded,
        ),
        CategoryData(
          title: 'Fisika\nMekanika',
          tutorCount: 6,
          dark: const Color(0xFF566CD8),
          light: const Color(0xFFBCC6F6),
          textColor: const Color(0xFF566CD8),
          icon: Icons.auto_awesome_mosaic_rounded,
        ),
        CategoryData(
          title: 'Logika\nMatematika',
          tutorCount: 6,
          dark: const Color(0xFFFFACB9),
          light: const Color(0xFFFEB8C3),
          textColor: const Color(0xFFFF687F),
          icon: Icons.grid_view_rounded,
        ),
        CategoryData(
          title: 'Geometri\nAnalitik',
          tutorCount: 6,
          dark: const Color(0xFFD65609),
          light: const Color(0xFFFFA975),
          textColor: const Color(0xFFD65609),
          icon: Icons.dashboard_customize_rounded,
        ),
        CategoryData(
          title: 'Metode\nStatistika',
          tutorCount: 6,
          dark: const Color(0xFF566CD8),
          light: const Color(0xFFBCC6F6),
          textColor: const Color(0xFF566CD8),
          icon: Icons.auto_graph_rounded,
        ),
        CategoryData(
          title: 'Kalkulus 2',
          tutorCount: 6,
          dark: const Color(0xFFFFACB9),
          light: const Color(0xFFFEB8C3),
          textColor: const Color(0xFFFF687F),
          icon: Icons.functions_rounded,
        ),
        CategoryData(
          title: 'Riset\nOperasi',
          tutorCount: 6,
          dark: const Color(0xFFD65609),
          light: const Color(0xFFFFA975),
          textColor: const Color(0xFFD65609),
          icon: Icons.ballot_rounded,
        ),
        CategoryData(
          title: 'UX Design',
          tutorCount: 6,
          dark: const Color(0xFF566CD8),
          light: const Color(0xFFBCC6F6),
          textColor: const Color(0xFF566CD8),
          icon: Icons.design_services_rounded,
        ),
        CategoryData(
          title: 'Sistem\nEnterprise',
          tutorCount: 6,
          dark: const Color(0xFFFFACB9),
          light: const Color(0xFFFEB8C3),
          textColor: const Color(0xFFFF687F),
          icon: Icons.apps_rounded,
        ),
        CategoryData(
          title: 'Matematika',
          tutorCount: 6,
          dark: const Color(0xFFD65609),
          light: const Color(0xFFFFA975),
          textColor: const Color(0xFFD65609),
          icon: Icons.calculate_outlined,
        ),
        CategoryData(
          title: 'Etika TI',
          tutorCount: 6,
          dark: const Color(0xFF566CD8),
          light: const Color(0xFFBCC6F6),
          textColor: const Color(0xFF566CD8),
          icon: Icons.lightbulb_outline,
        ),
        CategoryData(
          title: 'Pemrograman\nWeb',
          tutorCount: 6,
          dark: const Color(0xFFFFACB9),
          light: const Color(0xFFFEB8C3),
          textColor: const Color(0xFFFF687F),
          icon: Icons.web_rounded,
        ),
      ];

  List<CategoryData> get _itCategories => [
        CategoryData(
          title: 'Sistem\nBasis Data',
          tutorCount: 6,
          dark: const Color(0xFFD65609),
          light: const Color(0xFFFFA975),
          textColor: const Color(0xFFD65609),
          icon: Icons.storage_rounded,
        ),
        CategoryData(
          title: 'Data\nLakehouse',
          tutorCount: 6,
          dark: const Color(0xFF566CD8),
          light: const Color(0xFFBCC6F6),
          textColor: const Color(0xFF566CD8),
          icon: Icons.cloud_sync_rounded,
        ),
        CategoryData(
          title: 'Pemrograman\nDasar',
          tutorCount: 6,
          dark: const Color(0xFFFFACB9),
          light: const Color(0xFFFEB8C3),
          textColor: const Color(0xFFFF687F),
          icon: Icons.code_rounded,
        ),
        CategoryData(
          title: 'Matematika',
          tutorCount: 6,
          dark: const Color(0xFFD65609),
          light: const Color(0xFFFFA975),
          textColor: const Color(0xFFD65609),
          icon: Icons.calculate_rounded,
        ),
        CategoryData(
          title: 'Etika TI',
          tutorCount: 6,
          dark: const Color(0xFF566CD8),
          light: const Color(0xFFBCC6F6),
          textColor: const Color(0xFF566CD8),
          icon: Icons.lightbulb_outline,
        ),
        CategoryData(
          title: 'Pemrograman\nWeb',
          tutorCount: 6,
          dark: const Color(0xFFFFACB9),
          light: const Color(0xFFFEB8C3),
          textColor: const Color(0xFFFF687F),
          icon: Icons.web_rounded,
        ),
        CategoryData(
          title: 'Riset\nOperasi',
          tutorCount: 6,
          dark: const Color(0xFFD65609),
          light: const Color(0xFFFFA975),
          textColor: const Color(0xFFD65609),
          icon: Icons.analytics_rounded,
        ),
        CategoryData(
          title: 'UX Design',
          tutorCount: 6,
          dark: const Color(0xFF566CD8),
          light: const Color(0xFFBCC6F6),
          textColor: const Color(0xFF566CD8),
          icon: Icons.design_services_rounded,
        ),
        CategoryData(
          title: 'Sistem\nEnterprise',
          tutorCount: 6,
          dark: const Color(0xFFFFACB9),
          light: const Color(0xFFFEB8C3),
          textColor: const Color(0xFFFF687F),
          icon: Icons.business_center_rounded,
        ),
      ];

  List<CategoryData> get _physicsCategories => [
        CategoryData(
          title: 'Geometri\nAnalitik',
          tutorCount: 6,
          dark: const Color(0xFFD65609),
          light: const Color(0xFFFFA975),
          textColor: const Color(0xFFD65609),
          icon: Icons.straighten_rounded,
        ),
        CategoryData(
          title: 'Metode\nStatistika',
          tutorCount: 6,
          dark: const Color(0xFF566CD8),
          light: const Color(0xFFBCC6F6),
          textColor: const Color(0xFF566CD8),
          icon: Icons.show_chart_rounded,
        ),
        CategoryData(
          title: 'Kalkulus 2',
          tutorCount: 6,
          dark: const Color(0xFFFFACB9),
          light: const Color(0xFFFEB8C3),
          textColor: const Color(0xFFFF687F),
          icon: Icons.functions_rounded,
        ),
        CategoryData(
          title: 'Riset\nOperasi',
          tutorCount: 6,
          dark: const Color(0xFFD65609),
          light: const Color(0xFFFFA975),
          textColor: const Color(0xFFD65609),
          icon: Icons.analytics_rounded,
        ),
        CategoryData(
          title: 'UX Design',
          tutorCount: 6,
          dark: const Color(0xFF566CD8),
          light: const Color(0xFFBCC6F6),
          textColor: const Color(0xFF566CD8),
          icon: Icons.design_services_rounded,
        ),
        CategoryData(
          title: 'Sistem\nEnterprise',
          tutorCount: 6,
          dark: const Color(0xFFFFACB9),
          light: const Color(0xFFFEB8C3),
          textColor: const Color(0xFFFF687F),
          icon: Icons.apps_rounded,
        ),
        CategoryData(
          title: 'Matematika',
          tutorCount: 6,
          dark: const Color(0xFFD65609),
          light: const Color(0xFFFFA975),
          textColor: const Color(0xFFD65609),
          icon: Icons.calculate_rounded,
        ),
        CategoryData(
          title: 'Etika TI',
          tutorCount: 6,
          dark: const Color(0xFF566CD8),
          light: const Color(0xFFBCC6F6),
          textColor: const Color(0xFF566CD8),
          icon: Icons.lightbulb_outline,
        ),
        CategoryData(
          title: 'Pemrograman\nWeb',
          tutorCount: 6,
          dark: const Color(0xFFFFACB9),
          light: const Color(0xFFFEB8C3),
          textColor: const Color(0xFFFF687F),
          icon: Icons.web_rounded,
        ),
      ];

  List<CategoryData> get _currentList {
    switch (_selectedTab) {
      case 0:
        return _mathCategories;
      case 1:
        return _itCategories;
      case 2:
        return _physicsCategories;
      default:
        return _itCategories;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                const _KategoriHeader(),
                const SizedBox(height: 12),

                // ===== TAB KATEGORI =====
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      _TabButton(
                        label: 'Matematika',
                        isActive: _selectedTab == 0,
                        onTap: () => setState(() => _selectedTab = 0),
                      ),
                      const SizedBox(width: 8),
                      _TabButton(
                        label: 'IT',
                        isActive: _selectedTab == 1,
                        onTap: () => setState(() => _selectedTab = 1),
                      ),
                      const SizedBox(width: 8),
                      _TabButton(
                        label: 'Fisika',
                        isActive: _selectedTab == 2,
                        onTap: () => setState(() => _selectedTab = 2),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // ===== PANEL PUTIH + GRID =====
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
                        itemCount: _currentList.length,
                        itemBuilder: (context, index) {
                          final category = _currentList[index];

                          return CategoryCard(
                            data: category,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => TutorByCategoryScreen(
                                    categoryName: category.title.replaceAll('\n', ' '),
                                  ),
                                ),
                              );
                            },
                          );
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

// ================= HEADER =================
class _KategoriHeader extends StatelessWidget {
  const _KategoriHeader();

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
                'Kategori',
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

// ================= TAB BUTTON =================
class _TabButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isActive,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : const Color(0xFFB8BEF3),
            borderRadius: BorderRadius.circular(16),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isActive
                  ? const Color(0xFF5C65D6)
                  : Colors.white,
            ),
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
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: ClipPath(
          clipper: PuzzleClipper(),
          child: Container(
            decoration: BoxDecoration(color: data.light),
            child: Stack(
              children: [
                Positioned(
                  top: -20,
                  left: -10,
                  child: _Blob(
                    color: Colors.white.withOpacity(0.20),
                    size: 70,
                  ),
                ),
                Positioned(
                  top: 30,
                  right: -30,
                  child: _Blob(
                    color: Colors.white.withOpacity(0.18),
                    size: 90,
                  ),
                ),
                Positioned(
                  bottom: -20,
                  left: 10,
                  child: _Blob(
                    color: Colors.white.withOpacity(0.12),
                    size: 80,
                  ),
                ),

                // ⬇️ INI YANG SERING KEHAPUS
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
