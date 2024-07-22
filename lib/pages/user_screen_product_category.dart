// lib/pages/user_screen_product_category.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import '../widgets/back_button.dart'; // Updated import
import 'user_screen_cart.dart'; // Updated import
import 'user_screen_watch.dart'; // Updated import
import 'user_screen_wellness.dart'; // Updated import
import 'user_screen_product_info.dart'; // Updated import

class UserScreenProductCategory extends StatelessWidget {
  const UserScreenProductCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 50.0,
                  left: 25,
                ),
                child: Row(
                  children: [
                    CustomBackButton(), // Updated to use CustomBackButton
                  ],
                ),
              ),
              // VCON icon and cart icon
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FutureBuilder<String>(
                          future: _getIconUrl('icon/VCON.jpeg'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircleAvatar(
                                radius: 24,
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return CircleAvatar(
                                radius: 24,
                                child: Icon(Icons.error),
                              );
                            } else {
                              return CircleAvatar(
                                backgroundImage: NetworkImage(snapshot.data!),
                                radius: 24,
                              );
                            }
                          },
                        ),
                        SizedBox(width: 8),
                        Text(
                          'VCON',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UserScreenCart()), // Updated to UserScreenCart
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Search bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              // Categories
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              _buildCategories(context),
              // Featured products
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Featured products',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              _buildFeaturedProducts(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    final categories = [
      {
        'name': 'Watches',
        'iconPath': 'icon/Watch.jpg',
        'collection': 'Watches'
      },
      {
        'name': 'Jewellery',
        'iconPath': 'icon/Jewellery.jpg',
        'collection': 'Jewellery'
      },
      {
        'name': 'HomePure',
        'iconPath': 'icon/Homepure.jpg',
        'collection': 'HomePure'
      },
      {
        'name': 'Wellness',
        'iconPath': 'icon/Wellness.jpg',
        'collection': 'Wellness'
      },
      {
        'name': 'SkinCare',
        'iconPath': 'icon/Skincare.jpg',
        'collection': 'SkinCare'
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 6.0,
        runSpacing: 8.0,
        children: categories.map((category) {
          return FutureBuilder<String>(
            future: _getIconUrl(category['iconPath'] as String),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircleAvatar(
                  radius: 30,
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.error),
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    final collection = category['collection'] as String;
                    switch (collection) {
                      case 'Watches':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UserScreenWatch(), // Updated to UserScreenWatch
                          ),
                        );
                        break;
                      case 'Wellness':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UserScreenWellness(), // Updated to UserScreenWellness
                          ),
                        );
                        break;
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(snapshot.data!),
                      ),
                      SizedBox(height: 8),
                      Text(category['name'] as String),
                    ],
                  ),
                );
              }
            },
          );
        }).toList(),
      ),
    );
  }

  Future<String> _getIconUrl(String iconPath) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(iconPath);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error fetching icon URL: $e');
      return '';
    }
  }

  Widget _buildFeaturedProducts(BuildContext context) {
    final List<String> featuredProductIDs = [
      'W031',
      'W032',
      'W033',
      'WN001',
      'WN002',
      'WN003'
    ];

    return FutureBuilder<Map<String, List<DocumentSnapshot>>>(
      future: _fetchFeaturedProducts(featuredProductIDs),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final wellnessProducts = snapshot.data?['Wellness'] ?? [];
        final watchProducts = snapshot.data?['Watches'] ?? [];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildProductList(context, wellnessProducts)),
              SizedBox(width: 16),
              Expanded(child: _buildProductList(context, watchProducts)),
            ],
          ),
        );
      },
    );
  }

  Future<Map<String, List<DocumentSnapshot>>> _fetchFeaturedProducts(
      List<String> featuredProductIDs) async {
    List<DocumentSnapshot> allWellnessProducts = [];
    List<DocumentSnapshot> allWatchProducts = [];

    QuerySnapshot watchesSnapshot = await FirebaseFirestore.instance
        .collection('Watches')
        .where('productID', whereIn: featuredProductIDs)
        .get();
    allWatchProducts.addAll(watchesSnapshot.docs);

    QuerySnapshot wellnessSnapshot = await FirebaseFirestore.instance
        .collection('Wellness')
        .where('productID', whereIn: featuredProductIDs)
        .get();
    allWellnessProducts.addAll(wellnessSnapshot.docs);

    return {'Wellness': allWellnessProducts, 'Watches': allWatchProducts};
  }

  Widget _buildProductList(
      BuildContext context, List<DocumentSnapshot> products) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index].data() as Map<String, dynamic>?;

        String name = product?['productName'] ?? 'Unknown';
        double price = (product?['salesPrice'] ?? 0) > 0
            ? (product?['salesPrice'] is int
                ? (product?['salesPrice'] as int).toDouble()
                : product?['salesPrice'])
            : (product?['irPrice'] is int
                    ? (product?['irPrice'] as int).toDouble()
                    : product?['irPrice']) ??
                0.0;
        String imagePath = product?['imagePath'] ?? '';

        return FutureBuilder<String>(
          future: _getImageUrl(imagePath),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error loading image'));
            }
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserScreenProductInfo(
                        productID: product?[
                            'productID']), // Updated to UserScreenProductInfo
                  ),
                );
              },
              child: _buildProductTile(name, price, snapshot.data ?? ''),
            );
          },
        );
      },
    );
  }

  Future<String> _getImageUrl(String imagePath) async {
    if (imagePath.isEmpty) return '';
    try {
      final ref = FirebaseStorage.instance.refFromURL(imagePath);
      return await ref.getDownloadURL();
    } catch (e) {
      return '';
    }
  }

  Widget _buildProductTile(String name, double price, String imageUrl) {
    final NumberFormat currencyFormat = NumberFormat.currency(symbol: 'RM');

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 40,
              child: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(currencyFormat.format(price),
                style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
