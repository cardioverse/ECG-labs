import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';  // Import Firebase User
import 'package:ecg_trainer/user_authentication/auth_service.dart';  // Import AuthService
import 'package:ecg_trainer/main.dart';  // Import ECGTrainerApp to navigate to main navigation
import 'package:ecg_trainer/user_authentication/signup_screen.dart';  // Import SignUpScreen

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();
  bool _isPasswordVisible = false;

  Future<void> _login() async {
    setState(() {}); // Update icon state based on validation
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

    if (user != null) {
      print('Login successful, navigating to HomeScreen');
      // Navigate to the HomeScreen with navigation bar
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      // Show an error message
      print('Login failed');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
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
              SizedBox(height: 64),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Image.asset(
                    'assets/icon/icon.png', // Custom icon at the top
                    height: 200,

                  ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Enter your email address and password to get access to your account',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 32),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.email, color: Colors.white),
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    Divider(color: Colors.white54),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock, color: Colors.white),
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.white),
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
                      style: TextStyle(color: Colors.white),
                      obscureText: !_isPasswordVisible,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {}, // Add forgot password functionality
                    child: Text(
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
                              borderRadius: BorderRadius.horizontal(left: Radius.circular(30.0)),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 24.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple[900],
                              borderRadius: BorderRadius.horizontal(right: Radius.circular(30.0)),
                            ),
                            child: Center(
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
              SizedBox(height: 32),
              Center(
                child: Column(
                  children: [
                    Text(
                      "Don't have an account yet?",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: _navigateToSignUp,
                      child: Text(
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
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
