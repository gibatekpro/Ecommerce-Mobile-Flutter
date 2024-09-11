import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../util/util.dart';
import '../../model/ProductResponse.dart';

class ProductSearchService {

  /*
   * Add the http package. (http: <latest_version>)
      Make a network request using the http package.
      Convert the response into a custom Dart object.
      Fetch and display the data with Flutter.
   *
   * <!-- Required to fetch data from the internet. -->
      <uses-permission android:name="android.permission.INTERNET" />

   * */

  Future<ProductResponse> fetchProductsByKeyWord(
      String? keyWord, int page) async {
    final String fetchProductsUrl =
        '${Util.apiUrl}/products/search/findByNameContainsIgnoreCase?name=$keyWord&page=$page';

    final response = await http.get(Uri.parse(fetchProductsUrl));

    if (response.statusCode == 200) {
      // Util.logOutput('The response =========== success');
      // Util.logOutput('Success: ${response.statusCode}');
      // If the server returns a 200 OK response,
      // then parse the JSON.
      Map<String, dynamic> jsonData = json.decode(response.body);
      // List<dynamic> productsData = jsonData['_embedded']['products'];
      //
      // return productsData
      //     .map((jsonProduct) => Product.fromJson(jsonProduct))
      //     .toList();
      return ProductResponse.fromJson(jsonData);
    } else {
      Util.logOutput('Error: problem');
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
