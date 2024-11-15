// models/courses/my_courses.dart

class PurchasedCourse {
  final int courseId;
  final String courseTitle;
  final String courseDescription;
  final String purchaseDate;

  PurchasedCourse({
    required this.courseId,
    required this.courseTitle,
    required this.courseDescription,
    required this.purchaseDate,
  });

  factory PurchasedCourse.fromJson(Map<String, dynamic> json) {
    return PurchasedCourse(
      courseId: json['course_id'],
      courseTitle: json['course_title'],
      courseDescription: json['course_description'],
      purchaseDate: json['purchase_date'],
    );
  }
}
