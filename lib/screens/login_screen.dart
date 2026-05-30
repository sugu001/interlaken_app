import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_navigation_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hidePassword = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();

    final savedEmail = prefs.getString('user_email');
    final savedPassword = prefs.getString('user_password');

    if (emailController.text.trim() == savedEmail &&
        passwordController.text.trim() == savedPassword) {
      await prefs.setBool('is_logged_in', true);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      );
    } else {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email or password')),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset('assets/images/login_bg.jpg', fit: BoxFit.cover),
          ),

          Container(color: Colors.black.withOpacity(0.35)),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const SizedBox(height: 60),

                  const Text(
                    'InterGuide',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Explore Interlaken beautifully',
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),

                  const SizedBox(height: 90),

                  Container(
                    padding: const EdgeInsets.all(24),

                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),

                      borderRadius: BorderRadius.circular(28),

                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        const Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          'Login to continue',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),

                        const SizedBox(height: 30),

                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,

                          style: const TextStyle(color: Colors.white),

                          decoration: InputDecoration(
                            hintText: 'Email Address',

                            hintStyle: const TextStyle(color: Colors.white70),

                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Colors.white,
                            ),

                            filled: true,

                            fillColor: Colors.white.withOpacity(0.12),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),

                              borderSide: BorderSide.none,
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),

                              borderSide: BorderSide.none,
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),

                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        TextField(
                          controller: passwordController,
                          obscureText: hidePassword,

                          style: const TextStyle(color: Colors.white),

                          decoration: InputDecoration(
                            hintText: 'Password',

                            hintStyle: const TextStyle(color: Colors.white70),

                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Colors.white,
                            ),

                            suffixIcon: IconButton(
                              icon: Icon(
                                hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white,
                              ),

                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                            ),

                            filled: true,

                            fillColor: Colors.white.withOpacity(0.12),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),

                              borderSide: BorderSide.none,
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),

                              borderSide: BorderSide.none,
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),

                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        SizedBox(
                          width: double.infinity,
                          height: 58,

                          child: ElevatedButton(
                            onPressed: login,

                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1D4ED8),

                              foregroundColor: Colors.white,

                              elevation: 8,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),

                            child: const Text(
                              'Sign In',

                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,

                                MaterialPageRoute(
                                  builder: (_) => const SignupScreen(),
                                ),
                              );
                            },

                            child: const Text(
                              "Don't have an account? Sign up",

                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
