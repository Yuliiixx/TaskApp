import 'package:flutter/material.dart';
import 'package:gcitest/db/database_helper.dart';
import 'package:gcitest/view/register.dart'; // Import halaman register
import 'package:gcitest/model/user_model.dart';
import 'package:gcitest/view/task.dart';
import 'package:gcitest/widget/button.dart';
import 'package:gcitest/widget/inputText.dart'; // Import custom button

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final _formKey = GlobalKey<FormState>(); // Key untuk form

  void _login() async {
    if (_formKey.currentState!.validate()) {
      // Jika validasi sukses, lanjutkan dengan proses login
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      User? user = await _databaseHelper.loginUser(email, password);
      if (user != null) {
        // Jika login berhasil, navigasi ke halaman utama
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TaskScreen(user: user)),
        );
      } else {
        // Jika login gagal, tampilkan pesan kesalahan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed. Please check your email and password.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: Stack(
        children: [
          Image.asset(
            'images/shape.png', // Path to your asset image
            width: 200,
            height: 200,
          ),
          SingleChildScrollView(
            // Gunakan SingleChildScrollView untuk menambahkan scrollbar jika diperlukan
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align konten ke start
                  children: <Widget>[
                    SizedBox(height: 200), // Tambahkan space untuk gambar shape
                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'images/login.png', // Path to your asset image
                            height: 200.0,
                          ),
                          SizedBox(height: 24.0),
                          Text(
                            'Welcome Back!',
                            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 24.0),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'Email',
                            style: TextStyle(
                              color: Colors.grey[850],
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InputBox(
                            controller: _emailController,
                            hintText: 'Enter your email',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Password',
                            style: TextStyle(
                              color: Colors.grey[850],
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12.0),
                          InputBox(
                            controller: _passwordController,
                            hintText: 'Enter your password',
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // Logic for "Forgot Password" link
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Color(0xFF62D2C3),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 24.0),
                          CustomButton(
                            onPressed: _login,
                            text: 'Login',
                          ),
                          SizedBox(height: 12.0),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                                );
                              },
                              child: RichText(
                                text: TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(color: Colors.grey[850], fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                      text: 'Sign up',
                                      style: TextStyle(color: Color(0xFF62D2C3), fontWeight: FontWeight.bold),
                                    ),
                                  ],
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
          ),
        ],
      ),
    );
  }
}
