import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  final List<Product> products = const [
    Product(name: "Ordinateur Portable", price: 250000, imageUrl: "assets/laptop.png"),
    Product(name: "Livre de Math", price: 5000, imageUrl: "assets/book.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.asset(products[index].imageUrl),
          title: Text(products[index].name),
          subtitle: Text("${products[index].price} FCFA"),
          trailing: IconButton(icon: const Icon(Icons.add_shopping_cart), onPressed: () {}),
        );
      },
    );
  }
}
