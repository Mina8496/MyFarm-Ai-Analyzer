enum PaymentStatus { pending, success, failed, cancelled }

enum PaymentMethod { card, fawry, valu, meeza }

class PaymentModel {
  final String id;
  final double amount;
  final String currency;
  final PaymentStatus status;
  final PaymentMethod method;
  final DateTime createdAt;
  final String? transactionId;
  final String? errorMessage;

  const PaymentModel({
    required this.id,
    required this.amount,
    required this.currency,
    required this.status,
    required this.method,
    required this.createdAt,
    this.transactionId,
    this.errorMessage,
  });

  PaymentModel copyWith({
    PaymentStatus? status,
    String? transactionId,
    String? errorMessage,
  }) {
    return PaymentModel(
      id: id,
      amount: amount,
      currency: currency,
      status: status ?? this.status,
      method: method,
      createdAt: createdAt,
      transactionId: transactionId ?? this.transactionId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'currency': currency,
        'status': status.name,
        'method': method.name,
        'created_at': createdAt.toIso8601String(),
        'transaction_id': transactionId,
      };
}
