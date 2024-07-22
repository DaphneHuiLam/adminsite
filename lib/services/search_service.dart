// lib/services/search_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/search_result.dart';

class SearchService {
  final FirebaseFirestore firestore;

  SearchService({required this.firestore});

  Future<List<SearchResult>> search(String query) async {
    final List<SearchResult> results = [];

    // Search Orders Collection
    QuerySnapshot ordersSnapshot = await firestore
        .collection('Orders')
        .where('orderID', isGreaterThanOrEqualTo: query)
        .where('orderID', isLessThanOrEqualTo: query + '\uf8ff')
        .get();
    results.addAll(ordersSnapshot.docs.map((doc) {
      return SearchResult(
        id: doc.id,
        title: doc['orderID'],
        description: 'Order',
      );
    }).toList());

    // Search Products Collection
    QuerySnapshot productsSnapshot = await firestore
        .collection('Products')
        .where('productName', isGreaterThanOrEqualTo: query)
        .where('productName', isLessThanOrEqualTo: query + '\uf8ff')
        .get();
    results.addAll(productsSnapshot.docs.map((doc) {
      return SearchResult(
        id: doc.id,
        title: doc['productName'],
        description: 'Product',
      );
    }).toList());

    // Search Users Collection
    QuerySnapshot usersSnapshot = await firestore
        .collection('Users')
        .where('irName', isGreaterThanOrEqualTo: query)
        .where('irName', isLessThanOrEqualTo: query + '\uf8ff')
        .get();
    results.addAll(usersSnapshot.docs.map((doc) {
      return SearchResult(
        id: doc.id,
        title: doc['irName'],
        description: 'User',
      );
    }).toList());

    // Search ThirdPartyCollect Collection
    QuerySnapshot thirdPartyCollectSnapshot = await firestore
        .collection('ThirdPartyCollect')
        .where('orderID', isGreaterThanOrEqualTo: query)
        .where('orderID', isLessThanOrEqualTo: query + '\uf8ff')
        .get();
    results.addAll(thirdPartyCollectSnapshot.docs.map((doc) {
      return SearchResult(
        id: doc.id,
        title: doc['orderID'],
        description: 'Third Party Collect',
      );
    }).toList());

    return results.toSet().toList();
  }
}
