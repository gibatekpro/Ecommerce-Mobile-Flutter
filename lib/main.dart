import 'dart:io';
import 'package:ecommerce_flutter/.env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'base_app.dart';
import 'modular/module/app_module.dart';
import 'util/http_override.dart';

void main() {
  HttpOverrides.global =
      MyHttpOverrides(); //TODO: Remove this code in production
  Stripe.publishableKey = stripePublishableKey;
  runApp(ModularApp( // Flutter modular
    module: AppModule(), // App Module contains all Modules in the app
    child: const BaseApp(), // Base widget can define global theme
  ));
}