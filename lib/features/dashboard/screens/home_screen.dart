import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../auth/providers/auth_provider.dart';
import '../../history/screens/history_screen.dart';
import '../providers/wallet_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool hideBalance = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final auth = context.read<AuthProvider>();

      if (auth.phone != null) {
        context.read<WalletProvider>().loadDashboard(auth.phone!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WalletProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("BadWallet"),
        centerTitle: true,
      ),
      body: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : provider.error != null
              ? Center(
                  child: Text(provider.error!),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    final auth = context.read<AuthProvider>();

                    if (auth.phone != null) {
                      await provider.loadDashboard(auth.phone!);
                    }
                  },
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      const Text(
                        "Bonjour 👋",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        provider.wallet?.phoneNumber ?? "",
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 25),

                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Solde disponible",
                              ),

                              const SizedBox(height: 15),

                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      hideBalance
                                          ? "********"
                                          : NumberFormat.currency(
                                                  locale: "fr",
                                                  symbol: "FCFA ")
                                              .format(
                                                  provider.wallet?.balance ??
                                                      0),
                                      style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        hideBalance =
                                            !hideBalance;
                                      });
                                    },
                                    icon: Icon(
                                      hideBalance
                                          ? Icons.visibility
                                          : Icons
                                              .visibility_off,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.send),
                              label: const Text("Transférer"),
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.payment),
                              label: const Text("Payer"),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      SizedBox(
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const HistoryScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.history),
                          label: const Text("Historique"),
                        ),
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "5 dernières transactions",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      if (provider.transactions.isEmpty)
                        const Card(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: Text(
                                "Aucune transaction",
                              ),
                            ),
                          ),
                        ),

                      ...provider.transactions.take(5).map(
                        (t) => Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  t.type == "DEPOSIT"
                                      ? Colors.green
                                      : Colors.red,
                              child: Icon(
                                t.type == "DEPOSIT"
                                    ? Icons.arrow_downward
                                    : Icons.arrow_upward,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(t.type),
                            subtitle: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
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
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}