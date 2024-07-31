import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://lab.pixel6.co/api/';

  // Function to verify PAN
  static Future<PanValidationResult?> verifyPan(String pan) async {
    final url = Uri.parse('${_baseUrl}verify-pan.php');
    final response = await http.post(url, body: {'panNumber': pan});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'Success') {
        return PanValidationResult(
          isValid: data['isValid'],
          fullName: data['fullName'],
        );
      }
    }
    return null;
  }

  // Function to get postcode details
  static Future<PostcodeDetailsResult?> getPostcodeDetails(String postcode) async {
    final url = Uri.parse('${_baseUrl}get-postcode-details.php');
    final response = await http.post(url, body: {'postcode': postcode});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'Success') {
        return PostcodeDetailsResult(
          city: data['city'][0]['name'],
          state: data['state'][0]['name'],
        );
      }
    }
    return null;
  }
}

// Model for PAN validation result
class PanValidationResult {
  final bool isValid;
  final String fullName;

  PanValidationResult({required this.isValid, required this.fullName});
}

// Model for postcode details result
class PostcodeDetailsResult {
  final String city;
  final String state;

  PostcodeDetailsResult({required this.city, required this.state});
}
