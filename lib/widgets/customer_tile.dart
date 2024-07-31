import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../screens/customer_form_screen.dart';

class CustomerTile extends StatelessWidget {
  final Customer customer;
  final int index;
  final VoidCallback onDelete;

  const CustomerTile({
    Key? key,
    required this.customer,
    required this.index,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(customer.fullName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(customer.email),
          Text('+91 ${customer.mobileNumber}'),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomerFormScreen(customerIndex: index),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
