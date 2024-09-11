import 'package:ecommerce_flutter/cart/database/cart_database.dart';
import 'package:flutter/material.dart';

import '../repo/cart_repo.dart';

class CardItemCard extends StatefulWidget {
  final CartItem cartItem;

  final CartRepo cartRepo;

  const CardItemCard({Key? key, required this.cartItem, required this.cartRepo})
      : super(key: key);

  @override
  State<CardItemCard> createState() => _CardItemCardState();
}

class _CardItemCardState extends State<CardItemCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          // Handle card tap event
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Image.asset(
                  widget.cartItem.imageUrl,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cartItem.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Unit Price: \$${widget.cartItem.unitPrice}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Units in Stock: ${widget.cartItem.unitsInStock}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Subtotal: \$${widget.cartItem.unitPrice * widget.cartItem.quantity}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: () {
                              // Handle minus button tap event
                              widget.cartRepo
                                  .decrementQuantity(widget.cartItem);
                            },
                            icon: const Icon(Icons.remove_circle, color: Colors.blue,),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Text('${widget.cartItem.quantity}', textAlign: TextAlign.center,)
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: () {
                              // Handle add button tap event
                              widget.cartRepo.addToCart(widget.cartItem
                                  .copyWith(
                                      quantity: widget.cartItem.quantity + 1));
                            },
                            icon: const Icon(Icons.add_circle, color: Colors.blue,),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    // Handle delete button tap event
                    widget.cartRepo.remove(widget.cartItem);
                  },
                  icon: const Icon(Icons.delete, color: Colors.redAccent,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
