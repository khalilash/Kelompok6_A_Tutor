import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../widgets/bottom_navbar.dart';
import '../login-register/login_screen.dart';
import '../../supabase_client.dart'; // pastikan path benar

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const primary = Color(0xFF9FB4FF);
  static const textDark = Color(0xFF323232);

  bool _isLoading = false;
  bool _isSaving = false;
  bool _isDeleting = false;

  String _username = '';
  String _email = '';
  String _phone = '';

  // controller untuk dialog edit
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  // READ: ambil data user berdasarkan currentUserId
  Future<void> _loadProfile() async {
    if (currentUserId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User belum login (currentUserId null).')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final data = await supabase
          .from('users')
          .select()
          // currentUserId sudah dipastikan tidak null di atas,
          // jadi aman pakai !
          .eq('id', currentUserId!)
          .maybeSingle();

      if (data != null) {
        _username = (data['username'] as String?) ?? '';
        _email = (data['email'] as String?) ?? '';
        _phone = (data['phone'] as String?) ?? '';

        _nameCtrl.text = _username;
        _phoneCtrl.text = _phone;
      }

      if (mounted) setState(() {});
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat profil: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // UPDATE: simpan perubahan username & phone
  Future<void> _saveProfile() async {
    final newName = _nameCtrl.text.trim();
    final newPhone = _phoneCtrl.text.trim();

    if (newName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username tidak boleh kosong')),
      );
      return;
    }
    if (currentUserId == null) return;

    setState(() => _isSaving = true);
    try {
      await supabase.from('users').update({
        'username': newName,
        'phone': newPhone,
      })
      // di sini juga pakai ! karena sudah dicek null di atas
      .eq('id', currentUserId!);

      // update state lokal agar header ikut berubah
      _username = newName;
      _phone = newPhone;

      if (!mounted) return;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil berhasil diperbarui')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal update profil: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  // DELETE: hapus akun
  Future<void> _deleteAccount() async {
    if (currentUserId == null) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus Akun'),
        content: const Text(
          'Apakah kamu yakin ingin menghapus akun ini? Data tidak bisa dikembalikan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Hapus',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => _isDeleting = true);
    try {
      await supabase
          .from('users')
          .delete()
          // lagi-lagi pakai ! karena sudah dicek null
          .eq('id', currentUserId!);

      currentUserId = null;

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Akun berhasil dihapus')),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus akun: $e')),
      );
    } finally {
      if (mounted) setState(() => _isDeleting = false);
    }
  }

  // buka dialog edit personal data
  Future<void> _openEditDialog() async {
    _nameCtrl.text = _username;
    _phoneCtrl.text = _phone;

    await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Edit Personal Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _phoneCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(ctx);
                await _saveProfile();
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
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
                                    AssetImage('assets/profile.jpg'),
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

                      Text(
                        _username.isEmpty ? 'User' : _username,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: textDark,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        _email.isEmpty ? '-' : _email,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
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
                            padding:
                                const EdgeInsets.fromLTRB(24, 24, 24, 80),
                            children: [
                              _ProfileMenuItem(
                                icon: Icons.person_outline_rounded,
                                label: 'Personal Data',
                                onTap: _openEditDialog, // <-- UPDATE
                              ),
                              const _DividerLine(),
                              const _ProfileMenuItem(
                                icon: Icons.favorite_border_rounded,
                                label: 'Your Favorites',
                              ),
                              const _DividerLine(),
                              const _ProfileMenuItem(
                                icon: Icons.notifications_none_rounded,
                                label: 'Notification',
                              ),
                              const _DividerLine(),
                              const _ProfileMenuItem(
                                icon: Icons.settings_outlined,
                                label: 'Settings',
                              ),
                              const _DividerLine(),
                              const _ProfileMenuItem(
                                icon: Icons.warning_amber_outlined,
                                label: 'Laporan',
                              ),
                              const _DividerLine(),
                              const _ProfileMenuItem(
                                icon: Icons.handshake_outlined,
                                label: 'Jadi Mitra Kami',
                              ),

                              const SizedBox(height: 20),

                              // tombol hapus akun
                              SizedBox(
                                width: double.infinity,
                                height: 44,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Colors.red),
                                  ),
                                  onPressed:
                                      _isDeleting ? null : _deleteAccount,
                                  child: _isDeleting
                                      ? const SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.red,
                                          ),
                                        )
                                      : const Text(
                                          'Hapus Akun',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ),
                              ),

                              const SizedBox(height: 16),

                              const _LogoutItem(),
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

// ---------------- WIDGET KECIL ----------------

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF9FB4FF);

    return InkWell(
      onTap: onTap,
      child: Padding(
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

                    // optional: clear currentUserId juga
                    currentUserId = null;

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
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
