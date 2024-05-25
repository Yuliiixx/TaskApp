import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, // Text color
        backgroundColor: Color(0xFF62D2C3), // Button color
        minimumSize: Size(double.infinity, 50), // Button size
        padding: EdgeInsets.symmetric(horizontal: 16.0), // Button padding
        shape: RoundedRectangleBorder( // Square shape
          borderRadius: BorderRadius.zero,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
           fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
