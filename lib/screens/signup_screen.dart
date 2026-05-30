import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;

  bool isValidEmail(String email) {
    return RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool isValidPassword(String password) {
    return RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$').hasMatch(password);
  }

  Future<void> signup() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

    if (!isValidPassword(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password must contain uppercase, lowercase, number and be at least 6 characters',
          ),
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('user_name', name);
    await prefs.setString('user_email', email);
    await prefs.setString('user_password', password);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Account created successfully')),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),

      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: const Color(0xFF1D4ED8),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          children: [
            const SizedBox(height: 30),

            const CircleAvatar(
              radius: 45,
              backgroundColor: Color(0xFF1D4ED8),
              child: Icon(Icons.person_add, color: Colors.white, size: 50),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                helperText: 'Example: John Smith',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 18),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email Address',
                helperText: 'Example: john@gmail.com',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 18),

            TextField(
              controller: passwordController,
              obscureText: hidePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                helperText:
                    'Example: Password1 (uppercase, lowercase, number, min 6 chars)',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: signup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D4ED8),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
