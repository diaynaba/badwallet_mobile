import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../dashboard/providers/wallet_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WalletProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Historique"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: provider.transactions.length,
        itemBuilder: (context, index) {
          final t = provider.transactions[index];

          final isPositive = t.type == "DEPOSIT";

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    isPositive ? Colors.green : Colors.red,
                child: Icon(
                  isPositive
                      ? Icons.arrow_downward
                      : Icons.arrow_upward,
                  color: Colors.white,
                ),
              ),
              title: Text(
                t.type,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.status),
                  Text(
                    DateFormat(
                      "dd/MM/yyyy HH:mm",
                    ).format(t.createdAt),
                  ),
                ],
              ),
              trailing: Text(
                NumberFormat.currency(
                  locale: "fr",
                  symbol: "FCFA ",
                ).format(t.amount),
              ),
            ),
          );
        },
      ),
    );
  }
}