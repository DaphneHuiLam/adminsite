// lib/services/firestore_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference companiesCollection =
      FirebaseFirestore.instance.collection('companies');
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<int> getAttendeeCount(String companyName) async {
    final usersSnapshot = await getUsersForSimilarCompany(companyName);
    return usersSnapshot.length; // Return the length of the list
  }

  Future<void> updateAttendeeCount(String companyId, int attendeeCount) async {
    await companiesCollection.doc(companyId).update({
      'attendeeCount': attendeeCount,
    });
  }

  Future<List<QueryDocumentSnapshot>> getUsersForSimilarCompany(
      String companyName) async {
    // Normalize the companyName to lowercase to handle case-insensitive matching
    final normalizedCompanyName = companyName.toLowerCase();

    // Use a Firestore query to match companies by comparing normalized strings
    final usersSnapshot = await usersCollection.get();
    final similarUsers = usersSnapshot.docs.where((doc) {
      final userCompany = (doc['company'] ?? '').toString().toLowerCase();
      return userCompany.contains(normalizedCompanyName);
    }).toList();

    return similarUsers; // Return the list of matching documents
  }
}
