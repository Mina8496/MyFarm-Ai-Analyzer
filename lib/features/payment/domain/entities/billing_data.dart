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
