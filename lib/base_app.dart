import 'package:ecommerce_flutter/cart/database/cart_database.dart';
import 'package:ecommerce_flutter/cart/repo/cart_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

class BaseApp extends StatefulWidget {
  const BaseApp({Key? key}) : super(key: key);

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => CartDatabase()),
        ChangeNotifierProxyProvider<CartDatabase, CartRepo>(
            create: (context) => CartRepo(),
            update: (_, __, ___) => ___!..updateCartDb(__),
        )
      ],
      child: MaterialApp.router(
        title: 'My Smart App',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: const AppBarTheme(
                color: Colors.white,
                toolbarTextStyle: TextStyle(color: Colors.black),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
                ),
                iconTheme: IconThemeData(color: Colors.black))),
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
      ),
    );
  }
}
