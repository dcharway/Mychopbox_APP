import 'package:flutter/material.dart';
import '../../utils/colors.dart';

/// Order confirmation screen shown after successful checkout.
class ShsOrderConfirmationScreen extends StatelessWidget {
  final String studentName;
  final String schoolName;
  final double totalAmount;
  final int itemCount;
  final String paymentMethod;

  const ShsOrderConfirmationScreen({
    super.key,
    required this.studentName,
    required this.schoolName,
    required this.totalAmount,
    required this.itemCount,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Success icon
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF2E7D32).withOpacity(0.3),
                        width: 3,
                      ),
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      size: 60,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Order Confirmed!',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5E20),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Your SHS supplies order has been placed successfully.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.gray600,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 32),

                  // Order details card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.gray200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _detailRow(
                            Icons.person, 'Student', studentName),
                        const Divider(height: 20),
                        _detailRow(Icons.school, 'School', schoolName),
                        const Divider(height: 20),
                        _detailRow(Icons.shopping_bag, 'Items',
                            '$itemCount items'),
                        const Divider(height: 20),
                        _detailRow(
                          Icons.payment,
                          'Payment',
                          paymentMethod == 'momo'
                              ? 'Mobile Money'
                              : 'Cash on Delivery',
                        ),
                        const Divider(height: 20),
                        Row(
                          children: [
                            const Icon(Icons.monetization_on,
                                color: Color(0xFF1B5E20), size: 20),
                            const SizedBox(width: 12),
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.gray900,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'GHS ${totalAmount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color(0xFF1B5E20),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Info note
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8E1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFFFFB300).withOpacity(0.3),
                      ),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info_outline,
                            color: Color(0xFFFF6F00), size: 20),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'You will receive an SMS confirmation with your '
                            'order details and tracking information. '
                            'Delivery typically takes 2-5 business days '
                            'depending on your location.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF5D4037),
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Return button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Pop back to the SHS home or app home
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1B5E20),
                        foregroundColor: Colors.white,
                        padding:
                            const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Back to Home',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Continue shopping button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF1B5E20),
                        side: const BorderSide(
                            color: Color(0xFF1B5E20)),
                        padding:
                            const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Continue Shopping',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors.gray500, size: 20),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.gray500,
            fontSize: 13,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.gray900,
          ),
        ),
      ],
    );
  }
}
