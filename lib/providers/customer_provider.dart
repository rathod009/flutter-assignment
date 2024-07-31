import 'package:flutter/material.dart';
import '../models/customer.dart';

class CustomerProvider with ChangeNotifier {
  List<Customer> _customers = [];

  List<Customer> get customers => _customers;

  // Adds a new customer to the list
  void addCustomer(Customer customer) {
    _customers.add(customer);
    notifyListeners();  // Notifies listeners that the data has changed
  }

  // Updates an existing customer in the list by index
  void updateCustomer(int index, Customer customer) {
    _customers[index] = customer;
    notifyListeners();  // Notifies listeners that the data has changed
  }

  // Deletes a customer from the list by index
  void deleteCustomer(int index) {
    _customers.removeAt(index);
    notifyListeners();  // Notifies listeners that the data has changed
  }

  // Fetches a customer by index
  Customer getCustomer(int index) {
    return _customers[index];
  }

  // Clears all customers (useful for reset or clear operations)
  void clearCustomers() {
    _customers.clear();
    notifyListeners();  // Notifies listeners that the data has changed
  }
}
