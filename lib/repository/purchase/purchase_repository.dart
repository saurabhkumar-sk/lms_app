// repositories/purchase_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/payment/purchase_model.dart';

class PurchaseRepository {
  final String baseUrl = 'https://api.classwix.com/api'; // Update with your actual base URL

  Future<bool> createPurchase(Purchase purchase, int courseId, double coursePrice) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); // Adjust if you are storing the token differently

    final response = await http.post(
      Uri.parse('$baseUrl/purchases'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Send token if necessary
      },
      body: json.encode(purchase.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      // Handle error
      return false;
    }
  }
}
