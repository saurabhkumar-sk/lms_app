// repositories/purchased_course_repository.dart

import 'dart:convert';
import 'package:gyanavi_academy/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../models/courses/my_courses.dart';


class PurchasedCourseRepository {
  final String baseUrl;

  PurchasedCourseRepository(this.baseUrl);

  Future<List<PurchasedCourse>> fetchPurchasedCourses() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found. User is not authenticated.');
    }

    final response = await http.get(
      Uri.parse('$mainUrl/purchase'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['courses'] as List)
          .map((course) => PurchasedCourse.fromJson(course))
          .toList();
    } else {
      throw Exception('Failed to load purchased courses: ${response.reasonPhrase}');
    }
  }
}
