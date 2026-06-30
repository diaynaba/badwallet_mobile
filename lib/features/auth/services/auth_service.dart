import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String phoneKey = "phone";

  Future<void> savePhone(String phone) async {
    await _storage.write(
      key: phoneKey,
      value: phone,
    );
  }

  Future<String?> getPhone() async {
    return _storage.read(key: phoneKey);
  }

  Future<void> logout() async {
    await _storage.delete(key: phoneKey);
  }
}