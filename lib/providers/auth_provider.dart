import 'package:flutter/material.dart';
import 'package:the_virtual_vault/models/user.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;

  User? get user => _user;

  Future<void> login(String email, String password) async {
    _user = await _authService.login(email, password);
    notifyListeners();
  }

  Future<void> register(User user) async {
    _user = await _authService.register(user);
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
