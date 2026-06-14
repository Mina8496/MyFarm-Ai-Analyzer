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
