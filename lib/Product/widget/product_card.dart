import 'package:ecommerce_flutter/cart/database/cart_database.dart';
import 'package:ecommerce_flutter/cart/repo/cart_repo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../util/util.dart';

class ProductCard extends StatefulWidget {
  final int id;
  final String name;
  final String imageUrl;
  final double unitPrice;
  final int unitsInStock;

  const ProductCard(
      {Key? key, required this.id, required this.name, required this.imageUrl, required this.unitPrice, required this.unitsInStock})
      : super(key: key);

  @override
  ProductCardState createState() => ProductCardState();
}

class ProductCardState extends State<ProductCard> {

  CartRepo? cartRepo;

  @override
  Widget build(BuildContext context) {
    cartRepo = Provider.of(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                flex: 3,
                child: Image(
                  image: AssetImage(widget.imageUrl),
                  fit: BoxFit.contain,
                )
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              flex: 2,
              child: Text(
                widget.name,
                style: GoogleFonts.almarai(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '${Util.currency}${widget.unitPrice}',
                style: GoogleFonts.almarai(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(onPressed: () {
              cartRepo!.addToCart(CartItem(id: widget.id,
                  name: widget.name,
                  quantity: 1,
                  imageUrl: widget.imageUrl,
                  unitPrice: widget.unitPrice,
                  unitsInStock: widget.unitsInStock));
            },
                child: const Text('Add to cart'))
          ],
        ),
      ),
    );
  }
}
