// lib/services/cart_manager.dart
// wf - 43 lines
// lib/helper/cart_manager.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class CartManager {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addToCart(Map<String, dynamic> productData) async {
    DocumentReference cartDoc = _firestore.collection('Carts').doc('C001');

    return _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(cartDoc);

      if (!snapshot.exists) {
        // If the document doesn't exist, create it
        transaction.set(cartDoc, {'cart': {}});
      }

      Map<String, dynamic> cart =
          (snapshot.data() as Map<String, dynamic>?)?['cart'] ?? {};
      int cartCount = cart.keys.length;

      // Generate a unique key for the new cart item
      String newKey = 'cart${cartCount + 1}';

      // Add the new product data to the cart
      cart[newKey] = productData;

      transaction.update(cartDoc, {'cart': cart});
    });
  }

  Future<Map<String, dynamic>> fetchCart() async {
    DocumentSnapshot snapshot =
        await _firestore.collection('Carts').doc('C001').get();

    if (snapshot.exists) {
      return (snapshot.data() as Map<String, dynamic>?)?['cart'] ?? {};
    }

    return {};
  }

  Future<void> updateCart(Map<String, dynamic> updatedCart) async {
    await _firestore
        .collection('Carts')
        .doc('C001')
        .update({'cart': updatedCart});
  }
}
