import 'package:alt/authprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                // Call the signInWithEmailAndPassword method from AuthProvider
                await Provider.of<AuthProvider>(context, listen: false).signInWithEmailAndPassword(
                  emailController.text,
                  passwordController.text,
                );

                // Check if the user is logged in
                if (Provider.of<AuthProvider>(context, listen: false).user != null) {
                  // Navigate to the home page
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  // Handle login failure
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
