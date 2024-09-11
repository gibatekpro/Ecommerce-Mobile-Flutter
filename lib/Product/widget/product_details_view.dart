import 'package:ecommerce_flutter/cart/database/cart_database.dart';
import 'package:ecommerce_flutter/cart/repo/cart_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import '../../cart/widget/cart_menu_icon.dart';
import '../../util/routes.dart';
import '../../util/util.dart';
import '../model/product/product.dart';

class ProductDetailsView extends StatefulWidget {
  final Product product;

  const ProductDetailsView({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  CartRepo? cartRepo;

  @override
  Widget build(BuildContext context) {
    cartRepo = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: const [
          CartMenuIcon()
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: AssetImage('${widget.product.imageUrl}'),
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              '${widget.product.name}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${widget.product.description}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Unit Price: \$${widget.product.unitPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Units in Stock: ${widget.product.unitsInStock}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            Text(
              'Date Created: ${widget.product.dateCreated}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(flex: 2, child: getCartItems(context, cartRepo)),
                const Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      Modular.to.pushNamed(Routes.cart);
                    },
                    child: const Text('Open Cart'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton getCartItems(BuildContext context, CartRepo? cartRepo) {

    return ElevatedButton(
      onPressed: () {
        // Add to cart logic
        cartRepo!.addToCart(
            CartItem(
                id: widget.product.id!,
                name: widget.product.name!,
                quantity: 1,
                imageUrl: widget.product.imageUrl!,
                unitPrice: widget.product.unitPrice!,
                unitsInStock: widget.product.unitsInStock!));
        Util.logOutput(cartRepo.cartItems.toString());
      },
      child: const Text('Add to Cart'),
    );
  }
}
