import 'package:flutter/material.dart';
import '../widgets/bottom_navbar.dart';
import 'dart:async';
import '../widgets/trial_popup.dart';
import '../search/search_page.dart';
import '../booking/tutor_list_screen.dart';
import '../sesi/detail_sesi_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int navIndex = 0;

  void _showTrialPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const TrialPopup(),
    );
  }

  final PageController _bannerController =  PageController(initialPage: 1000, viewportFraction: 0.9);
  int _bannerIndex = 0;
  Timer? _bannerTimer;

  @override
  void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    _showTrialPopup();
  });

  _bannerTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
    if (_bannerController.hasClients) {
      _bannerController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  });
}

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

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
    ];
    return Scaffold(
      body: Stack(
        children: [
          // BACKGROUND
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background_tutor.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                _header(),
                _banner(),
                const SizedBox(height: 16),

                // PANEL PUTIH
                Expanded(
                  child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                        ),
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(bottom: 1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // ===== KATEGORI =====
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("Kategori",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  _LihatSemuaBtn(),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text("Pilih Kategori Bidang yang Kamu Inginkan",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                              const SizedBox(height: 16),

                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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

                              const SizedBox(height: 28),

                              // ===== REKOMENDASI =====
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("Rekomendasi Tutor",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  _LihatSemuaBtn(),
                                ],
                              ),
                              const SizedBox(height: 6),
                              const Text("Cari Tutor Yang Cocok Untukmu",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                              const SizedBox(height: 0.1),

                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: const [
                                    TutorCardFancy(
                                      name: "Khalila",
                                      role: "DMJK",
                                      price: "Rp50.000 / Sesi",
                                      image: "assets/tutor1_naura.png",
                                      bgColor: Color(0xFFF6C49A),
                                    ),
                                    SizedBox(width: 14),
                                    TutorCardFancy(
                                      name: "Naura",
                                      role: "Tekber",
                                      price: "Rp50.000 / Sesi",
                                      image: "assets/tutor2_naura.png",
                                      bgColor: Color(0xFFF2B6C0),
                                    ),
                                    SizedBox(width: 14),
                                    TutorCardFancy(
                                      name: "Juno",
                                      role: "PPPL",
                                      price: "Rp1.000 / Sesi",
                                      image: "assets/tutor3.png",
                                      bgColor: Color(0xFFBCC6F6),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      
                    
                  ),
                )
              ],
            ),
          )
        ],
      ),

      // bottomNavigationBar: TutorBottomNavBar(
      //   currentIndex: navIndex,
      //   onTap: (index) {
      //     setState(() => navIndex = index);

      //     if (index == 1) {
      //       Navigator.pushNamed(context, '/chat');
      //     } else if (index == 2) {
      //       Navigator.pushNamed(context, '/profile');
      //     }
      //   },
      // ),
      bottomNavigationBar: TutorBottomNavBar(
        currentIndex: navIndex,
        onTap: (i) => setState(() => navIndex = i),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage("assets/profile.jpg"),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hello,", style: TextStyle(color: Colors.white70)),
                  Text("Sasha",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SearchPage(),
                ),
              );
            },
            child: const Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _banner() {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Column(
        children: [
          SizedBox(
            height: 140,
            child: PageView.builder(
              controller: _bannerController,
              onPageChanged: (i) => setState(() => _bannerIndex = i % 3),
              itemBuilder: (_, i) {
                final index = i % 3;

                return _bannerCard(
                  index == 0
                      ? "Tutor Tidak Cocok?"
                      : index == 1
                          ? "Cari Tutor Terbaik"
                          : "Belajar Jadi Mudah",
                  index == 0
                      ? "Lakukan Refund!"
                      : index == 1
                          ? "Mulai Sekarang!"
                          : "Cek Tutor Favoritmu",
                  index == 0
                      ? "assets/tutor1_naura.png"
                      : index == 1
                          ? "assets/tutor2_naura.png"
                          : "assets/tutor3.png",

                  // ===== WARNA GSM TUTOR =====
                  index == 0
                      ? const Color(0xFFFFA975) // OREN MUDA
                      : index == 1
                          ? const Color(0xFFFEB8C3) // PINK MUDA
                          : const Color(0xFFBCC6F6), // UNGU MUDA

                  index == 0
                      ? const Color(0xFFD65609) // OREN TUA (BLOB)
                      : index == 1
                          ? const Color(0xFFFFACB9) // PINK TUA (BLOB)
                          : const Color(0xFF566CD8), // UNGU TUA (BLOB)

                  index == 2
                      ? const Color(0xFF566CD8)                 // teks putih untuk ungu
                      : const Color(0xFFD65609),     // teks oren untuk lainnya
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          _dots(),
        ],
      ),
    );
  }

  Widget _bannerCard(
    String title,
    String subtitle,
    String image,
    Color bgColor,
    Color blobColor,
    Color textColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Stack(
          fit: StackFit.expand,
          children: [

            // BASE
            Container(color: bgColor),

            // === MOTIF BLOB (STYLE CATEGORY CARD) ===

            // blob kiri atas (putih)
            Positioned(
              top: -40,
              left: -30,
              child: _Blob(color: Colors.white.withOpacity(0.22), size: 180),
            ),

            // blob kanan (warna utama)
            Positioned(
              top: 20,
              right: -60,
              child: _Blob(color: blobColor.withOpacity(0.22), size: 240),
            ),

            // blob bawah kiri (lebih soft)
            Positioned(
              bottom: -40,
              left: 30,
              child: _Blob(color: blobColor.withOpacity(0.14), size: 200),
            ),

            // === KONTEN ===
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: textColor.withOpacity(0.9),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: textColor,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Cek Sekarang",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    image,
                    width: 105,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _bannerIndex == i ? 14 : 6,
          height: 6,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: _bannerIndex == i
                ? const Color(0xFF5C65D6)
                : Colors.white70,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

// ================== BUTTON ==================
class _LihatSemuaBtn extends StatelessWidget {
  const _LihatSemuaBtn();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TutorListScreen(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFB8BEF3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          "Lihat Semua",
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}


// ================== TUTOR CARD MODEL BARU ==================
class TutorCardFancy extends StatelessWidget {
  final String name, role, price, image;
  final Color bgColor;

  const TutorCardFancy({
    super.key,
    required this.name,
    required this.role,
    required this.price,
    required this.image,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(bottom: 20),
      child: Stack(
        clipBehavior: Clip.none, 
        children: [
          Column(
            children: [
              const SizedBox(height: 38), 
              Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 120, 
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(18),
                          ),
                        ),
                      ),

                      // box putih info
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(18),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08), // ✅ lembut
                              blurRadius: 10,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, 
                            children: [
                              Text(
                                name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                fontWeight: FontWeight.bold
                                ),
                              ),
                              
                              const SizedBox(height: 2),
                              
                              Text(
                                role,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),    
                              ),
                              
                              const SizedBox(height: 6),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    price,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  const Row(
                                    children: [
                                      Icon(Icons.star,
                                          size: 14, color: Colors.amber),
                                      SizedBox(width: 4),
                                      Text("4.9",
                                          style:
                                              TextStyle(fontSize: 12)),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                      ),
                    ],
                  ),
                
              )
            ],
          ),

          // FOTO ORANG
          Positioned(
            top: -5, 
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                image,
                height: 175, 
                fit: BoxFit.contain,
                errorBuilder: (context, e, _) =>
                    const Icon(Icons.person, size: 120),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= CATEGORY MODEL =================
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


// ================= CATEGORY CARD =================
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


// ================= ICON BADGE =================
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


// ================= DECORATIVE BLOB =================
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


// ================= PUZZLE CLIPPER =================
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
  bool shouldReclip(_) => false;
}