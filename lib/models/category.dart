class Course {
  final int id;
  final String title;
  final String description;
  final String thumbnailUrl;

  Course({required this.id, required this.title, required this.description, required this.thumbnailUrl});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      thumbnailUrl: json['thumbnail_url'],
    );
  }
}

class CourseCategory {
  final int id;
  final String title;
  final List<Course> courses;

  CourseCategory({required this.id, required this.title, required this.courses});

  factory CourseCategory.fromJson(Map<String, dynamic> json) {
    var courseList = json['courses'] as List;
    List<Course> courses = courseList.map((i) => Course.fromJson(i)).toList();

    return CourseCategory(
      id: json['id'],
      title: json['title'],
      courses: courses,
    );
  }
}
