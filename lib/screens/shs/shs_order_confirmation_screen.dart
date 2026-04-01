import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import 'shs_order_tracking_screen.dart';

class ShsOrderConfirmationScreen extends StatelessWidget {
  const ShsOrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderNumber = DateTime.now().millisecondsSinceEpoch.toString().substring(7);

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Order Confirmed', style: TextStyle(fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100, height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle, size: 60, color: AppColors.primary),
              ),
              const SizedBox(height: 24),
              const Text('Order Placed Successfully!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.gray900)),
              const SizedBox(height: 12),
              Text('Order #$orderNumber', style: const TextStyle(fontSize: 16, color: AppColors.gray600)),
              const SizedBox(height: 8),
              const Text('Your SHS supplies are on the way!', style: TextStyle(fontSize: 14, color: AppColors.gray500), textAlign: TextAlign.center),
              const SizedBox(height: 32),
              // Track Order button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ShsOrderTrackingScreen(orderNumber: orderNumber)));
                  },
                  icon: const Icon(Icons.local_shipping),
                  label: const Text('Track Order', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary, width: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Continue Shopping', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
