import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/shs_cart_provider.dart';
import '../../utils/colors.dart';
import 'shs_checkout_screen.dart';

class ShsCartScreen extends StatelessWidget {
  const ShsCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<ShsCartProvider>();
    final items = cartProvider.items;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Shopping Cart', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 80, color: AppColors.primary.withValues(alpha: 0.3)),
                  const SizedBox(height: 16),
                  const Text('Your cart is empty', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.gray600)),
                  const SizedBox(height: 8),
                  const Text('Start adding SHS supplies!', style: TextStyle(fontSize: 14, color: AppColors.gray500)),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
                        ),
                        child: Row(
                          children: [
                            // Product icon/image
                            Container(
                              width: 60, height: 60,
                              decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(10)),
                              child: Icon(_iconForCategory(item.product.category), size: 30, color: AppColors.primary.withValues(alpha: 0.5)),
                            ),
                            const SizedBox(width: 14),
                            // Product details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.product.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.gray900), maxLines: 2, overflow: TextOverflow.ellipsis),
                                  const SizedBox(height: 4),
                                  Text('Qty: ${item.quantity}', style: const TextStyle(fontSize: 13, color: AppColors.gray600)),
                                ],
                              ),
                            ),
                            // Price and controls
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('GHS ${(item.product.priceGhs * item.quantity).toStringAsFixed(0)}',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary)),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _SmallIconBtn(icon: Icons.remove, onTap: () => cartProvider.decrementQuantity(item.product.id)),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                    ),
                                    _SmallIconBtn(icon: Icons.add, onTap: () => cartProvider.incrementQuantity(item.product.id)),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () => cartProvider.removeFromCart(item.product.id),
                                      child: const Icon(Icons.delete_outline, size: 20, color: AppColors.error),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Total and checkout
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, -4))],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.gray900)),
                          Text('GHS ${cartProvider.totalAmount.toStringAsFixed(0)}',
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary)),
                        ],
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ShsCheckoutScreen())),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            elevation: 0,
                          ),
                          child: const Text('Proceed to Checkout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
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

class _SmallIconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _SmallIconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28, height: 28,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gray300),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 16, color: AppColors.primary),
      ),
    );
  }
}
