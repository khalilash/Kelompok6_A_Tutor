import 'package:flutter/material.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = false;

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
              const SizedBox(height: 20),
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D1D1D),
                ),
              ),

              const SizedBox(height: 30),

              const Text("Username*", style: _label),
              const SizedBox(height: 6),
              _inputField(hint: "Masukkan username anda"),

              const SizedBox(height: 16),

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

              const SizedBox(height: 6),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text("Forgot password?"),
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
                  onPressed: () {},
                  child: const Text(
                    "Log in",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account yet? "),
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

final BoxDecoration _box = BoxDecoration(
  borderRadius: BorderRadius.circular(8),
  border: Border.all(color: Colors.grey.shade400),
);
