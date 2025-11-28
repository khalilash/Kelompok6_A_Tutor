import 'package:flutter/material.dart';
import '../widgets/bottom_navbar.dart';
import 'dart:async';
import '../widgets/trial_popup.dart';

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

  final PageController _bannerController =
      PageController(initialPage: 1000);
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
    return Scaffold(
      body: Stack(
        children: [
          // BACKGROUND
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.png"),
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
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(40)),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: const SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // ===== KATEGORI =====
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Kategori",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              _LihatSemuaBtn(),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text("Pilih Kategori Bidang yang Kamu Inginkan",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 12)),
                          SizedBox(height: 16),

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              PuzzleItem(
                                title: "Sistem\nBasis Data",
                                count: "18 Tutor",
                                color: Color(0xFFF3C49B),
                                icon: Icons.storage,
                              ),
                              PuzzleItem(
                                title: "Data\nLakehouse",
                                count: "18 Tutor",
                                color: Color(0xFFB9C3F8),
                                icon: Icons.analytics,
                              ),
                              PuzzleItem(
                                title: "Pemrograman\nDasar",
                                count: "18 Tutor",
                                color: Color(0xFFF9B8B8),
                                icon: Icons.code,
                              ),
                            ],
                          ),

                          SizedBox(height: 28),

                          // ===== REKOMENDASI =====
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Rekomendasi Tutor",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              _LihatSemuaBtn(),
                            ],
                          ),
                          SizedBox(height: 6),
                          Text("Cari Tutor Yang Cocok Untukmu",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 12)),
                          SizedBox(height: 16),

                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
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
    return const Padding(
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
          Icon(Icons.search, color: Colors.white),
        ],
      ),
    );
  }

  Widget _banner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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

  Widget _bannerCard(String title, String subtitle, String image) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7C8A1),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD65609),
                  )),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFFD65609),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFD65609),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Cek Sekarang",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Color(0xFFD65609),
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
          )
        ],
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFB8BEF3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text("Lihat Semua",
          style: TextStyle(color: Colors.white, fontSize: 12)),
    );
  }
}

// ================== PUZZLE ITEM ==================
class PuzzleItem extends StatelessWidget {
  final String title, count;
  final Color color;
  final IconData icon;

  const PuzzleItem({
    super.key,
    required this.title,
    required this.count,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: PuzzleClipper(),
      child: Container(
        width: 105,
        height: 135,
        color: color,
        child: Stack(
          children: [
            const Positioned(top: -20, left: -10, child: _Blob(size: 60)),
            const Positioned(bottom: -20, right: -20, child: _Blob(size: 70)),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _IconBadge(icon: icon),
                  const Spacer(),
                  Text(title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(count, style: const TextStyle(fontSize: 11)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ================== PUZZLE CLIPPER ==================
class PuzzleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double borderRadius = 22;
    const double notchRadius = 14;
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
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _Blob extends StatelessWidget {
  final double size;
  const _Blob({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(size),
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  final IconData icon;
  const _IconBadge({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 18),
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
    return SizedBox(
      width: 150,
      height: 260, 
      child: Stack(
        clipBehavior: Clip.none, 
        children: [
          Column(
            children: [
              const SizedBox(height: 55), 
              Expanded(
                child: Container(
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
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(18),
                          ),
                        ),
                      ),

                      // box putih info
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(18),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26, 
                                blurRadius: 8,         
                                offset: Offset(4, 6),  
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween, 
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
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
                                ],
                              ),
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
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),

          // FOTO ORANG
          Positioned(
            top: 13, 
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
