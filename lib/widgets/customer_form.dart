import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/customer.dart';
import '../models/address.dart';
import '../providers/customer_provider.dart';
import '../utils/api_service.dart';
import '../utils/validators.dart';

class CustomerForm extends StatefulWidget {
  final int? customerIndex; // Pass null for adding a new customer

  const CustomerForm({Key? key, this.customerIndex}) : super(key: key);

  @override
  _CustomerFormState createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  List<Address> _addresses = [];
  bool _isPanLoading = false;
  bool _isPostcodeLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.customerIndex != null) {
      final customer = Provider.of<CustomerProvider>(context, listen: false)
          .getCustomer(widget.customerIndex!);
      _panController.text = customer.pan;
      _fullNameController.text = customer.fullName;
      _emailController.text = customer.email;
      _mobileNumberController.text = customer.mobileNumber;
      _addresses = List.from(customer.addresses);
    } else {
      _addresses = [Address(addressLine1: '', postcode: '', city: '', state: '')];
    }
  }

  @override
  void dispose() {
    _panController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      final newCustomer = Customer(
        pan: _panController.text,
        fullName: _fullNameController.text,
        email: _emailController.text,
        mobileNumber: _mobileNumberController.text,
        addresses: _addresses,
      );

      if (widget.customerIndex == null) {
        Provider.of<CustomerProvider>(context, listen: false)
            .addCustomer(newCustomer);
      } else {
        Provider.of<CustomerProvider>(context, listen: false)
            .updateCustomer(widget.customerIndex!, newCustomer);
      }

      Navigator.pop(context);
    }
  }

  Future<void> _validatePan(String pan) async {
    if (!Validators.isValidPan(pan)) return;
    setState(() {
      _isPanLoading = true;
    });

    final result = await ApiService.verifyPan(pan);

    setState(() {
      _isPanLoading = false;
    });

    if (result != null && result.isValid) {
      _fullNameController.text = result.fullName;
    }
  }

  Future<void> _fetchPostcodeDetails(int index, String postcode) async {
    if (!Validators.isValidPostcode(postcode)) return;
    setState(() {
      _isPostcodeLoading = true;
    });

    final result = await ApiService.getPostcodeDetails(postcode);

    setState(() {
      _isPostcodeLoading = false;
    });

    if (result != null) {
      setState(() {
        _addresses[index].city = result.city;
        _addresses[index].state = result.state;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          // PAN Field
          TextFormField(
            controller: _panController,
            decoration: InputDecoration(
              labelText: 'PAN',
              suffixIcon: _isPanLoading ? CircularProgressIndicator() : null,
            ),
            validator: Validators.validatePan,
            onChanged: _validatePan,
          ),
          SizedBox(height: 16.0),

          // Full Name Field
          TextFormField(
            controller: _fullNameController,
            decoration: InputDecoration(labelText: 'Full Name'),
            validator: Validators.validateFullName,
          ),
          SizedBox(height: 16.0),

          // Email Field
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            validator: Validators.validateEmail,
          ),
          SizedBox(height: 16.0),

          // Mobile Number Field
          TextFormField(
            controller: _mobileNumberController,
            decoration: InputDecoration(
              labelText: 'Mobile Number',
              prefixText: '+91 ',
            ),
            validator: Validators.validateMobileNumber,
          ),
          SizedBox(height: 16.0),

          // Address Management
          Text(
            'Addresses',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _addresses.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Address Line 1'),
                    initialValue: _addresses[index].addressLine1,
                    validator: Validators.validateAddressLine,
                    onChanged: (value) => _addresses[index].addressLine1 = value,
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Address Line 2'),
                    initialValue: _addresses[index].addressLine2,
                    onChanged: (value) => _addresses[index].addressLine2 = value,
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Postcode',
                      suffixIcon:
                          _isPostcodeLoading ? CircularProgressIndicator() : null,
                    ),
                    initialValue: _addresses[index].postcode,
                    validator: Validators.validatePostcode,
                    onChanged: (value) => _fetchPostcodeDetails(index, value),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'City'),
                    initialValue: _addresses[index].city,
                    readOnly: true,
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'State'),
                    initialValue: _addresses[index].state,
                    readOnly: true,
                  ),
                  SizedBox(height: 16.0),
                ],
              );
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _validateAndSubmit,
            child: Text(widget.customerIndex == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }
}
