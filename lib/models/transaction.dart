class WalletTransaction {
  final int id;
  final String type;
  final String status;
  final double amount;
  final double fees;
  final DateTime createdAt;

  WalletTransaction({
    required this.id,
    required this.type,
    required this.status,
    required this.amount,
    required this.fees,
    required this.createdAt,
  });

  factory WalletTransaction.fromJson(Map<String, dynamic> json) {
    return WalletTransaction(
      id: json["id"],
      type: json["type"],
      status: json["status"],
      amount: (json["amount"] as num).toDouble(),
      fees: (json["fees"] as num).toDouble(),
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }
}