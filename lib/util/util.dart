import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Util{

  static const String baseUrl = 'https://192.168.8.112:4040';

  static const String apiUrl = 'https://192.168.8.112:4040/api';

  static const String currency = '\$';

  static const String logo = 'assets/images/products/books/book-luv2code-1000.png';

  static logOutput(String message)
   {
     if (kDebugMode) {
       print(message);
     }
  }

  static const primaryColor = Color.fromARGB(255, 103, 58, 183);
}