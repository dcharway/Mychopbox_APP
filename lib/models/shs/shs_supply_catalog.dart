import 'shs_product.dart';

/// Comprehensive catalog of Ghana SHS supplies organised by category.
class ShsSupplyCatalog {
  static const List<ShsCategory> categories = [
    ShsCategory(id: 'uniforms', name: 'Uniforms & Clothing', icon: 'school'),
    ShsCategory(id: 'textbooks', name: 'Textbooks & Books', icon: 'menu_book'),
    ShsCategory(id: 'stationery', name: 'Stationery', icon: 'edit'),
    ShsCategory(id: 'provisions', name: 'Provisions & Food', icon: 'fastfood'),
    ShsCategory(id: 'toiletries', name: 'Toiletries & Personal Care', icon: 'soap'),
    ShsCategory(id: 'bedding', name: 'Bedding & Trunk', icon: 'bed'),
    ShsCategory(id: 'electronics', name: 'Electronics & Tools', icon: 'calculate'),
    ShsCategory(id: 'footwear', name: 'Footwear', icon: 'directions_walk'),
  ];

  static const List<ShsProduct> allProducts = [
    // ─── UNIFORMS & CLOTHING ───
    ShsProduct(
      id: 'uni-001',
      name: 'School Uniform (Full Set)',
      description:
          'Complete school uniform set including shirt/blouse and trousers/skirt. '
          'Standard khaki or school-specific colour. Durable fabric suitable for daily wear.',
      priceGhs: 180.00,
      category: 'uniforms',
      isRequired: true,
    ),
    ShsProduct(
      id: 'uni-002',
      name: 'School Uniform Shirt/Blouse',
      description: 'Individual school shirt or blouse. Quality cotton-blend fabric '
          'with proper collar and buttons.',
      priceGhs: 65.00,
      category: 'uniforms',
      isRequired: true,
    ),
    ShsProduct(
      id: 'uni-003',
      name: 'School Uniform Trousers/Skirt',
      description: 'School trousers or skirt in regulation colour. '
          'Durable stitching for everyday use.',
      priceGhs: 75.00,
      category: 'uniforms',
      isRequired: true,
    ),
    ShsProduct(
      id: 'uni-004',
      name: 'PE / Sports Wear Set',
      description: 'Physical Education uniform set including shorts and T-shirt. '
          'Lightweight breathable material.',
      priceGhs: 120.00,
      category: 'uniforms',
      isRequired: true,
    ),
    ShsProduct(
      id: 'uni-005',
      name: 'School House T-Shirt',
      description: 'House colour T-shirt for inter-house competitions and events.',
      priceGhs: 45.00,
      category: 'uniforms',
    ),
    ShsProduct(
      id: 'uni-006',
      name: 'School Belt',
      description: 'Black or brown leather school belt with standard buckle.',
      priceGhs: 25.00,
      category: 'uniforms',
      isRequired: true,
    ),
    ShsProduct(
      id: 'uni-007',
      name: 'School Tie',
      description: 'Official school tie in regulation colour and pattern.',
      priceGhs: 30.00,
      category: 'uniforms',
    ),
    ShsProduct(
      id: 'uni-008',
      name: 'Socks (3 Pairs)',
      description: 'School regulation socks. White or school-specific colour. '
          'Pack of three pairs.',
      priceGhs: 35.00,
      category: 'uniforms',
      isRequired: true,
    ),

    // ─── TEXTBOOKS & BOOKS ───
    ShsProduct(
      id: 'txt-001',
      name: 'Core Mathematics Textbook',
      description: 'SHS Core Mathematics textbook covering the WAEC/WASSCE syllabus. '
          'Latest edition with practice questions.',
      priceGhs: 55.00,
      category: 'textbooks',
      isRequired: true,
    ),
    ShsProduct(
      id: 'txt-002',
      name: 'English Language Textbook',
      description: 'Comprehensive English Language textbook for SHS. '
          'Covers grammar, comprehension, and essay writing.',
      priceGhs: 50.00,
      category: 'textbooks',
      isRequired: true,
    ),
    ShsProduct(
      id: 'txt-003',
      name: 'Integrated Science Textbook',
      description: 'Integrated Science for SHS. Covers biology, chemistry, '
          'and physics fundamentals per the GES curriculum.',
      priceGhs: 60.00,
      category: 'textbooks',
      isRequired: true,
    ),
    ShsProduct(
      id: 'txt-004',
      name: 'Social Studies Textbook',
      description: 'Social Studies for Senior High Schools. Covers governance, '
          'economics, and Ghanaian culture.',
      priceGhs: 48.00,
      category: 'textbooks',
      isRequired: true,
    ),
    ShsProduct(
      id: 'txt-005',
      name: 'Elective Mathematics Textbook',
      description: 'Advanced Mathematics for SHS elective students. '
          'Includes calculus, statistics, and further algebra.',
      priceGhs: 65.00,
      category: 'textbooks',
    ),
    ShsProduct(
      id: 'txt-006',
      name: 'Biology Textbook (Elective)',
      description: 'Detailed Biology textbook for science elective students. '
          'Covers cell biology, genetics, ecology, and more.',
      priceGhs: 58.00,
      category: 'textbooks',
    ),
    ShsProduct(
      id: 'txt-007',
      name: 'Chemistry Textbook (Elective)',
      description: 'Chemistry for SHS elective students. Covers organic, '
          'inorganic, and physical chemistry.',
      priceGhs: 62.00,
      category: 'textbooks',
    ),
    ShsProduct(
      id: 'txt-008',
      name: 'Physics Textbook (Elective)',
      description: 'Physics textbook for SHS elective students. '
          'Mechanics, waves, electricity, and modern physics.',
      priceGhs: 60.00,
      category: 'textbooks',
    ),
    ShsProduct(
      id: 'txt-009',
      name: 'Economics Textbook',
      description: 'Economics for SHS covering micro and macroeconomics, '
          'trade, and Ghanaian economic policy.',
      priceGhs: 50.00,
      category: 'textbooks',
    ),
    ShsProduct(
      id: 'txt-010',
      name: 'Government Textbook',
      description: 'Government textbook for SHS. Covers Ghana\'s '
          'constitution, political systems, and international relations.',
      priceGhs: 48.00,
      category: 'textbooks',
    ),
    ShsProduct(
      id: 'txt-011',
      name: 'WAEC Past Questions Booklet',
      description: 'Collection of past WASSCE examination questions with '
          'answers and marking schemes. Essential for exam preparation.',
      priceGhs: 40.00,
      category: 'textbooks',
    ),

    // ─── STATIONERY ───
    ShsProduct(
      id: 'sta-001',
      name: 'Exercise Books (Pack of 10)',
      description: '40-leaf ruled exercise books. Standard A4 size. '
          'Pack of 10 for different subjects.',
      priceGhs: 50.00,
      category: 'stationery',
      isRequired: true,
    ),
    ShsProduct(
      id: 'sta-002',
      name: 'Ballpoint Pens (Pack of 12)',
      description: 'Blue and black ballpoint pens. Smooth writing, '
          'reliable ink flow. Box of 12.',
      priceGhs: 20.00,
      category: 'stationery',
      isRequired: true,
    ),
    ShsProduct(
      id: 'sta-003',
      name: 'Pencils & Eraser Set',
      description: 'HB pencils (6 pack), sharpener, and quality eraser. '
          'Essential for exams and technical drawings.',
      priceGhs: 15.00,
      category: 'stationery',
      isRequired: true,
    ),
    ShsProduct(
      id: 'sta-004',
      name: 'Mathematical Set',
      description: 'Complete mathematical instrument set: compass, protractor, '
          'set squares, ruler, and divider.',
      priceGhs: 35.00,
      category: 'stationery',
      isRequired: true,
    ),
    ShsProduct(
      id: 'sta-005',
      name: 'Graph Book',
      description: 'A4 graph paper book for mathematics and science practicals.',
      priceGhs: 12.00,
      category: 'stationery',
    ),
    ShsProduct(
      id: 'sta-006',
      name: 'Drawing/Art Pad',
      description: 'A3 drawing pad for visual art students. '
          'Thick quality paper, 30 sheets.',
      priceGhs: 25.00,
      category: 'stationery',
    ),
    ShsProduct(
      id: 'sta-007',
      name: 'Ruler (30cm)',
      description: 'Transparent plastic ruler, 30 cm with clear markings.',
      priceGhs: 5.00,
      category: 'stationery',
      isRequired: true,
    ),
    ShsProduct(
      id: 'sta-008',
      name: 'Foolscap Sheets (Pack of 50)',
      description: 'Ruled foolscap sheets for assignments and exam practice.',
      priceGhs: 18.00,
      category: 'stationery',
    ),
    ShsProduct(
      id: 'sta-009',
      name: 'Highlighter Pens (Set of 4)',
      description: 'Fluorescent highlighter pens in four colours '
          'for effective note-taking and revision.',
      priceGhs: 22.00,
      category: 'stationery',
    ),
    ShsProduct(
      id: 'sta-010',
      name: 'Notebook (Hardcover A5)',
      description: 'Durable hardcover notebook for personal notes and revision.',
      priceGhs: 18.00,
      category: 'stationery',
    ),

    // ─── PROVISIONS & FOOD ───
    ShsProduct(
      id: 'pro-001',
      name: 'Milo Tin (400g)',
      description: 'Nestle Milo chocolate malt beverage. '
          'A boarding school essential for energy and nutrition.',
      priceGhs: 65.00,
      category: 'provisions',
      isRequired: true,
    ),
    ShsProduct(
      id: 'pro-002',
      name: 'Peak Milk (Tin)',
      description: 'Peak evaporated milk for beverages. '
          'Long-lasting canned milk.',
      priceGhs: 25.00,
      category: 'provisions',
    ),
    ShsProduct(
      id: 'pro-003',
      name: 'Sugar (1kg)',
      description: 'Granulated white sugar, 1 kilogram pack.',
      priceGhs: 18.00,
      category: 'provisions',
    ),
    ShsProduct(
      id: 'pro-004',
      name: 'Gari (5kg bag)',
      description: 'Quality gari (cassava flakes). A staple food item '
          'for boarding students.',
      priceGhs: 55.00,
      category: 'provisions',
      isRequired: true,
    ),
    ShsProduct(
      id: 'pro-005',
      name: 'Sardines (Pack of 6)',
      description: 'Canned sardines in tomato sauce. '
          'Convenient protein source. Pack of 6 tins.',
      priceGhs: 60.00,
      category: 'provisions',
    ),
    ShsProduct(
      id: 'pro-006',
      name: 'Corned Beef (Pack of 4)',
      description: 'Exeter or Exeter-style corned beef tins. '
          'Protein-rich canned meat. Pack of 4.',
      priceGhs: 80.00,
      category: 'provisions',
    ),
    ShsProduct(
      id: 'pro-007',
      name: 'Biscuits Assorted (Pack)',
      description: 'Assorted biscuit pack including cream crackers '
          'and digestive biscuits.',
      priceGhs: 45.00,
      category: 'provisions',
    ),
    ShsProduct(
      id: 'pro-008',
      name: 'Indomie Noodles (Box of 20)',
      description: 'Instant noodles in assorted flavours. '
          'Quick meal option for students. Box of 20 packs.',
      priceGhs: 95.00,
      category: 'provisions',
    ),
    ShsProduct(
      id: 'pro-009',
      name: 'Groundnut Paste (500g)',
      description: 'Pure groundnut paste for bread spread '
          'and cooking. Nutritious and filling.',
      priceGhs: 30.00,
      category: 'provisions',
    ),
    ShsProduct(
      id: 'pro-010',
      name: 'Drinking Water Sachet (Bag)',
      description: 'Pure drinking water sachets. Bag of 30 sachets.',
      priceGhs: 15.00,
      category: 'provisions',
    ),
    ShsProduct(
      id: 'pro-011',
      name: 'Tea Bags (Box of 25)',
      description: 'Lipton or similar tea bags for hot beverages. Box of 25.',
      priceGhs: 20.00,
      category: 'provisions',
    ),

    // ─── TOILETRIES & PERSONAL CARE ───
    ShsProduct(
      id: 'toi-001',
      name: 'Bathing Soap (Pack of 6)',
      description: 'Quality bathing soap bars. Lux, Dettol, or similar. '
          'Pack of 6 bars for the term.',
      priceGhs: 42.00,
      category: 'toiletries',
      isRequired: true,
    ),
    ShsProduct(
      id: 'toi-002',
      name: 'Toothpaste & Toothbrush',
      description: 'Close-Up or Pepsodent toothpaste with toothbrush combo.',
      priceGhs: 18.00,
      category: 'toiletries',
      isRequired: true,
    ),
    ShsProduct(
      id: 'toi-003',
      name: 'Washing Powder (500g)',
      description: 'OMO or Key Soap washing powder for laundry.',
      priceGhs: 22.00,
      category: 'toiletries',
      isRequired: true,
    ),
    ShsProduct(
      id: 'toi-004',
      name: 'Key Soap (Bar)',
      description: 'Multipurpose key soap bar for washing clothes and utensils.',
      priceGhs: 12.00,
      category: 'toiletries',
      isRequired: true,
    ),
    ShsProduct(
      id: 'toi-005',
      name: 'Body Lotion / Cream',
      description: 'Moisturising body lotion or cream. Nivea, '
          'Cocoa Butter, or similar.',
      priceGhs: 25.00,
      category: 'toiletries',
    ),
    ShsProduct(
      id: 'toi-006',
      name: 'Roll-On Deodorant',
      description: 'Antiperspirant roll-on deodorant.',
      priceGhs: 15.00,
      category: 'toiletries',
    ),
    ShsProduct(
      id: 'toi-007',
      name: 'Toilet Roll (Pack of 6)',
      description: 'Soft tissue paper rolls. Pack of 6.',
      priceGhs: 30.00,
      category: 'toiletries',
      isRequired: true,
    ),
    ShsProduct(
      id: 'toi-008',
      name: 'Sanitary Pads (Pack)',
      description: 'Feminine hygiene pads. Always or similar brand. '
          'Pack for the term.',
      priceGhs: 35.00,
      category: 'toiletries',
    ),
    ShsProduct(
      id: 'toi-009',
      name: 'Vaseline (100ml)',
      description: 'Petroleum jelly for skin care. Blue seal Vaseline.',
      priceGhs: 12.00,
      category: 'toiletries',
    ),
    ShsProduct(
      id: 'toi-010',
      name: 'Sponge & Towel Set',
      description: 'Bath sponge and medium-size towel set.',
      priceGhs: 35.00,
      category: 'toiletries',
      isRequired: true,
    ),

    // ─── BEDDING & TRUNK ───
    ShsProduct(
      id: 'bed-001',
      name: 'Student Metal Trunk (Medium)',
      description: 'Durable metal trunk box for storing belongings. '
          'Standard size approved by most SHS schools in Ghana.',
      priceGhs: 250.00,
      category: 'bedding',
      isRequired: true,
    ),
    ShsProduct(
      id: 'bed-002',
      name: 'Chop Box (Provisions Box)',
      description: 'Plastic or wooden chop box for storing food provisions. '
          'Lockable with compartments.',
      priceGhs: 150.00,
      category: 'bedding',
      isRequired: true,
    ),
    ShsProduct(
      id: 'bed-003',
      name: 'Bed Sheet Set (2 pieces)',
      description: 'Single bed sheets in plain white or approved colour. '
          'Set of 2 for weekly change.',
      priceGhs: 80.00,
      category: 'bedding',
      isRequired: true,
    ),
    ShsProduct(
      id: 'bed-004',
      name: 'Pillow & Pillowcase',
      description: 'Standard pillow with washable pillowcase.',
      priceGhs: 45.00,
      category: 'bedding',
      isRequired: true,
    ),
    ShsProduct(
      id: 'bed-005',
      name: 'Blanket / Bedspread',
      description: 'Lightweight blanket or bedspread for dormitory use.',
      priceGhs: 70.00,
      category: 'bedding',
    ),
    ShsProduct(
      id: 'bed-006',
      name: 'Mosquito Net',
      description: 'Treated mosquito net for single bed. '
          'Essential for malaria prevention.',
      priceGhs: 55.00,
      category: 'bedding',
      isRequired: true,
    ),
    ShsProduct(
      id: 'bed-007',
      name: 'Bucket & Cup Set',
      description: 'Plastic bucket (medium) with cup for bathing.',
      priceGhs: 35.00,
      category: 'bedding',
      isRequired: true,
    ),
    ShsProduct(
      id: 'bed-008',
      name: 'Padlock Set (2 pieces)',
      description: 'Quality padlocks for trunk and chop box. Set of 2 with keys.',
      priceGhs: 30.00,
      category: 'bedding',
      isRequired: true,
    ),

    // ─── ELECTRONICS & TOOLS ───
    ShsProduct(
      id: 'ele-001',
      name: 'Scientific Calculator',
      description: 'Casio fx-991ES or equivalent scientific calculator. '
          'Approved for WASSCE examinations.',
      priceGhs: 85.00,
      category: 'electronics',
      isRequired: true,
    ),
    ShsProduct(
      id: 'ele-002',
      name: 'Torch / Flashlight',
      description: 'LED rechargeable torch light for night reading and '
          'power outage situations.',
      priceGhs: 35.00,
      category: 'electronics',
    ),
    ShsProduct(
      id: 'ele-003',
      name: 'Rechargeable Study Lamp',
      description: 'Portable rechargeable LED desk lamp for '
          'evening studies in the dormitory.',
      priceGhs: 65.00,
      category: 'electronics',
    ),
    ShsProduct(
      id: 'ele-004',
      name: 'Alarm Clock',
      description: 'Battery-operated alarm clock for early morning prep.',
      priceGhs: 25.00,
      category: 'electronics',
    ),

    // ─── FOOTWEAR ───
    ShsProduct(
      id: 'ftw-001',
      name: 'School Shoes (Black)',
      description: 'Black leather or synthetic school shoes. '
          'Durable and comfortable for daily wear.',
      priceGhs: 120.00,
      category: 'footwear',
      isRequired: true,
    ),
    ShsProduct(
      id: 'ftw-002',
      name: 'Sports / PE Shoes',
      description: 'Athletic shoes suitable for physical education '
          'and sports activities.',
      priceGhs: 150.00,
      category: 'footwear',
      isRequired: true,
    ),
    ShsProduct(
      id: 'ftw-003',
      name: 'Slippers / Sandals',
      description: 'Durable rubber slippers or sandals for dormitory '
          'and casual use.',
      priceGhs: 30.00,
      category: 'footwear',
      isRequired: true,
    ),
  ];

