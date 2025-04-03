import 'package:flutter/material.dart';
import 'product_list_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Diayalma - Achat/Vente")),
      body: const ProductListScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const CartScreen())),
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
