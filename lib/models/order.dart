class CartItem {
  final String productId;
  final String productName;
  final String unit;
  final double unitPrice;
  int quantity;

  CartItem({
    required this.productId,
    required this.productName,
    required this.unit,
    required this.unitPrice,
    required this.quantity,
  });

  double get subtotal => unitPrice * quantity;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['product_id'] as String? ?? '',
      productName: json['product_name'] as String? ?? '',
      unit: json['unit'] as String? ?? '500ML',
      unitPrice: (json['unit_price'] as num?)?.toDouble() ?? 0.0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'unit': unit,
      'unit_price': unitPrice,
      'quantity': quantity,
      'subtotal': subtotal,
    };
  }
}

class OrderModel {
  final String id;
  final String orderCode;
  final String userId;
  final List<CartItem> items;
  final double totalAmount;
  final String paymentMethod;
  final String paymentStatus;
  final String deliveryStatus;
  final String deliveryAddress;
  final String expectedArrival;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.orderCode,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.paymentMethod,
    this.paymentStatus = 'COMPLETED',
    this.deliveryStatus = 'PLACED',
    this.deliveryAddress = 'Shreedip Residency Changa Gujarat',
    this.expectedArrival = 'Tomorrow 6:00 AM',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory OrderModel.fromJson(Map<String, dynamic> json, {List<CartItem> items = const []}) {
    return OrderModel(
      id: json['id'] as String? ?? '',
      orderCode: json['order_code'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      items: items,
      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0.0,
      paymentMethod: json['payment_method'] as String? ?? 'UPI',
      paymentStatus: json['payment_status'] as String? ?? 'COMPLETED',
      deliveryStatus: json['delivery_status'] as String? ?? 'PLACED',
      deliveryAddress: json['delivery_address'] as String? ?? '',
      expectedArrival: json['expected_arrival'] as String? ?? 'Tomorrow 6:00 AM',
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) ?? DateTime.now() : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_code': orderCode,
      'user_id': userId,
      'total_amount': totalAmount,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'delivery_status': deliveryStatus,
      'delivery_address': deliveryAddress,
      'expected_arrival': expectedArrival,
      'temperature_controlled': true,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
