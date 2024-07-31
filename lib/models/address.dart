class Address {
  String addressLine1;
  String addressLine2;
  String postcode;
  String city;
  String state;

  Address({
    required this.addressLine1,
    this.addressLine2 = '',
    required this.postcode,
    required this.city,
    required this.state,
  });

  // Method to create a new Address object from a map (for local storage or API response)
  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      addressLine1: map['addressLine1'] ?? '',
      addressLine2: map['addressLine2'] ?? '',
      postcode: map['postcode'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
    );
  }

  // Method to convert Address object to a map (for local storage or API request)
  Map<String, dynamic> toMap() {
    return {
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'postcode': postcode,
      'city': city,
      'state': state,
    };
  }
}
