import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../services/order_service.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool isLoading = false;

  void _placeOrder(BuildContext context) async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    if (cartProvider.items.isEmpty) return;

    setState(() => isLoading = true);

    try {
      await OrderService().placeOrder(cartProvider.items.values.toList(), cartProvider.totalPrice);
      cartProvider.clearCart();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Commande passée avec succès !')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur: ${e.toString()}')));
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final totalPrice = cartProvider.totalPrice;

    return Scaffold(
      appBar: AppBar(title: const Text('Paiement')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Résumé de la commande', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...cartProvider.items.values.map((item) => ListTile(
              title: Text(item.title),
              subtitle: Text('Quantité: ${item.quantity} - Prix: ${item.price} FCFA'),
            )),
            const Divider(),
            Text('Total: $totalPrice FCFA', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
              onPressed: () => _placeOrder(context),
              child: const Text('Confirmer l\'achat'),
            ),
          ],
        ),
      ),
    );
  }
}
