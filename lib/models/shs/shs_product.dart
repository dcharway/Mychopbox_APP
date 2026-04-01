/// Model representing a Senior High School supply product.
class ShsProduct {
  final String id;
  final String name;
  final String description;
  final double priceGhs;
  final String category;
  final String? imageUrl;
  final bool inStock;
  final int stockQuantity;
  final String? schoolLevel; // e.g., "Form 1", "Form 2", "Form 3"
  final bool isRequired; // whether this is a mandatory supply

  const ShsProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.priceGhs,
    required this.category,
    this.imageUrl,
    this.inStock = true,
    this.stockQuantity = 100,
    this.schoolLevel,
    this.isRequired = false,
  });
}

/// Categories for SHS supplies.
class ShsCategory {
  final String id;
  final String name;
  final String icon;
  final int itemCount;

  const ShsCategory({
    required this.id,
    required this.name,
    required this.icon,
    this.itemCount = 0,
  });
}

/// Item in the shopping cart.
class ShsCartItem {
  final ShsProduct product;
  int quantity;

  ShsCartItem({
    required this.product,
    this.quantity = 1,
  });

  double get totalPrice => product.priceGhs * quantity;
}

/// Information about the student for checkout.
class StudentInfo {
  final String studentName;
  final String schoolName;
  final String formLevel; // Form 1, 2, 3
  final String? house; // school house name
  final String parentName;
  final String parentPhone;
  final String? parentEmail;
  final String? deliveryAddress;
  final String? region; // Ghana region

  const StudentInfo({
    required this.studentName,
    required this.schoolName,
    required this.formLevel,
    this.house,
    required this.parentName,
    required this.parentPhone,
    this.parentEmail,
    this.deliveryAddress,
    this.region,
  });
}
