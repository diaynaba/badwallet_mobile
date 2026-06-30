class Wallet {
  final String phoneNumber;
  final double balance;

  Wallet({
    required this.phoneNumber,
    required this.balance,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      phoneNumber: json["phoneNumber"],
      balance: (json["balance"] as num).toDouble(),
    );
  }
}