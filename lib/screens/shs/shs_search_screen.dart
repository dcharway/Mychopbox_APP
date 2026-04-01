import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/shs/shs_product.dart';
import '../../models/shs/shs_supply_catalog.dart';
import '../../providers/shs_cart_provider.dart';
import '../../utils/colors.dart';
import 'shs_product_detail_screen.dart';

class ShsSearchScreen extends StatefulWidget {
  const ShsSearchScreen({super.key});

  @override
  State<ShsSearchScreen> createState() => _ShsSearchScreenState();
}

class _ShsSearchScreenState extends State<ShsSearchScreen> {
  final _searchController = TextEditingController();
  List<ShsProduct> _results = [];
  bool _hasSearched = false;

  final List<String> _suggestions = [
    'Uniforms', 'Textbooks', 'Milo', 'Calculator',
    'Sardines', 'Bedsheets', 'Soap', 'Notebooks',
  ];

  void _search(String query) {
    setState(() {
      _hasSearched = query.isNotEmpty;
      _results = query.isEmpty ? [] : ShsSupplyCatalog.search(query);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
        title: Container(
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            style: const TextStyle(color: Colors.white, fontSize: 15),
            decoration: InputDecoration(
              hintText: 'Search SHS supplies...',
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 15),
              prefixIcon: Icon(Icons.search, color: Colors.white.withValues(alpha: 0.7), size: 20),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
            onChanged: _search,
          ),
        ),
      ),
      body: _hasSearched ? _buildResults() : _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Popular Searches', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.gray900)),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _suggestions.map((s) => GestureDetector(
              onTap: () {
                _searchController.text = s;
                _search(s);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.gray300),
                ),
                child: Text(s, style: const TextStyle(fontSize: 14, color: AppColors.gray700, fontWeight: FontWeight.w500)),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildResults() {
    if (_results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: AppColors.primary.withValues(alpha: 0.3)),
            const SizedBox(height: 16),
            const Text('No results found', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.gray600)),
            const SizedBox(height: 8),
            const Text('Try a different search term', style: TextStyle(fontSize: 14, color: AppColors.gray500)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _results.length,
      itemBuilder: (context, index) {
        final product = _results[index];
        return GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ShsProductDetailScreen(product: product))),
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
                  width: 56, height: 56,
                  decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(10)),
                  child: Icon(_iconForCategory(product.category), size: 28, color: AppColors.primary.withValues(alpha: 0.5)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: AppColors.gray900)),
                      const SizedBox(height: 4),
                      Text('GHS ${product.priceGhs.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.primary)),
                    ],
                  ),
                ),
                if (product.isRequired)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: AppColors.accent.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)),
                    child: const Text('Essential', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.accent)),
                  ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    context.read<ShsCartProvider>().addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('${product.name} added to cart'),
                      backgroundColor: AppColors.primary,
                      duration: const Duration(seconds: 1),
                    ));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
                    child: const Text('Add +', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
