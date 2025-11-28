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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              const SizedBox(height: 20),
              const Text(
                "Register",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D1D1D),
                ),
              ),
              const SizedBox(height: 30),

              // USERNAME
              const Text("Username*", style: _label),
              const SizedBox(height: 6),
              _inputField(hint: "Masukkan username anda"),

              const SizedBox(height: 16),

              // EMAIL
              const Text("Email*", style: _label),
              const SizedBox(height: 6),
              _inputField(hint: "Masukkan email anda"),

              const SizedBox(height: 16),

              // PASSWORD
              const Text("Password*", style: _label),
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
              const Text("Konfirmasi Password*", style: _label),
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
              const Text("Nomor Telepon*", style: _label),
              const SizedBox(height: 6),
              _phoneField(),

              const SizedBox(height: 30),

              // BUTTON CREATE ACCOUNT
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
                  onPressed: () {},
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
                  const Text("Already have an account? "),
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
    );
  }
}

// ------------------------------------------------------
// STYLE + INPUT COMPONENTS
// ------------------------------------------------------

const TextStyle _label =
    TextStyle(fontSize: 14, fontWeight: FontWeight.w600);

Widget _inputField({required String hint}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14),
    decoration: _box,
    child: TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
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
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Masukkan Password anda",
        suffixIcon: IconButton(
          icon: Icon(visible ? Icons.visibility : Icons.visibility_off),
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
        const Text("+62",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "87xxxxxxxxxx",
            ),
          ),
        ),
      ],
    ),
  );
}

final BoxDecoration _box = BoxDecoration(
  borderRadius: BorderRadius.circular(8),
  border: Border.all(color: Colors.grey.shade400),
);
