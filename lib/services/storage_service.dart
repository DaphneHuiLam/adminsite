// lib/services/storage_service.dart

import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadFile(File file) async {
    try {
      String fileName = file.path.split('/').last;
      Reference ref = _storage.ref().child('profile_pictures/$fileName');
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<String> getDownloadURL(String url) async {
    try {
      print("Getting download URL for: $url");
      if (url.startsWith('gs://')) {
        final ref = _storage.refFromURL(url);
        String downloadUrl = await ref.getDownloadURL();
        print("Download URL: $downloadUrl");
        return downloadUrl;
      } else if (url.startsWith('http') || url.startsWith('https')) {
        return url; // 直接返回 HTTP/HTTPS URL
      } else {
        throw Exception('Invalid URL');
      }
    } catch (e) {
      print("Error getting download URL: $e");
      rethrow;
    }
  }
}

/*
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadFile(File file) async {
    try {
      String fileName = file.path.split('/').last;
      Reference ref = _storage.ref().child('profile_pictures/$fileName');
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<String> getDownloadURL(String url) async {
    try {
      print("Getting download URL for: $url");
      if (url.startsWith('gs://')) {
        final ref = _storage.refFromURL(url);
        String downloadUrl = await ref.getDownloadURL();
        print("Download URL: $downloadUrl");
        return downloadUrl;
      } else if (url.startsWith('http') || url.startsWith('https')) {
        return url; // 直接返回 HTTP/HTTPS URL
      } else {
        throw Exception('Invalid URL');
      }
    } catch (e) {
      print("Error getting download URL: $e");
      rethrow;
    }
  }
}
*/