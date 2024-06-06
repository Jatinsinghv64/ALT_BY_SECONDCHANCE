import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/PSC-LOGO.png', // Replace with the path to your company logo
              width: 120, // Adjust width as needed
              height: 120, // Adjust height as needed
            ),
            SizedBox(height: 20), // Add spacing between logo and CircularProgressIndicator
            CircularProgressIndicator(), // Add a CircularProgressIndicator for loading indication
          ],
        ),
      ),
    );
  }
}
