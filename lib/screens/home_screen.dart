import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import '../screens/search_screen.dart';
import '../screens/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  double _minPrice = 0;
  double _maxPrice = 1000;
  double _minRating = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts(loadMore: true);
    }
  }

  void _onSearch() {
    Provider.of<ProductProvider>(context, listen: false).searchProducts(_searchController.text);
  }

  void _clearSearch() {
    _searchController.clear();
    Provider.of<ProductProvider>(context, listen: false).clearSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Virtual Vault'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilters(context),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: _clearSearch,
                ),
              ),
              onSubmitted: (_) => _onSearch(),
            ),
          ),
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, productProvider, child) {
                if (productProvider.products.isEmpty && productProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: productProvider.products.length + 1,
                  itemBuilder: (context, index) {
                    if (index < productProvider.products.length) {
                      return ProductCard(product: productProvider.products[index]);
                    } else if (productProvider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                value: Provider.of<ProductProvider>(context).sortBy,
                items: const [
                  DropdownMenuItem(value: 'price', child: Text('Price')),
                  DropdownMenuItem(value: 'popularity', child: Text('Popularity')),
                  DropdownMenuItem(value: 'rating', child: Text('Rating')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    Provider.of<ProductProvider>(context, listen: false).setSortBy(value);
                  }
                },
              ),
              DropdownButton<String>(
                value: Provider.of<ProductProvider>(context).filterCategory,
                items: const [
                  DropdownMenuItem(value: '', child: Text('All Categories')),
                  DropdownMenuItem(value: 'electronics', child: Text('Electronics')),
                  DropdownMenuItem(value: 'fashion', child: Text('Fashion')),
                  // Add more categories as needed
                ],
                onChanged: (value) {
                  if (value != null) {
                    Provider.of<ProductProvider>(context, listen: false).setFilterCategory(value);
                  }
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Price Range:'),
              Slider(
                value: _minPrice,
                min: 0,
                max: 1000,
                divisions: 20,
                label: 'Min: \$${_minPrice.round()}',
                onChanged: (value) {
                  setState(() {
                    _minPrice = value;
                  });
                  Provider.of<ProductProvider>(context, listen: false).setPriceRange(_minPrice, _maxPrice);
                },
              ),
              Slider(
                value: _maxPrice,
                min: 0,
                max: 1000,
                divisions: 20,
                label: 'Max: \$${_maxPrice.round()}',
                onChanged: (value) {
                  setState(() {
                    _maxPrice = value;
                  });
                  Provider.of<ProductProvider>(context, listen: false).setPriceRange(_minPrice, _maxPrice);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Minimum Rating:'),
              Slider(
                value: _minRating,
                min: 0,
                max: 5,
                divisions: 5,
                label: '${_minRating.round()} stars',
                onChanged: (value) {
                  setState(() {
                    _minRating = value;
                  });
                  Provider.of<ProductProvider>(context, listen: false).setMinRating(_minRating);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
