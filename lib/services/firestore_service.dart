import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// 🔹 Ajoute un produit dans Firestore
  Future<void> addProduct(ProductModel product) async {
    try {
      await _db.collection('products').add(product.toMap());
    } catch (e) {
      throw Exception("Erreur lors de l'ajout du produit : $e");
    }
  }

  /// 🔹 Récupère la liste des produits
  Stream<List<ProductModel>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
    });
  }

  /// 🔹 Supprime un produit
  Future<void> deleteProduct(String productId) async {
    try {
      await _db.collection('products').doc(productId).delete();
    } catch (e) {
      throw Exception("Erreur lors de la suppression du produit : $e");
    }
  }

  /// 🔹 Passe une commande
  Future<void> placeOrder(OrderModel order) async {
    try {
      await _db.collection('orders').add(order.toMap());
    } catch (e) {
      throw Exception("Erreur lors de la commande : $e");
    }
  }

  /// 🔹 Récupère la liste des commandes d’un utilisateur
  Stream<List<OrderModel>> getUserOrders(String userId) {
    return _db
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => OrderModel.fromFirestore(doc)).toList();
    });
  }
}
