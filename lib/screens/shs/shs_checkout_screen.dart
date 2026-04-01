import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/shs/shs_product.dart';
import '../../providers/shs_cart_provider.dart';
import '../../utils/colors.dart';
import 'shs_order_confirmation_screen.dart';

/// Checkout screen where parents fill in student info and confirm order.
class ShsCheckoutScreen extends StatefulWidget {
  const ShsCheckoutScreen({super.key});

  @override
  State<ShsCheckoutScreen> createState() => _ShsCheckoutScreenState();
}

class _ShsCheckoutScreenState extends State<ShsCheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _studentNameCtrl = TextEditingController();
  final _schoolNameCtrl = TextEditingController();
  final _houseCtrl = TextEditingController();
  final _parentNameCtrl = TextEditingController();
  final _parentPhoneCtrl = TextEditingController();
  final _parentEmailCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();

  String _formLevel = 'Form 1';
  String _region = 'Greater Accra';
  String _paymentMethod = 'momo';
  bool _isProcessing = false;

  static const List<String> _formLevels = ['Form 1', 'Form 2', 'Form 3'];
  static const List<String> _regions = [
    'Greater Accra',
    'Ashanti',
    'Central',
    'Western',
    'Eastern',
    'Volta',
    'Northern',
    'Upper East',
    'Upper West',
    'Bono',
    'Bono East',
    'Ahafo',
    'Western North',
    'Oti',
    'North East',
    'Savannah',
  ];

  @override
  void dispose() {
    _studentNameCtrl.dispose();
    _schoolNameCtrl.dispose();
    _houseCtrl.dispose();
    _parentNameCtrl.dispose();
    _parentPhoneCtrl.dispose();
    _parentEmailCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  void _processOrder() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isProcessing = true);

    final cartProvider = context.read<ShsCartProvider>();

    // Save student info
    cartProvider.setStudentInfo(
      StudentInfo(
        studentName: _studentNameCtrl.text.trim(),
        schoolName: _schoolNameCtrl.text.trim(),
        formLevel: _formLevel,
        house: _houseCtrl.text.trim().isNotEmpty
            ? _houseCtrl.text.trim()
            : null,
        parentName: _parentNameCtrl.text.trim(),
        parentPhone: _parentPhoneCtrl.text.trim(),
        parentEmail: _parentEmailCtrl.text.trim().isNotEmpty
            ? _parentEmailCtrl.text.trim()
            : null,
        deliveryAddress: _addressCtrl.text.trim().isNotEmpty
            ? _addressCtrl.text.trim()
            : null,
        region: _region,
      ),
    );

    // Simulate order processing delay
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _isProcessing = false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ShsOrderConfirmationScreen(
            studentName: _studentNameCtrl.text.trim(),
            schoolName: _schoolNameCtrl.text.trim(),
            totalAmount: cartProvider.totalAmount,
            itemCount: cartProvider.totalQuantity,
            paymentMethod: _paymentMethod,
          ),
        ),
      );
      // Clear cart after successful order
      cartProvider.clearCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<ShsCartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Order Summary Card ──
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF1B5E20).withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.shopping_bag,
                        color: Color(0xFF1B5E20), size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${cartProvider.totalQuantity} items in cart',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1B5E20),
                            ),
                          ),
                          Text(
                            'Total: GHS ${cartProvider.totalAmount.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(0xFF1B5E20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Student Information ──
              _sectionHeader(Icons.school, 'Student Information'),
              const SizedBox(height: 12),

              _buildTextField(
                controller: _studentNameCtrl,
                label: 'Student\'s Full Name',
                hint: 'e.g., Kwame Asante',
                icon: Icons.person,
                validator: (val) =>
                    val == null || val.trim().isEmpty
                        ? 'Please enter student\'s name'
                        : null,
              ),
              const SizedBox(height: 12),

              _buildTextField(
                controller: _schoolNameCtrl,
                label: 'School Name',
                hint: 'e.g., Achimota School',
                icon: Icons.account_balance,
                validator: (val) =>
                    val == null || val.trim().isEmpty
                        ? 'Please enter school name'
                        : null,
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildDropdown(
                      label: 'Form Level',
                      value: _formLevel,
                      items: _formLevels,
                      onChanged: (val) {
                        if (val != null) setState(() => _formLevel = val);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField(
                      controller: _houseCtrl,
                      label: 'House (Optional)',
                      hint: 'e.g., Blue House',
                      icon: Icons.home,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ── Parent / Guardian Information ──
              _sectionHeader(Icons.family_restroom, 'Parent / Guardian'),
              const SizedBox(height: 12),

              _buildTextField(
                controller: _parentNameCtrl,
                label: 'Parent\'s Full Name',
                hint: 'e.g., Ama Asante',
                icon: Icons.person_outline,
                validator: (val) =>
                    val == null || val.trim().isEmpty
                        ? 'Please enter parent\'s name'
                        : null,
              ),
              const SizedBox(height: 12),

              _buildTextField(
                controller: _parentPhoneCtrl,
                label: 'Phone Number',
                hint: 'e.g., 024 XXX XXXX',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter phone number';
                  }
                  if (val.trim().length < 10) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              _buildTextField(
                controller: _parentEmailCtrl,
                label: 'Email (Optional)',
                hint: 'e.g., parent@email.com',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 24),

              // ── Delivery ──
              _sectionHeader(Icons.local_shipping, 'Delivery'),
              const SizedBox(height: 12),

              _buildDropdown(
                label: 'Region',
                value: _region,
                items: _regions,
                onChanged: (val) {
                  if (val != null) setState(() => _region = val);
                },
              ),
              const SizedBox(height: 12),

              _buildTextField(
                controller: _addressCtrl,
                label: 'Delivery Address (Optional)',
                hint: 'e.g., East Legon, Accra or deliver to school',
                icon: Icons.location_on,
                maxLines: 2,
              ),

              const SizedBox(height: 24),

              // ── Payment Method ──
              _sectionHeader(Icons.payment, 'Payment Method'),
              const SizedBox(height: 12),

              _buildPaymentOption(
                'momo',
                'Mobile Money (MoMo)',
                'Pay via MTN, Vodafone Cash, or AirtelTigo Money',
                Icons.phone_android,
              ),
              const SizedBox(height: 8),
              _buildPaymentOption(
                'cod',
                'Cash on Delivery',
                'Pay when supplies are delivered',
                Icons.payments,
              ),

              const SizedBox(height: 24),

              // ── Final Summary ──
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.gray100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _orderRow('Subtotal',
                        'GHS ${cartProvider.subtotal.toStringAsFixed(2)}'),
                    _orderRow(
                      'Delivery Fee',
                      cartProvider.deliveryFee == 0
                          ? 'FREE'
                          : 'GHS ${cartProvider.deliveryFee.toStringAsFixed(2)}',
                    ),
                    const Divider(height: 16),
                    _orderRow(
                      'Total',
                      'GHS ${cartProvider.totalAmount.toStringAsFixed(2)}',
                      bold: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── Place Order Button ──
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isProcessing ? null : _processOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B5E20),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    disabledBackgroundColor:
                        const Color(0xFF1B5E20).withOpacity(0.6),
                  ),
                  child: _isProcessing
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 12),
                            Text('Processing Order...',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                          ],
                        )
                      : Text(
                          'Place Order — GHS ${cartProvider.totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ── Helper Widgets ──

  Widget _sectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF1B5E20), size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.gray900,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    IconData? icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon != null
            ? Icon(icon, color: const Color(0xFF1B5E20), size: 20)
            : null,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.gray200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.gray200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: Color(0xFF1B5E20), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.red600),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.gray200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.gray200),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items: items
              .map((item) =>
                  DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildPaymentOption(
    String value,
    String title,
    String subtitle,
    IconData icon,
  ) {
    final isSelected = _paymentMethod == value;
    return GestureDetector(
      onTap: () => setState(() => _paymentMethod = value),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8F5E9) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF1B5E20)
                : AppColors.gray200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon,
                color: isSelected
                    ? const Color(0xFF1B5E20)
                    : AppColors.gray500),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? const Color(0xFF1B5E20)
                          : AppColors.gray900,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                        fontSize: 11, color: AppColors.gray500),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: isSelected
                  ? const Color(0xFF1B5E20)
                  : AppColors.gray400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _orderRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                color: AppColors.gray600,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              )),
          Text(value,
              style: TextStyle(
                fontWeight: bold ? FontWeight.bold : FontWeight.w500,
                color: bold ? const Color(0xFF1B5E20) : AppColors.gray900,
                fontSize: bold ? 16 : 14,
              )),
        ],
      ),
    );
  }
}
