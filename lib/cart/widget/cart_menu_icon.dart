import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import '../../util/routes.dart';
import '../repo/cart_repo.dart';

class CartMenuIcon extends StatefulWidget {
  const CartMenuIcon({Key? key}) : super(key: key);

  @override
  State<CartMenuIcon> createState() => _CartMenuIconState();
}

class _CartMenuIconState extends State<CartMenuIcon> {
  CartRepo? cartRepo;
  @override
  Widget build(BuildContext context) {
    cartRepo = Provider.of(context);
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_cart, color: Colors.black,),
          onPressed: () {
            // Open the cart or perform any other action
            Modular.to.pushNamed(Routes.cart);
          },
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            constraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              '${cartRepo!.totalQuantity}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );;
  }
}
