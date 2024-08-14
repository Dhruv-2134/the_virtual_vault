import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  int _currentPage = 1;
  final int _itemsPerPage = 10;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  final ApiService _apiService = ApiService();

  Future<void> fetchProducts() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final newProducts = await _apiService.getProducts(
        limit: _itemsPerPage,
        offset: (_currentPage - 1) * _itemsPerPage,
      );
      _products.addAll(newProducts);
      _currentPage++;
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching products: $error');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchProducts(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _apiService.searchProducts(query);
    } catch (error) {
      if (kDebugMode) {
        print('Error searching products: $error');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void sortProducts({required String sortBy, required bool ascending}) {
    switch (sortBy) {
      case 'price':
        _products.sort((a, b) => ascending
            ? a.price.compareTo(b.price)
            : b.price.compareTo(a.price));
        break;
      case 'rating':
        _products.sort((a, b) => ascending
            ? a.rating['rate'].compareTo(b.rating['rate'])
            : b.rating['rate'].compareTo(a.rating['rate']));
        break;
      // Add more sorting options as needed
    }
    notifyListeners();
  }

  void filterProducts({String? category, double? minPrice, double? maxPrice, double? minRating}) {
    _products = _products.where((product) {
      bool categoryMatch = category == null || product.category == category;
      bool priceMatch = (minPrice == null || product.price >= minPrice) &&
          (maxPrice == null || product.price <= maxPrice);
      bool ratingMatch = minRating == null || product.rating['rate'] >= minRating;
      return categoryMatch && priceMatch && ratingMatch;
    }).toList();
    notifyListeners();
  }
}