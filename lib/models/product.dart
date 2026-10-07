enum StockStatus { inStock, lowStock, outOfStock }

class Product {
  final String id;
  final String categoryId;
  final String name;
  final String brand;
  final String subtitle;
  final String unit;
  final double price;
  final double costPrice;
  final int stockQuantity;
  final int lowStockThreshold;
  final StockStatus stockStatus;
  final String imageUrl;
  final String description;
  final bool isActive;
  final String createdAt;

  Product({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.brand,
    required this.subtitle,
    required this.unit,
    required this.price,
    this.costPrice = 0.0,
    required this.stockQuantity,
    this.lowStockThreshold = 20,
    this.stockStatus = StockStatus.inStock,
    required this.imageUrl,
    this.description = '',
    this.isActive = true,
    String? createdAt,
  }) : createdAt = createdAt ?? DateTime.now().toIso8601String();

  factory Product.fromJson(Map<String, dynamic> json) {
    StockStatus parseStatus(String? status) {
      if (status == 'low_stock') return StockStatus.lowStock;
      if (status == 'out_of_stock') return StockStatus.outOfStock;
      return StockStatus.inStock;
    }

    return Product(
      id: json['id'] as String? ?? '',
      categoryId: json['category_id'] as String? ?? 'cat_milk',
      name: json['name'] as String? ?? '',
      brand: json['brand'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      unit: json['unit'] as String? ?? '500ML',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      costPrice: (json['cost_price'] as num?)?.toDouble() ?? 0.0,
      stockQuantity: (json['stock_quantity'] as num?)?.toInt() ?? 0,
      lowStockThreshold: (json['low_stock_threshold'] as num?)?.toInt() ?? 20,
      stockStatus: parseStatus(json['stock_status'] as String?),
      imageUrl: json['image_url'] as String? ?? 'assets/images/tazza.jpeg',
      description: json['description'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] as String? ?? DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toJson() {
    String statusStr = 'in_stock';
    if (stockStatus == StockStatus.lowStock) statusStr = 'low_stock';
    if (stockStatus == StockStatus.outOfStock) statusStr = 'out_of_stock';

    return {
      'id': id,
      'category_id': categoryId,
      'name': name,
      'brand': brand,
      'subtitle': subtitle,
      'unit': unit,
      'price': price,
      'cost_price': costPrice,
      'stock_quantity': stockQuantity,
      'low_stock_threshold': lowStockThreshold,
      'stock_status': statusStr,
      'image_url': imageUrl,
      'description': description,
      'is_active': isActive,
      'created_at': createdAt,
    };
  }

  Product copyWith({
    String? id,
    String? categoryId,
    String? name,
    String? brand,
    String? subtitle,
    String? unit,
    double? price,
    double? costPrice,
    int? stockQuantity,
    int? lowStockThreshold,
    StockStatus? stockStatus,
    String? imageUrl,
    String? description,
    bool? isActive,
  }) {
    return Product(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      subtitle: subtitle ?? this.subtitle,
      unit: unit ?? this.unit,
      price: price ?? this.price,
      costPrice: costPrice ?? this.costPrice,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      lowStockThreshold: lowStockThreshold ?? this.lowStockThreshold,
      stockStatus: stockStatus ?? this.stockStatus,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt,
    );
  }
}
