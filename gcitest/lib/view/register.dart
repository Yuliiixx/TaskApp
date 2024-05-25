import 'package:flutter/material.dart';
import 'package:gcitest/db/database_helper.dart';
import 'package:gcitest/model/user_model.dart';
import 'package:gcitest/view/login.dart';
import 'package:gcitest/widget/button.dart';
import 'package:gcitest/widget/inputText.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final _formKey = GlobalKey<FormState>(); // Key untuk form

  void _register() async {
    if (_formKey.currentState!.validate()) {
      // Validasi sukses, lanjutkan dengan proses registrasi
      String name = _nameController.text.trim();
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      String confirmPassword = _confirmPasswordController.text.trim();

      if (password != confirmPassword) {
        // Jika password tidak cocok dengan konfirmasi password, tampilkan pesan kesalahan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password and confirm password do not match.'),
          ),
        );
        return; // Hentikan proses registrasi jika password tidak cocok
      }

      User newUser = User(name: name, email: email, password: password);

      int? result = await _databaseHelper.registerUser(newUser);
      if (result != null && result > 0) {
        // Jika registrasi berhasil, lakukan sesuatu, seperti navigasi ke halaman login
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));

        // Tampilkan pesan sukses
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration successful. Please login.'),
          ),
        );
      } else {
        // Jika registrasi gagal, tampilkan pesan kesalahan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed. Please try again.'),
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
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset(
              'images/shape.png', // Path to your asset image
              width: 200,
              height: 200,
            ),
          ),
          SingleChildScrollView(
            // Tambahkan SingleChildScrollView untuk menambahkan scrollbar jika diperlukan
            child: Padding(
              
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 150), // Menambahkan space di bawah gambar shape
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Welcome Onboard!', // Judul
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Lets help you in completing your task', // Subjudul
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Fullname',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    InputBox(
                      controller: _nameController,
                      hintText: 'Enter your fullname',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your fullname';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.0),
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
                        color: Colors.grey[800],
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
                    SizedBox(height: 20),
                    Text(
                      'Confirm Password',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    InputBox(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm your password',
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.0),
                    CustomButton(
                      onPressed: _register,
                      text: 'Register',
                    ),
                    SizedBox(height: 12.0),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(color: Colors.grey[800],  fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: 'Sign in',
                                style: TextStyle(color: Color(0xFF62D2C3),  fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
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
