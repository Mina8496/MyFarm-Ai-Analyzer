// ─── Payment Models ───────────────────────────────────────────────

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

// ─── Order Item ───────────────────────────────────────────────────
class OrderItem {
  final String name;
  final int amount; // in cents
  final String description;
  final int quantity;

  const OrderItem({
    required this.name,
    required this.amount,
    required this.description,
    this.quantity = 1,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'amount': amount,
        'description': description,
        'quantity': quantity,
      };
}

// ─── Billing Data ─────────────────────────────────────────────────
class BillingData {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String? apartment;
  final String? floor;
  final String? street;
  final String? building;
  final String city;
  final String country;
  final String? state;
  final String? postalCode;

  const BillingData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.apartment = 'NA',
    this.floor = 'NA',
    this.street = 'NA',
    this.building = 'NA',
    required this.city,
    this.country = 'EG',
    this.state = 'NA',
    this.postalCode = 'NA',
  });

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone_number': phone,
        'apartment': apartment,
        'floor': floor,
        'street': street,
        'building': building,
        'city': city,
        'country': country,
        'state': state,
        'postal_code': postalCode,
        'shipping_method': 'NA',
      };
}
