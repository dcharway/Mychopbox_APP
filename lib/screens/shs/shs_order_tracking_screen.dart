import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class ShsOrderTrackingScreen extends StatelessWidget {
  final String orderNumber;
  const ShsOrderTrackingScreen({super.key, required this.orderNumber});

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Order Tracking', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order number header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.headerGradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Icon(Icons.local_shipping, size: 48, color: Colors.white),
                  const SizedBox(height: 12),
                  Text('Order #$orderNumber', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('Out for Delivery', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  const SizedBox(height: 8),
                  Text('Estimated Delivery: 1:30 PM', style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.8))),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Tracking timeline
            const Text('Tracking Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.gray900)),
            const SizedBox(height: 16),
            _TrackingStep(title: 'Order Placed', subtitle: 'Your order has been confirmed', time: '10:00 AM', isCompleted: true, isFirst: true),
            _TrackingStep(title: 'Processing', subtitle: 'Items are being packed', time: '10:30 AM', isCompleted: true, isFirst: false),
            _TrackingStep(title: 'Out for Delivery', subtitle: 'Your package is on the way', time: '12:00 PM', isCompleted: true, isFirst: false),
            _TrackingStep(title: 'Delivered', subtitle: 'Package delivered to your address', time: '1:30 PM', isCompleted: false, isFirst: false, isLast: true),

            const SizedBox(height: 24),

            // Map placeholder
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.gray300),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 60, color: AppColors.primary.withValues(alpha: 0.4)),
                  const SizedBox(height: 8),
                  const Text('Live Tracking Map', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.gray600)),
                  const SizedBox(height: 4),
                  const Text('Coming soon', style: TextStyle(fontSize: 12, color: AppColors.gray500)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Contact delivery
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.phone),
                label: const Text('Contact Delivery', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrackingStep extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final bool isCompleted;
  final bool isFirst;
  final bool isLast;
  const _TrackingStep({required this.title, required this.subtitle, required this.time, required this.isCompleted, required this.isFirst, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 28, height: 28,
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.primary : AppColors.gray300,
                shape: BoxShape.circle,
              ),
              child: Icon(isCompleted ? Icons.check : Icons.circle, size: 16, color: Colors.white),
            ),
            if (!isLast) Container(width: 2, height: 50, color: isCompleted ? AppColors.primary : AppColors.gray300),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isCompleted ? AppColors.gray900 : AppColors.gray500)),
                    Text(time, style: TextStyle(fontSize: 12, color: isCompleted ? AppColors.gray600 : AppColors.gray400)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(subtitle, style: TextStyle(fontSize: 13, color: isCompleted ? AppColors.gray600 : AppColors.gray400)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
