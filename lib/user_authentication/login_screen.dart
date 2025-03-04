import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';  // Import Firebase User
import 'package:ecg_trainer/user_authentication/auth_service.dart';  // Import AuthService
import 'package:ecg_trainer/main.dart';  // Import ECGTrainerApp to navigate to main navigation
import 'package:ecg_trainer/user_authentication/signup_screen.dart';  // Import SignUpScreen

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    print('Login button tapped');
    String email = emailController.text;
    String password = passwordController.text;
    User? user;
    try {
      user = await authService.signInWithEmail(email, password);
      print('Attempting to login with email: $email');
    } catch (e) {
      print('Error during login: $e');
    }

    setState(() {
      _isLoading = false;
    });

    if (user != null) {
      print('Login successful, navigating to HomeScreen');
      // Navigate to the HomeScreen with navigation bar
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      // Show an error message
      print('Login failed');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Login failed. Please check your email and password."),
        backgroundColor: Colors.red,
      ));
    }
  }

  bool _isEmailValid(String email) {
    return email.contains('@') && email.isNotEmpty;
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  void _navigateToSignUp() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 64),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Image.asset(
                    'assets/icon/icon.png', // Custom icon at the top
                    height: 200,

                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter your email address and password to get access to your account',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email, color: Colors.white),
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const Divider(color: Colors.white54),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.lock, color: Colors.white),
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      obscureText: !_isPasswordVisible,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {}, // Add forgot password functionality
                    child: const Text(
                      "Forgot?",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: _login,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: const BorderRadius.horizontal(left: Radius.circular(30.0)),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            alignment: Alignment.center,
                            child: _isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text(
                              "Login",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple[900],
                              borderRadius: const BorderRadius.horizontal(right: Radius.circular(30.0)),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: Column(
                  children: [
                    const Text(
                      "Don't have an account yet?",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: _navigateToSignUp,
                      child: const Text(
                        "Create account",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
