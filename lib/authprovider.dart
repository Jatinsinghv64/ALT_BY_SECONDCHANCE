import 'package:alt/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;

  User? get user => _user;

  // Sign in with email and password
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    User? user = await _authService.signInWithEmailAndPassword(email, password);

    if (user != null) {
      _user = user;
      notifyListeners();
    } else {
      // Handle login failure
    }
  }
}
