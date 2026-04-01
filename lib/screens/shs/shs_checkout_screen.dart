import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/shs_cart_provider.dart';
import '../../utils/colors.dart';
import 'shs_order_confirmation_screen.dart';

class ShsCheckoutScreen extends StatefulWidget {
  const ShsCheckoutScreen({super.key});

  @override
  State<ShsCheckoutScreen> createState() => _ShsCheckoutScreenState();
}

class _ShsCheckoutScreenState extends State<ShsCheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  String _paymentMethod = 'Mobile Money';
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<ShsCartProvider>();

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
        title: const Text('Checkout', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Delivery Address:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.gray900)),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        hintText: 'Dormitory House, Room 12',
                        filled: true, fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.gray300)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.gray300)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
                        suffixIcon: TextButton(onPressed: () {}, child: const Text('Edit', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600))),
                      ),
                      validator: (v) => v == null || v.isEmpty ? 'Please enter delivery address' : null,
                    ),
                    const SizedBox(height: 20),
                    const Text('Special Notes:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.gray900)),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _notesController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Any special instructions...',
                        filled: true, fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.gray300)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.gray300)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text('Payment Method:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.gray900)),
                    const SizedBox(height: 10),
                    _PaymentOption(icon: Icons.phone_android, label: 'Mobile Money', isSelected: _paymentMethod == 'Mobile Money', onTap: () => setState(() => _paymentMethod = 'Mobile Money')),
                    const SizedBox(height: 8),
                    _PaymentOption(icon: Icons.money, label: 'Cash on Delivery', isSelected: _paymentMethod == 'Cash on Delivery', onTap: () => setState(() => _paymentMethod = 'Cash on Delivery')),
                    const SizedBox(height: 8),
                    _PaymentOption(icon: Icons.credit_card, label: 'Card Payment', isSelected: _paymentMethod == 'Card Payment', onTap: () => setState(() => _paymentMethod = 'Card Payment')),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.gray200)),
                      child: Column(children: [
                        _SummaryRow('Subtotal', 'GHS ${cartProvider.subtotal.toStringAsFixed(0)}'),
                        const SizedBox(height: 8),
                        _SummaryRow('Delivery Fee', cartProvider.deliveryFee > 0 ? 'GHS ${cartProvider.deliveryFee.toStringAsFixed(0)}' : 'FREE'),
                        const Divider(height: 20),
                        _SummaryRow('Total', 'GHS ${cartProvider.totalAmount.toStringAsFixed(0)}', isBold: true),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, -4))]),
              child: SizedBox(
                width: double.infinity, height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const ShsOrderConfirmationScreen()), (route) => route.isFirst);
                      cartProvider.clearCart();
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), elevation: 0),
                  child: const Text('Confirm Order', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const _PaymentOption({required this.icon, required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: isSelected ? AppColors.primary : AppColors.gray300, width: isSelected ? 2 : 1)),
        child: Row(children: [
          Icon(isSelected ? Icons.radio_button_checked : Icons.radio_button_off, color: isSelected ? AppColors.primary : AppColors.gray400, size: 22),
          const SizedBox(width: 12),
          Icon(icon, color: isSelected ? AppColors.primary : AppColors.gray600, size: 22),
          const SizedBox(width: 10),
          Text(label, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: isSelected ? AppColors.primary : AppColors.gray700)),
        ]),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  const _SummaryRow(this.label, this.value, {this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: isBold ? 16 : 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: AppColors.gray700)),
        Text(value, style: TextStyle(fontSize: isBold ? 18 : 14, fontWeight: isBold ? FontWeight.bold : FontWeight.w600, color: isBold ? AppColors.primary : AppColors.gray900)),
      ],
    );
  }
}
