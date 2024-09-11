import 'package:ecommerce_flutter/cart/database/cart_database.dart';
import 'package:ecommerce_flutter/cart/repo/cart_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import '../../util/routes.dart';
import '../widget/cart_item_card.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {

  CartRepo? cartRepo;

  @override
  Widget build(BuildContext context) {
    cartRepo = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartRepo!.cartItems.length,
                itemBuilder: (context, index) {
                return CardItemCard(cartItem: cartRepo!.cartItems[index], cartRepo: cartRepo!);
                }
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: ElevatedButton(
                      onPressed: (){
                          Modular.to.pushNamed(Routes.checkout);
                      },
                      child: Text('Checkout (\$${cartRepo!.totalPrice})')
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
