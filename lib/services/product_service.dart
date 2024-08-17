import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/product.dart';

class ProductService {
  static Future<List<Product>> fetchProducts({
    required int page,
    required String sortBy,
    required String category,
    required double minPrice,
    required double maxPrice,
    required double minRating,
  }) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}${ApiConfig.productsEndpoint}?page=$page&sortBy=$sortBy&category=$category&minPrice=$minPrice&maxPrice=$maxPrice&minRating=$minRating'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<List<Product>> searchProducts(String query) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}${ApiConfig.productsEndpoint}?search=$query'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search products');
    }
  }
}
