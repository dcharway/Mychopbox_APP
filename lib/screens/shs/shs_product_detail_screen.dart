import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/shs/shs_product.dart';
import '../../providers/shs_cart_provider.dart';
import '../../utils/colors.dart';
import 'shs_cart_screen.dart';

class ShsProductDetailScreen extends StatefulWidget {
  final ShsProduct product;
  const ShsProductDetailScreen({super.key, required this.product});

  @override
  State<ShsProductDetailScreen> createState() => _ShsProductDetailScreenState();
}

class _ShsProductDetailScreenState extends State<ShsProductDetailScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final cartProvider = context.watch<ShsCartProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Product Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ShsCartScreen())),
              ),
              if (cartProvider.itemCount > 0)
                Positioned(
                  right: 6, top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                    constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                    child: Text('${cartProvider.itemCount}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Large product image area
                  Container(
                    width: double.infinity,
                    height: 280,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
                    ),
                    child: Center(
                      child: Icon(_iconForCategory(product.category), size: 100, color: AppColors.primary.withValues(alpha: 0.3)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product name
                        Text(product.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.gray900)),
                        const SizedBox(height: 8),
                        // Description
                        Text(product.description, style: const TextStyle(fontSize: 14, color: AppColors.gray600, height: 1.4)),
                        const SizedBox(height: 16),
                        // Price
                        Text('GHS ${product.priceGhs.toStringAsFixed(0)}',
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primary)),
                        const SizedBox(height: 20),
                        // Quantity selector
                        Row(
                          children: [
                            const Text('Quantity:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.gray800)),
                            const SizedBox(width: 16),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.gray300),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  _QtyButton(icon: Icons.remove, onTap: () { if (_quantity > 1) setState(() => _quantity--); }),
                                  Container(
                                    width: 48, alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Text('$_quantity', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  ),
                                  _QtyButton(icon: Icons.add, onTap: () => setState(() => _quantity++)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Stock status
                        Row(children: [
                          Icon(product.inStock ? Icons.check_circle : Icons.cancel, size: 18,
                              color: product.inStock ? AppColors.success : AppColors.error),
                          const SizedBox(width: 6),
                          Text(product.inStock ? 'In Stock' : 'Out of Stock',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,
                                  color: product.inStock ? AppColors.success : AppColors.error)),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Add to Cart button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, -4))],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: product.inStock ? () {
                  context.read<ShsCartProvider>().addToCart(product, quantity: _quantity);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('${product.name} (x$_quantity) added to cart'),
                    backgroundColor: AppColors.primary,
                    duration: const Duration(seconds: 1),
                  ));
                  Navigator.pop(context);
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                child: const Text('Add to Cart', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40, height: 40,
        alignment: Alignment.center,
        child: Icon(icon, size: 20, color: AppColors.primary),
      ),
    );
  }
}
