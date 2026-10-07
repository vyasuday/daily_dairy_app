enum PlanType { weekly, monthly, yearly, custom }
enum SubscriptionStatus { active, paused, cancelled }

class SubscriptionPlan {
  final String id;
  final PlanType type;
  final String planCode;
  final String title;
  final String invoiceDesc;
  final int days;
  final double discountPercentage;
  final bool isActive;

  SubscriptionPlan({
    required this.id,
    required this.type,
    required this.planCode,
    required this.title,
    required this.invoiceDesc,
    required this.days,
    this.discountPercentage = 0.0,
    this.isActive = true,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    PlanType pType = PlanType.monthly;
    final code = (json['plan_code'] as String? ?? '').toUpperCase();
    if (code == 'WEEKLY') pType = PlanType.weekly;
    if (code == 'YEARLY') pType = PlanType.yearly;
    if (code == 'CUSTOM') pType = PlanType.custom;

    return SubscriptionPlan(
      id: json['id'] as String? ?? '',
      type: pType,
      planCode: json['plan_code'] as String? ?? 'MONTHLY',
      title: json['name'] as String? ?? '',
      invoiceDesc: json['invoice_interval_desc'] as String? ?? '',
      days: (json['billing_cycle_days'] as num?)?.toInt() ?? 30,
      discountPercentage: (json['discount_percentage'] as num?)?.toDouble() ?? 0.0,
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plan_code': planCode,
      'name': title,
      'description': invoiceDesc,
      'billing_cycle_days': days,
      'invoice_interval_desc': invoiceDesc,
      'discount_percentage': discountPercentage,
      'is_active': isActive,
    };
  }
}

class SubscriptionItem {
  final String id;
  final String subscriptionId;
  final String productId;
  final String productName;
  final String unit;
  final double unitPrice;
  int quantity;

  SubscriptionItem({
    this.id = '',
    this.subscriptionId = '',
    required this.productId,
    required this.productName,
    required this.unit,
    required this.unitPrice,
    required this.quantity,
  });

  double get subtotal => unitPrice * quantity;

  factory SubscriptionItem.fromJson(Map<String, dynamic> json) {
    return SubscriptionItem(
      id: json['id'] as String? ?? '',
      subscriptionId: json['subscription_id'] as String? ?? '',
      productId: json['product_id'] as String? ?? '',
      productName: json['product_name'] as String? ?? '',
      unit: json['unit'] as String? ?? '500ML',
      unitPrice: (json['unit_price'] as num?)?.toDouble() ?? 0.0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subscription_id': subscriptionId,
      'product_id': productId,
      'product_name': productName,
      'unit': unit,
      'unit_price': unitPrice,
      'quantity': quantity,
      'subtotal': subtotal,
    };
  }
}

class UserSubscription {
  final String id;
  final String userId;
  final String planId;
  final String userName;
  final PlanType planType;
  SubscriptionStatus status;
  final String address;
  final String productName;
  final int units;
  final String nextDeliveryDate;
  final String? resumeDate;
  final List<SubscriptionItem> items;
  final double totalDailyCost;
  final String startDate;

  UserSubscription({
    required this.id,
    required this.userId,
    this.planId = 'plan_monthly',
    required this.userName,
    required this.planType,
    this.status = SubscriptionStatus.active,
    required this.address,
    required this.productName,
    required this.units,
    required this.nextDeliveryDate,
    this.resumeDate,
    this.items = const [],
    required this.totalDailyCost,
    this.startDate = '2023-10-01',
  });

  factory UserSubscription.fromJson(Map<String, dynamic> json, {String userName = '', List<SubscriptionItem> items = const []}) {
    SubscriptionStatus sStatus = SubscriptionStatus.active;
    final st = (json['status'] as String? ?? '').toUpperCase();
    if (st == 'PAUSED') sStatus = SubscriptionStatus.paused;
    if (st == 'CANCELLED') sStatus = SubscriptionStatus.cancelled;

    PlanType pType = PlanType.monthly;
    final pid = json['plan_id'] as String? ?? '';
    if (pid.contains('weekly')) pType = PlanType.weekly;
    if (pid.contains('yearly')) pType = PlanType.yearly;
    if (pid.contains('custom')) pType = PlanType.custom;

    final firstItem = items.isNotEmpty ? items.first : null;
    final pName = firstItem != null ? firstItem.productName : 'Amul Taaza (500ML)';
    final pUnits = firstItem != null ? firstItem.quantity : 1;

    return UserSubscription(
      id: json['id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      planId: json['plan_id'] as String? ?? 'plan_monthly',
      userName: userName,
      planType: pType,
      status: sStatus,
      address: json['delivery_address'] as String? ?? '',
      productName: pName,
      units: pUnits,
      nextDeliveryDate: json['next_delivery_date'] as String? ?? '2023-11-01',
      resumeDate: json['resumes_at'] as String?,
      items: items,
      totalDailyCost: (json['total_daily_cost'] as num?)?.toDouble() ?? 0.0,
      startDate: json['start_date'] as String? ?? '2023-10-01',
    );
  }

  Map<String, dynamic> toJson() {
    String st = 'ACTIVE';
    if (status == SubscriptionStatus.paused) st = 'PAUSED';
    if (status == SubscriptionStatus.cancelled) st = 'CANCELLED';

    return {
      'id': id,
      'user_id': userId,
      'plan_id': planId,
      'status': st,
      'delivery_address': address,
      'total_daily_cost': totalDailyCost,
      'start_date': startDate,
      'end_date': null,
      'next_delivery_date': nextDeliveryDate,
      'resumes_at': resumeDate,
    };
  }
}
