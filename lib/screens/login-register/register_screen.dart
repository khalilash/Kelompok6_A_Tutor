import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // boleh dihapus kalau cuma pakai supabase_client.dart
import '../../supabase_client.dart'; // pastikan file ini berisi: final supabase = Supabase.instance.client;
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;

  // Controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _onCreateAccount() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final phone = _phoneController.text.trim();

    // ✅ validasi field wajib
    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lengkapi semua field bertanda *.')),
      );
      return;
    }

    // ✅ cek konfirmasi password
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Konfirmasi password tidak sama.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // ✅ Insert ke tabel "users"
      await supabase.from('users').insert({
        'username': username,
        'email': email,
        'phone': '+62$phone',
        'password': password, // ⬅️ PENTING: simpan password
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registrasi berhasil! Silakan login.')),
      );

      // pindah ke halaman login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } catch (e) {
      debugPrint('Gagal insert user: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal registrasi: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              "assets/register.png",
              fit: BoxFit.cover,
            ),
          ),

          // CONTENT
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF343446),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // USERNAME
                  const Text("Username*", style: _labelWhite),
                  const SizedBox(height: 6),
                  _buildInputField(
                    controller: _usernameController,
                    hint: "Masukkan username anda",
                  ),

                  const SizedBox(height: 16),

                  // EMAIL
                  const Text("Email*", style: _labelWhite),
                  const SizedBox(height: 6),
                  _buildInputField(
                    controller: _emailController,
                    hint: "Masukkan email anda",
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 16),

                  // PASSWORD
                  const Text("Password*", style: _labelWhite),
                  const SizedBox(height: 6),
                  _buildPasswordField(
                    controller: _passwordController,
                    visible: passwordVisible,
                    onToggle: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  // CONFIRM PASSWORD
                  const Text("Konfirmasi Password*", style: _labelWhite),
                  const SizedBox(height: 6),
                  _buildPasswordField(
                    controller: _confirmPasswordController,
                    visible: confirmPasswordVisible,
                    onToggle: () {
                      setState(() {
                        confirmPasswordVisible = !confirmPasswordVisible;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  // PHONE
                  const Text("Nomor Telepon*", style: _labelWhite),
                  const SizedBox(height: 6),
                  _buildPhoneField(controller: _phoneController),

                  const SizedBox(height: 30),

                  // BUTTON
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
                      onPressed: _isLoading ? null : _onCreateAccount,
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
                              "Create Account",
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
                        "Already have an account? ",
                        style: TextStyle(color: Color(0xFF343446)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.blue,
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
        ],
      ),
    );
  }

  // ----------------- WIDGET HELPER -----------------

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: _box,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: Color(0xFF343446)),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF343446)),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
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

  Widget _buildPhoneField({required TextEditingController controller}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: _box,
      child: Row(
        children: [
          const Text(
            "+62",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF343446),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Color(0xFF343446)),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "87xxxxxxxxxx",
                hintStyle: TextStyle(color: Color(0xFF343446)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------
// STYLE
// ------------------------------------------------------

const TextStyle _labelWhite = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: Color(0xFF343446),
);

final BoxDecoration _box = BoxDecoration(
  borderRadius: BorderRadius.circular(8),
  border: Border.all(color: const Color(0xFF343446)),
);
