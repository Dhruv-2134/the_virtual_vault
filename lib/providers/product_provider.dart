import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> _searchResults = [];
  bool _isLoading = false;
  int _page = 1;
  String _sortBy = 'price';
  String _filterCategory = '';
  double _minPrice = 0;
  double _maxPrice = double.infinity;
  double _minRating = 0;
  String _currentSearchQuery = '';

  List<Product> get products => _currentSearchQuery.isEmpty ? _products : _searchResults;
  List<Product> get searchResults => _searchResults;
  String get currentSearchQuery => _currentSearchQuery;
  String get filterCategory => _filterCategory;
  String get sortBy => _sortBy;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts({bool loadMore = false}) async {
    if (loadMore) {
      _page++;
    } else {
      _page = 1;
      _products = [];
    }
    _isLoading = true;
    notifyListeners();

    final newProducts = await ProductService.fetchProducts(
      page: _page,
      sortBy: _sortBy,
      category: _filterCategory,
      minPrice: _minPrice,
      maxPrice: _maxPrice,
      minRating: _minRating,
    );

    _products.addAll(newProducts);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> searchProducts(String query) async {
    _isLoading = true;
    _currentSearchQuery = query;
    notifyListeners();

    try {
      if (query.isEmpty) {
        _searchResults = [];
      } else {
        _searchResults = await ProductService.searchProducts(query);
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

  void setSortBy(String sortBy) {
    _sortBy = sortBy;
    fetchProducts();
  }

  void setFilterCategory(String category) {
    _filterCategory = category;
    fetchProducts();
  }

  void setPriceRange(double minPrice, double maxPrice) {
    _minPrice = minPrice;
    _maxPrice = maxPrice;
    fetchProducts();
  }

  void setMinRating(double minRating) {
    _minRating = minRating;
    fetchProducts();
  }
}
