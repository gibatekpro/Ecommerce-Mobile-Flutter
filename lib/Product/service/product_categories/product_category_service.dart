import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../util/util.dart';
import '../../model/product_category.dart';

class ProductCategoryService{


  static Future<List<ProductCategory>> fetchProductCategories() async{

    const String fetchProductsUrl = '${Util.apiUrl}/product-categories';

    final response = await http.get(Uri.parse(fetchProductsUrl));

    if (response.statusCode == 200) {
      // Util.logOutput('Success: ${response.statusCode}');
      // If the server returns a 200 OK response,
      // then parse the JSON.
      Map<String, dynamic> jsonData = json.decode(response.body);
      List<dynamic> productCategoriesData = jsonData['_embedded']['productCategory'];

      return productCategoriesData
          .map((jsonProduct) => ProductCategory.fromJson(jsonProduct))
          .toList();
    } else {
      Util.logOutput('Error: problem');
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

}