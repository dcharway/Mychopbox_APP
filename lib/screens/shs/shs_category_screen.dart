import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/shs/shs_product.dart';
import '../../models/shs/shs_supply_catalog.dart';
import '../../providers/shs_cart_provider.dart';
import '../../utils/colors.dart';
import 'shs_product_detail_screen.dart';

class ShsCategoryScreen extends StatefulWidget {
  final String categoryId;
  const ShsCategoryScreen({super.key, required this.categoryId});

  @override
  State<ShsCategoryScreen> createState() => _ShsCategoryScreenState();
}

class _ShsCategoryScreenState extends State<ShsCategoryScreen> {
  String _activeFilter = 'Price';
  String _sortOrder = 'Low to High';

  @override
  Widget build(BuildContext context) {
    final products = ShsSupplyCatalog.getByCategory(widget.categoryId);
    final categoryName = _getCategoryName(widget.categoryId);

    // Sort products
    final sorted = List<ShsProduct>.from(products);
    if (_activeFilter == 'Price') {
      if (_sortOrder == 'Low to High') {
        sorted.sort((a, b) => a.priceGhs.compareTo(b.priceGhs));
      } else {
        sorted.sort((a, b) => b.priceGhs.compareTo(a.priceGhs));
      }
    } else if (_activeFilter == 'Popularity') {
      sorted.sort((a, b) => (b.isRequired ? 1 : 0).compareTo(a.isRequired ? 1 : 0));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(categoryName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Filter tabs
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    _FilterChip(label: 'Price', isActive: _activeFilter == 'Price', onTap: () => setState(() => _activeFilter = 'Price')),
                    const SizedBox(width: 8),
                    _FilterChip(label: 'Brand', isActive: _activeFilter == 'Brand', onTap: () => setState(() => _activeFilter = 'Brand')),
                    const SizedBox(width: 8),
                    _FilterChip(label: 'Popularity', isActive: _activeFilter == 'Popularity', onTap: () => setState(() => _activeFilter = 'Popularity')),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.sort, size: 16, color: AppColors.gray600),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _sortOrder = _sortOrder == 'Low to High' ? 'High to Low' : 'Low to High';
                        });
                      },
                      child: Text(_sortOrder, style: const TextStyle(fontSize: 13, color: AppColors.gray700)),
                    ),
                    const Icon(Icons.arrow_drop_down, size: 20, color: AppColors.gray600),
                  ],
                ),
              ],
            ),
          ),
          // Product list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sorted.length,
              itemBuilder: (context, index) {
                final product = sorted[index];
                return _CategoryProductTile(
                  product: product,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ShsProductDetailScreen(product: product))),
                  onAdd: () {
                    context.read<ShsCartProvider>().addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('${product.name} added to cart'),
                      backgroundColor: AppColors.primary,
                      duration: const Duration(seconds: 1),
                    ));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getCategoryName(String id) {
    switch (id) {
      case 'provisions': return 'Food & Provisions';
      case 'stationery': return 'Stationery';
      case 'uniforms': return 'Uniforms';
      case 'textbooks': return 'Textbooks & Books';
      case 'toiletries': return 'Toiletries';
      case 'bedding': return 'Bedding & Linen';
      case 'electronics': return 'Electronics';
      case 'footwear': return 'Footwear';
      default: return 'Products';
    }
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  const _FilterChip({required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isActive ? AppColors.primary : AppColors.gray300),
        ),
        child: Text(label, style: TextStyle(
          fontSize: 13, fontWeight: FontWeight.w600,
          color: isActive ? Colors.white : AppColors.gray700,
        )),
      ),
    );
  }
}

class _CategoryProductTile extends StatelessWidget {
  final ShsProduct product;
  final VoidCallback onTap;
  final VoidCallback onAdd;
  const _CategoryProductTile({required this.product, required this.onTap, required this.onAdd});

  IconData _iconForCategory(String category) {
    switch (category) {
      case 'provisions': return Icons.fastfood;
      case 'stationery': return Icons.edit;
      case 'uniforms': return Icons.school;
      case 'textbooks': return Icons.menu_book;
      case 'toiletries': return Icons.soap;
      case 'bedding': return Icons.bed;
      case 'electronics': return Icons.calculate;
      case 'footwear': return Icons.directions_walk;
      default: return Icons.inventory_2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            Container(
              width: 64, height: 64,
              decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(12)),
              child: Icon(_iconForCategory(product.category), size: 32, color: AppColors.primary.withValues(alpha: 0.5)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: AppColors.gray900)),
                  const SizedBox(height: 4),
                  Text('GHS ${product.priceGhs.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary)),
                ],
              ),
            ),
            GestureDetector(
              onTap: onAdd,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
                child: const Text('Add +', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
