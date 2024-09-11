

import 'dart:convert';

import 'package:ecommerce_flutter/checkout/model/payment_info.dart';

import '../../util/util.dart';
import '../model/purchase.dart';
import 'package:http/http.dart' as http;
class CheckoutService{

  static const String _purchaseUrl = '${Util.apiUrl}/checkout/purchase';

  static const String _paymentUrl = '${Util.apiUrl}/checkout/payment-intent';

  static Future<String> placeOrder(Purchase purchase) async {
    final Map<String, dynamic> jsonData = purchase.toJson();

    final response = await http.post(
      Uri.parse(_purchaseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(jsonData),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response,
      // then parse the JSON.
      Map<String, dynamic> jsonData = json.decode(response.body);
      String responseData = jsonData['orderTrackingNumber'];
      return responseData;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      Util.logOutput('Error: ${response.statusCode}');
      throw Exception('Failed to place order');
    }
  }

  static Future<Map<String, dynamic>> createTestPaymentSheet(PaymentInfo paymentInfo) async{

    final Map<String, dynamic> jsonData = paymentInfo.toJson();

    final response = await http.post(
      Uri.parse(_paymentUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(jsonData)
    );


    if (response.statusCode == 200) {
      // If the server returns a 200 OK response,
      // then parse the JSON.
      Map<String, dynamic> jsonData = json.decode(response.body);
      // String responseData = jsonData['orderTrackingNumber'];
      return jsonData;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      Util.logOutput('Error: ${response.statusCode}');
      throw Exception('Failed to place order');
    }

  }

}