import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/constants/api_constants.dart';
import '../../../models/wallet.dart';
import '../../../models/transaction.dart';

class WalletService {

  Future<Wallet> getBalance(String phone) async {

    final response = await http.get(
      Uri.parse(
        "${ApiConstants.baseUrl}/api/wallets/$phone/balance",
      ),
    );

    if (response.statusCode == 200) {

      return Wallet.fromJson(
        jsonDecode(response.body),
      );

    }

    throw Exception("Erreur récupération solde");

  }

  Future<List<WalletTransaction>> getTransactions(
      String phone) async {

    final response = await http.get(
      Uri.parse(
        "${ApiConstants.baseUrl}/api/wallets/$phone/transactions",
      ),
    );

    if (response.statusCode == 200) {

      final List data = jsonDecode(response.body);

      return data
          .map(
            (e) => WalletTransaction.fromJson(e),
          )
          .toList();

    }

    throw Exception("Erreur historique");

  }

}