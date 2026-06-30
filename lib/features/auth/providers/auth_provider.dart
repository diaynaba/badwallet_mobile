import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service = AuthService();

  bool isLoading = false;

  String? phone;

  Future<void> login(String number) async {
    isLoading = true;
    notifyListeners();

    await _service.savePhone(number);

    phone = number;

    isLoading = false;
    notifyListeners();
  }

  Future<void> loadUser() async {
    phone = await _service.getPhone();
    notifyListeners();
  }
}