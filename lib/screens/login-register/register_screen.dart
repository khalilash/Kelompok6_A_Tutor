import 'package:flutter/material.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ----------------------------
          // BACKGROUND IMAGE
          // ----------------------------
          Positioned.fill(
            child: Image.asset(
              "assets/register.png",  // GANTI SESUAI FILE KAMU
              fit: BoxFit.cover,
            ),
          ),

          // // OPTIONAL: kasih layer gelap biar teks jelas
          // Positioned.fill(
          //   child: Container(
          //     color: Colors.black.withOpacity(0.35),
          //   ),
          // ),

          // ----------------------------
          // CONTENT
          // ----------------------------
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
                  _inputField(hint: "Masukkan username anda"),

                  const SizedBox(height: 16),

                  // EMAIL
                  const Text("Email*", style: _labelWhite),
                  const SizedBox(height: 6),
                  _inputField(hint: "Masukkan email anda"),

                  const SizedBox(height: 16),

                  // PASSWORD
                  const Text("Password*", style: _labelWhite),
                  const SizedBox(height: 6),
                  _passwordField(
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
                  _passwordField(
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
                  _phoneField(),

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
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Create Account",
                        style: TextStyle(fontSize: 16, color: Colors.white),
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
                              fontWeight: FontWeight.bold),
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
}

// ------------------------------------------------------
// STYLE + INPUT COMPONENTS
// ------------------------------------------------------

const TextStyle _labelWhite = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: Color(0xFF343446),
);

Widget _inputField({required String hint}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14),
    decoration: _box,
    child: TextField(
      style: const TextStyle(color: Color(0xFF343446)),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF343446)),
      ),
    ),
  );
}

Widget _passwordField({required bool visible, required VoidCallback onToggle}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14),
    decoration: _box,
    child: TextField(
      obscureText: !visible,
      style: const TextStyle(color: Color(0xFF343446)),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Masukkan Password anda",
        hintStyle: const TextStyle(color: Color(0xFF343446)),
        suffixIcon: IconButton(
          icon: Icon(
            visible ? Icons.visibility : Icons.visibility_off,
            color: Color(0xFF343446),
          ),
          onPressed: onToggle,
        ),
      ),
    ),
  );
}

Widget _phoneField() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14),
    decoration: _box,
    child: Row(
      children: [
        const Text(
          "+62",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF343446)),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            style: TextStyle(color: Color(0xFF343446)),
            decoration: InputDecoration(
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

final BoxDecoration _box = BoxDecoration(
  borderRadius: BorderRadius.circular(8),
  border: Border.all(color: Color(0xFF343446)),
);
