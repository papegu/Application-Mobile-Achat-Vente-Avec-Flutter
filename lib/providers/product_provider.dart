import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/firestore_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  // Charger les produits depuis Firestore
  Future<void> fetchProducts() async {
    _products = await FirestoreService().getProducts();
    notifyListeners();
  }

  // Ajouter un produit
  Future<void> addProduct(Product product) async {
    await FirestoreService().addProduct(product);
    _products.add(product);
    notifyListeners();
  }

  // Supprimer un produit
  Future<void> deleteProduct(String productId) async {
    await FirestoreService().deleteProduct(productId);
    _products.removeWhere((prod) => prod.id == productId);
    notifyListeners();
  }
}
