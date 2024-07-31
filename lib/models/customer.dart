// import 'package:flutter/material.dart';
import '../models/address.dart';

class Customer {
  String pan;
  String fullName;
  String email;
  String mobileNumber;
  List<Address> addresses;

  Customer({
    required this.pan,
    required this.fullName,
    required this.email,
    required this.mobileNumber,
    required this.addresses,
  });

  // Method to create a new Customer object from a map (for local storage or API response)
  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      pan: map['pan'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      mobileNumber: map['mobileNumber'] ?? '',
      addresses: map['addresses'] != null
          ? List<Address>.from(map['addresses'].map((address) => Address.fromMap(address)))
          : [],
    );
  }

  // Method to convert Customer object to a map (for local storage or API request)
  Map<String, dynamic> toMap() {
    return {
      'pan': pan,
      'fullName': fullName,
      'email': email,
      'mobileNumber': mobileNumber,
      'addresses': addresses.map((address) => address.toMap()).toList(),
    };
  }
}
