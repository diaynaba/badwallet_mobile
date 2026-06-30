import 'package:flutter/material.dart';

import '../../../models/transaction.dart';
import '../../../models/wallet.dart';
import '../services/wallet_service.dart';

class WalletProvider extends ChangeNotifier {
  final WalletService _service = WalletService();

  Wallet? wallet;
  List<WalletTransaction> transactions = [];

  bool isLoading = false;
  String? error;

  Future<void> loadDashboard(String phone) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      wallet = await _service.getBalance(phone);
      transactions = await _service.getTransactions(phone);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}