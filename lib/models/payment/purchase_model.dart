// models/purchase.dart
class Purchase {
  final int userId;
  final int courseId;
  final double amount;
  final String paymentId; // or any other identifier
  final String status;

  Purchase({
    required this.userId,
    required this.courseId,
    required this.amount,
    required this.paymentId,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'course_id': courseId,
      'amount': amount,
      'payment_id': paymentId,
      'status': status,
    };
  }
}
