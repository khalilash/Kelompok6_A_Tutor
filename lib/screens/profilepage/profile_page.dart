import 'package:flutter/material.dart';
import '../widgets/bottom_navbar.dart';
import '../login-register/login_screen.dart'; // <-- PATH LOGIN KAMU

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF9FB4FF);
    const textDark = Color(0xFF323232);

    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: TutorBottomNavBar(
        currentIndex: 2,
        onTap: (i) {},
      ),

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
                const SizedBox(height: 20),

                const Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: textDark,
                  ),
                ),

                const SizedBox(height: 24),

                // FOTO PROFIL
                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 56,
                          backgroundImage:
                              AssetImage('assets/profile/sasha.png'),
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  'Sasha',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: textDark,
                  ),
                ),

                const SizedBox(height: 4),

                const Text(
                  'Sahahahahahaha@gmail.com',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),

                const SizedBox(height: 24),

                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 80),
                      children: const [
                        _ProfileMenuItem(
                          icon: Icons.person_outline_rounded,
                          label: 'Personal Data',
                        ),
                        _DividerLine(),
                        _ProfileMenuItem(
                          icon: Icons.favorite_border_rounded,
                          label: 'Your Favorites',
                        ),
                        _DividerLine(),
                        _ProfileMenuItem(
                          icon: Icons.notifications_none_rounded,
                          label: 'Notification',
                        ),
                        _DividerLine(),
                        _ProfileMenuItem(
                          icon: Icons.settings_outlined,
                          label: 'Settings',
                        ),
                        _DividerLine(),
                        _ProfileMenuItem(
                          icon: Icons.warning_amber_outlined,
                          label: 'Laporan',
                        ),
                        _DividerLine(),
                        _ProfileMenuItem(
                          icon: Icons.handshake_outlined,
                          label: 'Jadi Mitra Kami',
                        ),

                        SizedBox(height: 20),

                        _LogoutItem(),
                      ],
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

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ProfileMenuItem({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF9FB4FF);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: accent),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: accent),
        ],
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  const _DividerLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: const Color(0xFFE0E3FF),
    );
  }
}

class _LogoutItem extends StatelessWidget {
  const _LogoutItem();

  @override
  Widget build(BuildContext context) {
    const logoutColor = Color(0xFFFF6B81);

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Text("Logout"),
              content: const Text("Apakah kamu yakin ingin logout?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Batal"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    "Logout",
                    style: TextStyle(color: logoutColor),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Row(
        children: const [
          Icon(Icons.logout_rounded, color: logoutColor),
          SizedBox(width: 16),
          Text(
            'Logout',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: logoutColor,
            ),
          ),
        ],
      ),
    );
  }
}
