import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/product.dart';

class ApiService {
  Future<List<Product>> getProducts({int limit = 10, int offset = 0}) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}${ApiConfig.productsEndpoint}?limit=$limit&offset=$offset'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Product> getProductDetails(int productId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}${ApiConfig.productsEndpoint}/$productId'),
    );

    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load product details');
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}${ApiConfig.productsEndpoint}?title_like=$query'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search products');
    }
  }
}