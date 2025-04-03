import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductCart extends StatelessWidget {
  final ProductModel product;
  final int quantity;
  final VoidCallback onRemove;

  const ProductCart({
    Key? key,
    required this.product,
    required this.quantity,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Image.network(
              product.imageUrl,
              width: 70.0,
              height: 70.0,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Prix: ${product.price} FCFA"),
                  Text("Quantité: $quantity"),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: onRemove,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
