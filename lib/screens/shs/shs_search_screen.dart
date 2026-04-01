import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/shs/shs_product.dart';
import '../../models/shs/shs_supply_catalog.dart';
import '../../providers/shs_cart_provider.dart';
import '../../utils/colors.dart';
import 'shs_product_detail_screen.dart';

/// Search screen for browsing and finding SHS supplies.
class ShsSearchScreen extends StatefulWidget {
  const ShsSearchScreen({super.key});

  @override
  State<ShsSearchScreen> createState() => _ShsSearchScreenState();
}

class _ShsSearchScreenState extends State<ShsSearchScreen> {
  final _searchController = TextEditingController();
  List<ShsProduct> _results = [];
  bool _hasSearched = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() {
      _hasSearched = query.isNotEmpty;
      _results = query.isEmpty ? [] : ShsSupplyCatalog.search(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<ShsCartProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            hintText: 'Search school supplies...',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          onChanged: _performSearch,
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                _performSearch('');
              },
            ),
        ],
      ),
      body: !_hasSearched
          ? _buildSuggestions()
          : _results.isEmpty
              ? _buildNoResults()
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _results.length,
                  itemBuilder: (context, index) {
                    final product = _results[index];
                    final isInCart = cartProvider.isInCart(product.id);
                    return _SearchResultTile(
                      product: product,
                      isInCart: isInCart,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ShsProductDetailScreen(product: product),
                          ),
                        );
                      },
                      onAddToCart: () {
                        cartProvider.addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('${product.name} added to cart'),
                            backgroundColor: const Color(0xFF2E7D32),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }

  Widget _buildSuggestions() {
    final suggestions = [
      'Uniforms',
      'Textbooks',
      'Milo',
      'Exercise Books',
      'Calculator',
      'Trunk',
      'Bedding',
      'Stationery',
      'Soap',
      'Provisions',
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Popular Searches',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.gray800,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: suggestions.map((s) {
              return GestureDetector(
                onTap: () {
                  _searchController.text = s;
                  _performSearch(s);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF1B5E20).withOpacity(0.2),
                    ),
                  ),
                  child: Text(
                    s,
                    style: const TextStyle(
                      color: Color(0xFF1B5E20),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: AppColors.gray400.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'No items found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.gray800,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Try a different search term',
            style: TextStyle(color: AppColors.gray500),
          ),
        ],
      ),
    );
  }
}

class _SearchResultTile extends StatelessWidget {
  final ShsProduct product;
  final bool isInCart;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  const _SearchResultTile({
    required this.product,
    required this.isInCart,
    required this.onTap,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.gray200),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.inventory_2_outlined,
                color: const Color(0xFF1B5E20).withOpacity(0.5),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.gray900,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _categoryLabel(product.category),
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.gray500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'GHS ${product.priceGhs.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF1B5E20),
                    ),
                  ),
                ],
              ),
            ),
            if (product.isRequired)
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6F00).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Essential',
                  style: TextStyle(
                    color: Color(0xFFFF6F00),
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            GestureDetector(
              onTap: isInCart ? null : onAddToCart,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isInCart
                      ? const Color(0xFFE8F5E9)
                      : const Color(0xFF1B5E20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isInCart ? Icons.check : Icons.add,
                  color: isInCart
                      ? const Color(0xFF2E7D32)
                      : Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _categoryLabel(String categoryId) {
    switch (categoryId) {
      case 'uniforms':
        return 'Uniforms & Clothing';
      case 'textbooks':
        return 'Textbooks & Books';
      case 'stationery':
        return 'Stationery';
      case 'provisions':
        return 'Provisions & Food';
      case 'toiletries':
        return 'Toiletries';
      case 'bedding':
        return 'Bedding & Trunk';
      case 'electronics':
        return 'Electronics';
      case 'footwear':
        return 'Footwear';
      default:
        return categoryId;
    }
  }
}
