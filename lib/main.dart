import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_virtual_vault/screens/auth_screen.dart';
import 'package:the_virtual_vault/screens/cart_screen.dart';
import 'package:the_virtual_vault/screens/profile_screen.dart';
import 'package:the_virtual_vault/providers/auth_provider.dart';
import './providers/product_provider.dart';
import './providers/cart_provider.dart';
import './screens/home_screen.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.blue,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
    secondary: Colors.orangeAccent,
  ),
  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(fontSize: 14.0),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'E-commerce App',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (ctx) => const HomeScreen(),
          '/cart': (ctx) => const CartScreen(),
          '/profile': (ctx) => const ProfileScreen(), // Use ProfileScreen here
          '/auth': (ctx) => const AuthScreen(),
        },
      ),
    );
  }
}
