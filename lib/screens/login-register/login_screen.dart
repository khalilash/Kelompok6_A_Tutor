import 'package:flutter/material.dart';
import '../homepage/homepage.dart';
import '../../supabase_client.dart'; // pastikan path benar
import 'register_screen.dart'; // karena masih 1 folder: login-register


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = false;

  // controller input
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username dan password wajib diisi.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // cari user berdasarkan username
      final data = await supabase
          .from('users')
          .select()
          .eq('username', username)
          .maybeSingle();

      if (data == null) {
        // username tidak ditemukan
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User tidak ditemukan.')),
        );
        return;
      }

      final String? dbPassword = data['password'] as String?;

      if (dbPassword == null || dbPassword != password) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password salah.')),
        );
        return;
      }

      // simpan id user yang login
      currentUserId = data['id'] as String;
      print('CURRENT USER ID: $currentUserId');

      // ✅ username & password benar → masuk ke HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal login: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 220),
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF343446),
                  ),
                ),
                const SizedBox(height: 30),

                // USERNAME
                const Text("Username*", style: _label),
                const SizedBox(height: 6),
                _inputField(
                  hint: "Masukkan username anda",
                  controller: _usernameController,
                ),

                const SizedBox(height: 16),

                // PASSWORD
                const Text("Password*", style: _label),
                const SizedBox(height: 6),
                _passwordField(
                  controller: _passwordController,
                  visible: passwordVisible,
                  onToggle: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),

                const SizedBox(height: 6),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(color: Color(0xFF343446)),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: _isLoading ? null : _onLogin,
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Log in",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white),
                          ),
                  ),
                ),

                const SizedBox(height: 14),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account yet? ",
                      style: TextStyle(color: Color(0xFF343446)),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------- STYLE & HELPER WIDGETS DI BAWAH ----------

const TextStyle _label = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: Color(0xFF343446),
);

final BoxDecoration _box = BoxDecoration(
  borderRadius: BorderRadius.circular(8),
  border: Border.all(color: const Color(0xFF343446)),
);

Widget _inputField({
  required String hint,
  required TextEditingController controller,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14),
    decoration: _box,
    child: TextField(
      controller: controller,
      style: const TextStyle(color: Color(0xFF343446)),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF343446)),
      ),
    ),
  );
}

Widget _passwordField({
  required TextEditingController controller,
  required bool visible,
  required VoidCallback onToggle,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14),
    decoration: _box,
    child: TextField(
      controller: controller,
      obscureText: !visible,
      style: const TextStyle(color: Color(0xFF343446)),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Masukkan Password anda",
        hintStyle: const TextStyle(color: Color(0xFF343446)),
        suffixIcon: IconButton(
          icon: Icon(
            visible ? Icons.visibility : Icons.visibility_off,
            color: const Color(0xFF343446),
          ),
          onPressed: onToggle,
        ),
      ),
    ),
  );
}