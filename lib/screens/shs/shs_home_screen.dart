import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/shs/shs_product.dart';
import '../../models/shs/shs_supply_catalog.dart';
import '../../providers/shs_cart_provider.dart';
import '../../utils/colors.dart';
import 'shs_category_screen.dart';
import 'shs_cart_screen.dart';
import 'shs_product_detail_screen.dart';
import 'shs_search_screen.dart';

class ShsHomeScreen extends StatelessWidget {
  const ShsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<ShsCartProvider>();
    final featured = ShsSupplyCatalog.getFeatured();

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Blue gradient header
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.headerGradient,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
                ),
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hi, James!',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                            SizedBox(height: 2),
                            Text('Welcome to SHS Store.',
                                style: TextStyle(fontSize: 14, color: Colors.white70)),
                          ],
                        ),
                        Row(children: [
                          IconButton(
                            icon: const Icon(Icons.search, color: Colors.white, size: 26),
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ShsSearchScreen())),
                          ),
                          _CartBadge(
                            count: cartProvider.itemCount,
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ShsCartScreen())),
                          ),
                        ]),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ShsSearchScreen())),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                        ),
                        child: Row(children: [
                          Icon(Icons.search, color: Colors.white.withValues(alpha: 0.7), size: 20),
                          const SizedBox(width: 10),
                          Text('Search for items...', style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 14)),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Category icons row 1
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _CategoryIcon(icon: Icons.fastfood, label: 'Food &\nProvisions', color: const Color(0xFFFF8F00), onTap: () => _openCategory(context, 'provisions')),
                    _CategoryIcon(icon: Icons.edit, label: 'Stationery', color: const Color(0xFF1565C0), onTap: () => _openCategory(context, 'stationery')),
                    _CategoryIcon(icon: Icons.local_shipping, label: 'Delivery', color: const Color(0xFF00897B), onTap: () {}),
                    _CategoryIcon(icon: Icons.soap, label: 'Toiletries', color: const Color(0xFF7B1FA2), onTap: () => _openCategory(context, 'toiletries')),
                  ],
                ),
              ),
            ),
            // Category icons row 2
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _CategoryIcon(icon: Icons.school, label: 'Uniforms', color: const Color(0xFF2E7D32), onTap: () => _openCategory(context, 'uniforms')),
                    _CategoryIcon(icon: Icons.menu_book, label: 'Textbooks', color: const Color(0xFFD84315), onTap: () => _openCategory(context, 'textbooks')),
                    _CategoryIcon(icon: Icons.bed, label: 'Bedding', color: const Color(0xFF5D4037), onTap: () => _openCategory(context, 'bedding')),
                    _CategoryIcon(icon: Icons.calculate, label: 'Electronics', color: const Color(0xFF455A64), onTap: () => _openCategory(context, 'electronics')),
                  ],
                ),
              ),
            ),

            // Featured Products header
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 10),
                child: Text('Featured Products', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.gray900)),
              ),
            ),

            // Featured Products grid
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.78, crossAxisSpacing: 12, mainAxisSpacing: 12,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = featured[index];
                    return _ProductCard(
                      product: product,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ShsProductDetailScreen(product: product))),
                      onAddToCart: () {
                        context.read<ShsCartProvider>().addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('${product.name} added to cart'),
                          backgroundColor: AppColors.primary,
                          duration: const Duration(seconds: 1),
                        ));
                      },
                    );
                  },
                  childCount: featured.length,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }

  void _openCategory(BuildContext context, String categoryId) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ShsCategoryScreen(categoryId: categoryId)));
  }
}

class _CartBadge extends StatelessWidget {
  final int count;
  final VoidCallback onTap;
  const _CartBadge({required this.count, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(children: [
        const Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 26)),
        if (count > 0)
          Positioned(
            right: 2, top: 2,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
              constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
              child: Text('$count', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            ),
          ),
      ]),
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _CategoryIcon({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(children: [
        Container(
          width: 56, height: 56,
          decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(16)),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.gray700), textAlign: TextAlign.center),
      ]),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ShsProduct product;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;
  const _ProductCard({required this.product, required this.onTap, required this.onAddToCart});

  IconData _iconForProduct(String category) {
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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Color(0xFFE3F2FD), borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
                child: Stack(children: [
                  Center(child: Icon(_iconForProduct(product.category), size: 48, color: AppColors.primary.withValues(alpha: 0.4))),
                  if (product.isRequired)
                    Positioned(
                      top: 8, left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(6)),
                        child: const Text('Essential', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.gray900), maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('GHS ${product.priceGhs.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary)),
                      GestureDetector(
                        onTap: onAddToCart,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
                          child: const Text('Add to Cart', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
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
