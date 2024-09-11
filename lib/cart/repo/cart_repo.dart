
import 'package:ecommerce_flutter/util/util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../database/cart_database.dart';

class CartRepo extends ChangeNotifier{

  CartDatabase? cartDatabase;
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  double totalPrice = 0;

  int totalQuantity = 0;

  // CartRepo(this.cartDatabase);
  CartRepo();

  void addToCart(CartItem theCartItem) async {
    bool alreadyExistsInCart = false;
    CartItem? existingCartItem;
    var index = cartItems
        .indexWhere((element) => element.id == theCartItem.id);

    if (cartItems.isNotEmpty && index > -1) {
      existingCartItem = cartItems[index];
      alreadyExistsInCart = existingCartItem != null;
    }

    if (alreadyExistsInCart) {
      int incrementQuantity = existingCartItem!.quantity + 1;
      CartItem updatedCartItem = existingCartItem.copyWith(
        quantity: incrementQuantity,
      );

      Util.logOutput('==>> ${existingCartItem.quantity}');

      bool response = await cartDatabase!.updateCartItem(updatedCartItem);


      Fluttertoast.showToast(
        msg: '$response',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white,
      );

    } else {
      int response =  await cartDatabase!.insertCartItem(theCartItem);

      if (response != null) {

        Fluttertoast.showToast(
          msg: '$response',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[700],
          textColor: Colors.white,
        );

      }

    }

    await updateProvider();
  }


  void remove(CartItem theCartItem) async{
    // Get the index of the item in the list
    int itemIndex = cartItems.indexWhere((cartItem) => cartItem.id == theCartItem.id);

    // If found (index will be greater than -1), remove the item from the list at the given index
    if (itemIndex > -1) {
      await cartDatabase!.deleteCartItem(cartItems[itemIndex]);
      await updateProvider();
    }
  }

  void decrementQuantity(CartItem cartItem) async{

    if (cartItem.quantity == 1) {
      remove(cartItem);
    } else {
      await cartDatabase!.updateCartItem(cartItem.copyWith(quantity: cartItem.quantity - 1));
      await updateProvider();
    }
  }


  void updateCartDb(CartDatabase? cartDatabase) async{
    this.cartDatabase = cartDatabase;
    await updateProvider();
  }

  updateProvider() async{
    _cartItems = await cartDatabase!.getAllCartItems();

    computeCartTotals(_cartItems);

    notifyListeners();
  }

  void computeCartTotals(List<CartItem> cartItemList) {
    double totalPriceValue = 0;
    int totalQuantityValue = 0;

    for (CartItem currentCartItem in cartItemList) {
      totalPriceValue += currentCartItem.quantity * currentCartItem.unitPrice;
      totalQuantityValue += currentCartItem.quantity;
    }

    totalPrice = totalPriceValue;
    totalQuantity = totalQuantityValue;

  }

}