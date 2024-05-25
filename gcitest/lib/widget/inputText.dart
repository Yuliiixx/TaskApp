import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator; // Validator function

  const InputBox({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.validator, // Validator property
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField( // Menggunakan TextFormField untuk mendukung validasi
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        fillColor: Colors.white,
        filled: true,
        border: InputBorder.none, // Hilangkan outline
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
      validator: validator, // Menggunakan validator function
    );
  }
}
