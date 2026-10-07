enum TransactionStatus { completed, pending, refunded }

class PaymentTransaction {
  final String id;
  final String transactionRef;
  final String userId;
  final String? orderId;
  final String? subscriptionId;
  final String userName;
  final String date;
  final String paymentMode; // 'UPI', 'Card', 'Netbanking', 'Wallet'
  final double amount;
  final TransactionStatus status;
  final String? notes;

  PaymentTransaction({
    required this.id,
    this.transactionRef = '',
    this.userId = '',
    this.orderId,
    this.subscriptionId,
    required this.userName,
    required this.date,
    required this.paymentMode,
    required this.amount,
    this.status = TransactionStatus.completed,
    this.notes,
  });

  factory PaymentTransaction.fromJson(Map<String, dynamic> json) {
    TransactionStatus tStatus = TransactionStatus.completed;
    final st = (json['status'] as String? ?? '').toUpperCase();
    if (st == 'PENDING') tStatus = TransactionStatus.pending;
    if (st == 'REFUNDED' || st == 'FAILED') tStatus = TransactionStatus.refunded;

    return PaymentTransaction(
      id: json['id'] as String? ?? '',
      transactionRef: json['transaction_ref'] as String? ?? (json['id'] as String? ?? ''),
      userId: json['user_id'] as String? ?? '',
      orderId: json['order_id'] as String?,
      subscriptionId: json['subscription_id'] as String?,
      userName: json['user_name'] as String? ?? 'Customer',
      date: json['transaction_date'] as String? ?? '2023-10-24',
      paymentMode: json['payment_mode'] as String? ?? 'UPI',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      status: tStatus,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    String st = 'COMPLETED';
    if (status == TransactionStatus.pending) st = 'PENDING';
    if (status == TransactionStatus.refunded) st = 'REFUNDED';

    return {
      'id': id,
      'transaction_ref': transactionRef.isNotEmpty ? transactionRef : 'TXN_${DateTime.now().millisecondsSinceEpoch}',
      'user_id': userId,
      'order_id': orderId,
      'subscription_id': subscriptionId,
      'user_name': userName,
      'payment_mode': paymentMode,
      'amount': amount,
      'status': st,
      'transaction_date': date,
      'notes': notes,
      'created_at': DateTime.now().toIso8601String(),
    };
  }
}
