import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [];
  List<Product> _searchResults = [];
  bool _isLoading = false;
  int _currentPage = 1;
  final int _itemsPerPage = 10;
  String _currentSearchQuery = '';

  List<Product> get products => _products;
  List<Product> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String get currentSearchQuery => _currentSearchQuery;

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
    _currentSearchQuery = query;
    notifyListeners();

    try {
      if (query.isEmpty) {
        _searchResults = [];
      } else {
        _searchResults = await _apiService.searchProducts(query);
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error searching products: $error');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _searchResults = [];
    _currentSearchQuery = '';
    notifyListeners();
  }
}