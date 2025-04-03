import 'product_model.dart';

class OrderModel {
  final String orderId;
  final String userId;
  final List<Product> products;
  final int totalAmount;
  final String status;
  final DateTime orderDate;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.products,
    required this.totalAmount,
    required this.status,
    required this.orderDate,
  });

  // Convertir un objet OrderModel en Map (pour Firestore)
  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'userId': userId,
      'products': products.map((product) => product.name).toList(),
      'totalAmount': totalAmount,
      'status': status,
      'orderDate': orderDate.toIso8601String(),
    };
  }

  // Créer un objet OrderModel à partir d'un document Firestore
  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'],
      userId: map['userId'],
      products: (map['products'] as List<dynamic>)
          .map((item) => Product(name: item, price: 0, imageUrl: ""))
          .toList(),
      totalAmount: map['totalAmount'],
      status: map['status'],
      orderDate: DateTime.parse(map['orderDate']),
    );
  }
}
