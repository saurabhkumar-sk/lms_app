import 'package:flutter/material.dart';
import 'package:gyanavi_academy/views/drawerscreens/study_material/study_materials.dart';

class CoursesMaterialScreen extends StatelessWidget {
  final List<Course> courses = [
    Course('Introduction to Classical Music', '10 lessons', 'assets/JPEG-1221.jpg'),
    Course('Jazz Improvisation', '8 lessons', 'assets/JPEG-1221.jpg'),
    Course('Rock Guitar Basics', '12 lessons', 'assets/JPEG-1221.jpg'),
    Course('Advanced Piano Lessons', '15 lessons', 'assets/JPEG-1221.jpg'),
    Course('Music Theory Essentials', '9 lessons', 'assets/JPEG-1221.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Material'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudyMaterialScreen(),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: Image.asset(courses[index].image, fit: BoxFit.cover),
                  title: Text(courses[index].title),
                  subtitle: Text(courses[index].lessons),
                  trailing: Icon(Icons.music_note),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Course {
  final String title;
  final String lessons;
  final String image;

  Course(this.title, this.lessons, this.image);
}
