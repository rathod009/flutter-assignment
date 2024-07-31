import 'package:flutter/material.dart';
import '../screens/customer_list_screen.dart';
import '../screens/customer_form_screen.dart';

class Routes {
  static const String customerList = '/';
  static const String customerForm = '/customer-form';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      customerList: (context) => CustomerListScreen(),
      customerForm: (context) => CustomerFormScreen(),
    };
  }
}
