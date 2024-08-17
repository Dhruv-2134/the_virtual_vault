import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }
          return ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (ctx, i) => CartItemWidget(
              cartItem: cart.items.values.toList()[i],
              productId: cart.items.keys.toList()[i],
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cart, child) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: \$${cart.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: cart.items.isNotEmpty
                          ? () => _showCheckoutDialog(context)
                          : null,
                      child: const Text('Checkout'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showCheckoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Order'),
        content: const Text('Do you want to place this order?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          ElevatedButton(
            child: const Text('Confirm'),
            onPressed: () async {
              await Provider.of<CartProvider>(context, listen: false).order();
              // ignore: use_build_context_synchronously
              Navigator.of(ctx).pop();
              // ignore: use_build_context_synchronously
              _showOrderConfirmation(context);
            },
          ),
        ],
      ),
    );
  }

  void _showOrderConfirmation(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              '../lib/assets/Order_Confirmation_Animation.json',
              width: 600,
              height: 300,
              repeat: true,
            ),
            const SizedBox(height: 20),
            const Text(
              'Order Completed!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Your order has been placed successfully.'),
          ],
        ),
        actions: [
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }
}