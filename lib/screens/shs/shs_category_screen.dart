import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/shs/shs_product.dart';
import '../../models/shs/shs_supply_catalog.dart';
import '../../providers/shs_cart_provider.dart';
import '../../utils/colors.dart';
import 'shs_product_detail_screen.dart';
import 'shs_cart_screen.dart';

/// Screen that shows all products within a specific category.
class ShsCategoryScreen extends StatefulWidget {
  final String categoryId;

  const ShsCategoryScreen({super.key, required this.categoryId});

  @override
  State<ShsCategoryScreen> createState() => _ShsCategoryScreenState();
}

class _ShsCategoryScreenState extends State<ShsCategoryScreen> {
  String _sortBy = 'name'; // 'name', 'price_low', 'price_high'
  bool _showEssentialsOnly = false;

  String get _categoryName {
    final cat = ShsSupplyCatalog.categories
        .firstWhere((c) => c.id == widget.categoryId);
    return cat.name;
  }

  List<ShsProduct> get _filteredProducts {
    var products = ShsSupplyCatalog.getByCategory(widget.categoryId);

    if (_showEssentialsOnly) {
      products = products.where((p) => p.isRequired).toList();
    }

    switch (_sortBy) {
      case 'price_low':
        products.sort((a, b) => a.priceGhs.compareTo(b.priceGhs));
        break;
      case 'price_high':
        products.sort((a, b) => b.priceGhs.compareTo(a.priceGhs));
        break;
      default:
        products.sort((a, b) => a.name.compareTo(b.name));
    }

    return products;
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<ShsCartProvider>();
    final products = _filteredProducts;

    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryName),
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ShsCartScreen()),
                  );
                },
              ),
              if (cartProvider.itemCount > 0)
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.red600,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      '${cartProvider.itemCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Filters & Sort ──
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                // Sort dropdown
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.gray200),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _sortBy,
                        isExpanded: true,
                        icon: const Icon(Icons.sort,
                            color: Color(0xFF1B5E20), size: 18),
                        style: const TextStyle(
                            fontSize: 13, color: AppColors.gray800),
                        items: const [
                          DropdownMenuItem(
                              value: 'name', child: Text('Sort by Name')),
                          DropdownMenuItem(
                              value: 'price_low',
                              child: Text('Price: Low to High')),
                          DropdownMenuItem(
                              value: 'price_high',
                              child: Text('Price: High to Low')),
                        ],
                        onChanged: (val) {
                          if (val != null) setState(() => _sortBy = val);
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Essentials filter
                FilterChip(
                  label: const Text('Essentials',
                      style: TextStyle(fontSize: 12)),
                  selected: _showEssentialsOnly,
                  selectedColor: const Color(0xFFE8F5E9),
                  checkmarkColor: const Color(0xFF1B5E20),
                  onSelected: (val) {
                    setState(() => _showEssentialsOnly = val);
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // ── Products ──
          Expanded(
            child: products.isEmpty
                ? const Center(
                    child: Text('No products found',
                        style: TextStyle(color: AppColors.gray500)),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.68,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      final inCart = cartProvider.isInCart(product.id);

                      return _CategoryProductCard(
                        product: product,
                        isInCart: inCart,
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
          ),
        ],
      ),
    );
  }
}

class _CategoryProductCard extends StatelessWidget {
  final ShsProduct product;
  final bool isInCart;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  const _CategoryProductCard({
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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isInCart
                ? const Color(0xFF2E7D32).withOpacity(0.4)
                : AppColors.gray200,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(14),
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.inventory_2_outlined,
                        size: 36,
                        color: const Color(0xFF1B5E20).withOpacity(0.4),
                      ),
                    ),
                    if (product.isRequired)
                      Positioned(
                        top: 6,
                        left: 6,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF6F00),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Essential',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    if (isInCart)
                      Positioned(
                        top: 6,
                        right: 6,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Color(0xFF2E7D32),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // Info
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColors.gray900,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'GHS ${product.priceGhs.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFF1B5E20),
                        ),
                      ),
                      GestureDetector(
                        onTap: isInCart ? null : onAddToCart,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: isInCart
                                ? const Color(0xFFE8F5E9)
                                : const Color(0xFF1B5E20),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Icon(
                            isInCart ? Icons.check : Icons.add,
                            color: isInCart
                                ? const Color(0xFF2E7D32)
                                : Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
