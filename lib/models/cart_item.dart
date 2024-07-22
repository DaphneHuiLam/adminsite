// lib/models/cart_item.dart
// wf - 15 lines
// lib/helper/cart_item.dart

class CartItem {
  final String name;
  final double price;
  final String imageUrl;
  bool isSelected;

  CartItem({
    required this.name,
    required this.price,
    required this.imageUrl,
    this.isSelected = false,
  });
}

List<CartItem> cartItems = [];