  /// Get all products for a specific category.
  static List<ShsProduct> getByCategory(String categoryId) {
    return allProducts
        .where((p) => p.category == categoryId)
        .toList();
  }

  /// Search products by name or description.
  static List<ShsProduct> search(String query) {
    final q = query.toLowerCase();
    return allProducts
        .where((p) =>
            p.name.toLowerCase().contains(q) ||
            p.description.toLowerCase().contains(q) ||
            p.category.toLowerCase().contains(q))
        .toList();
  }

  /// Get only required/essential items.
  static List<ShsProduct> getEssentials() {
    return allProducts.where((p) => p.isRequired).toList();
  }

  /// Get featured products (a curated subset).
  static List<ShsProduct> getFeatured() {
    const featuredIds = [
      'uni-001', 'txt-001', 'sta-001', 'pro-001',
      'toi-001', 'bed-001', 'ele-001', 'ftw-001',
    ];
    return allProducts
        .where((p) => featuredIds.contains(p.id))
        .toList();
  }

  /// Get category with item count.
  static List<ShsCategory> getCategoriesWithCounts() {
    return categories.map((cat) {
      final count =
          allProducts.where((p) => p.category == cat.id).length;
      return ShsCategory(
        id: cat.id,
        name: cat.name,
        icon: cat.icon,
        itemCount: count,
      );
    }).toList();
  }
}
