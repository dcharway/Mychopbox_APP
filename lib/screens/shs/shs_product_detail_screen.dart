import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/shs/shs_product.dart';
import '../../providers/shs_cart_provider.dart';
import '../../utils/colors.dart';
import 'shs_cart_screen.dart';

/// Detailed view for a single SHS supply product.
class ShsProductDetailScreen extends StatefulWidget {
  final ShsProduct product;

  const ShsProductDetailScreen({super.key, required this.product});

  @override
  State<ShsProductDetailScreen> createState() =>
      _ShsProductDetailScreenState();
}

class _ShsProductDetailScreenState extends State<ShsProductDetailScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<ShsCartProvider>();
    final isInCart = cartProvider.isInCart(widget.product.id);
    final cartQty = cartProvider.getQuantity(widget.product.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Product Image Area ──
            Container(
              height: 260,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFE8F5E9),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.inventory_2_outlined,
                      size: 80,
                      color: const Color(0xFF1B5E20).withOpacity(0.3),
                    ),
                  ),
                  if (widget.product.isRequired)
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6F00),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.white, size: 14),
                            SizedBox(width: 4),
                            Text(
                              'Essential Item',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Name & Price ──
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.gray900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'GHS ${widget.product.priceGhs.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5E20),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // ── Category & Stock ──
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _categoryLabel(widget.product.category),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF2E7D32),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: widget.product.inStock
                              ? const Color(0xFFE8F5E9)
                              : AppColors.red50,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          widget.product.inStock
                              ? 'In Stock'
                              : 'Out of Stock',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: widget.product.inStock
                                ? const Color(0xFF2E7D32)
                                : AppColors.red600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 12),

                  // ── Description ──
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.gray900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    style: const TextStyle(
                      color: AppColors.gray700,
                      height: 1.6,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Already in cart indicator ──
                  if (isInCart)
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFF2E7D32).withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle,
                              color: Color(0xFF2E7D32), size: 20),
                          const SizedBox(width: 8),
                          Text(
                            '$cartQty already in cart',
                            style: const TextStyle(
                              color: Color(0xFF2E7D32),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                  // ── Quantity Selector ──
                  const Text(
                    'Quantity',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.gray900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildQtyButton(Icons.remove, () {
                        if (_quantity > 1) setState(() => _quantity--);
                      }),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          '$_quantity',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildQtyButton(Icons.add, () {
                        setState(() => _quantity++);
                      }),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ── Order Summary ──
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _summaryRow(
                          'Unit Price',
                          'GHS ${widget.product.priceGhs.toStringAsFixed(2)}',
                        ),
                        _summaryRow('Quantity', '$_quantity'),
                        const Divider(height: 16),
                        _summaryRow(
                          'Subtotal',
                          'GHS ${(widget.product.priceGhs * _quantity).toStringAsFixed(2)}',
                          bold: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Add to Cart Button ──
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: widget.product.inStock
                          ? () {
                              cartProvider.addToCart(widget.product,
                                  quantity: _quantity);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${widget.product.name} (x$_quantity) added to cart',
                                  ),
                                  backgroundColor: const Color(0xFF2E7D32),
                                  action: SnackBarAction(
                                    label: 'View Cart',
                                    textColor: Colors.white,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const ShsCartScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            }
                          : null,
                      icon: const Icon(Icons.add_shopping_cart),
                      label: Text(
                        isInCart ? 'Add More to Cart' : 'Add to Cart',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1B5E20),
                        foregroundColor: Colors.white,
                        padding:
                            const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xFFE8F5E9),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: const Color(0xFF1B5E20).withOpacity(0.3)),
        ),
        child: Icon(icon, color: const Color(0xFF1B5E20)),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.gray600,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.w500,
              color: bold ? const Color(0xFF1B5E20) : AppColors.gray900,
              fontSize: bold ? 16 : 14,
            ),
          ),
        ],
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
