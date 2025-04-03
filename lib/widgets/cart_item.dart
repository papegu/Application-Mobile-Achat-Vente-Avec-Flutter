import 'package:flutter/material.dart';
import '../models/product_model.dart';

class CartItem extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onRemove;

  const CartItem({
    Key? key,
    required this.product,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(10.0),
      leading: Image.network(
        product.imageUrl,
        width: 50.0,
        height: 50.0,
        fit: BoxFit.cover,
      ),
      title: Text(
        product.name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text("Prix: ${product.price} FCFA"),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onRemove,
        color: Colors.red,
      ),
    );
  }
}
