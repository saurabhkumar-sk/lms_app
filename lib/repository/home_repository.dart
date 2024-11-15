import 'dart:convert';
import 'package:gyanavi_academy/constants.dart';
import 'package:http/http.dart' as http;

import '../models/category.dart';


class CourseRepository {
  final String apiUrl = '$mainUrl/home';

  Future<List<CourseCategory>> fetchCourseCategories() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => CourseCategory.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }
}
