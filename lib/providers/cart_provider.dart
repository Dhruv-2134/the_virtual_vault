import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartProvider with ChangeNotifier {
  Map<int, CartItem> _items = {};

  Map<int, CartItem> get items => _items;

  int get itemCount => _items.length;

  double get totalAmount {
    return _items.values
        .fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingItem) => CartItem(
          product: existingItem.product,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(product: product),
      );
    }
    notifyListeners();
  }

  void removeItem(int productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void decreaseQuantity(int productId) {
    if (!_items.containsKey(productId)) return;
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existingItem) => CartItem(
          product: existingItem.product,
          quantity: existingItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  int get totalItemCount {
    return _items.values.fold(0, (sum, item) => sum + item.quantity);
  }

  Future<bool> order() async {
    try {
      // Simulate sending order to a server
      await Future.delayed(const Duration(seconds: 2));
      
      // Create order details
      // ignore: unused_local_variable
      final orderDetails = _items.entries.map((entry) {
        return {
          'productId': entry.key,
          'productTitle': entry.value.product.title,
          'quantity': entry.value.quantity,
          'price': entry.value.product.price,
        };
      }).toList();

      // Here you would typically send orderDetails to your backend
      // For example:
      // await api.sendOrder(orderDetails);

      // Clear the cart after successful order
      clear();
      
      return true; // Order placed successfully
    } catch (error) {
      if (kDebugMode) {
        print('Error placing order: $error');
      }
      return false; // Order failed
    }
  }
}


// import 'package:flutter/material.dart';
// import '../models/cart_item.dart';

// class CartProvider with ChangeNotifier {
//   Map<String, CartItem> _items = {};

//   Map<String, CartItem> get items => _items;

//   double get totalAmount {
//     double total = 0.0;
//     _items.forEach((key, cartItem) {
//       total += cartItem.price * cartItem.quantity;
//     });
//     return total;
//   }

//   void addItem(CartItem item) {
//     if (_items.containsKey(item.id)) {
//       _items.update(
//         item.id,
//         (existingItem) => CartItem(
//           id: existingItem.id,
//           title: existingItem.title,
//           quantity: existingItem.quantity + 1,
//           price: existingItem.price,
//         ),
//       );
//     } else {
//       _items.putIfAbsent(
//         item.id,
//         () => CartItem(
//           id: item.id,
//           title: item.title,
//           quantity: 1,
//           price: item.price,
//         ),
//       );
//     }
//     notifyListeners();
//   }

//   void removeItem(String productId) {
//     _items.remove(productId);
//     notifyListeners();
//   }

//   void clear() {
//     _items = {};
//     notifyListeners();
//   }

//   Future<void> order() async {
//     // Implement your order placement logic here
//     // For example, send order details to a server
//     await Future.delayed(Duration(seconds: 2)); // Simulate network delay
//     clear();
//   }
// }
