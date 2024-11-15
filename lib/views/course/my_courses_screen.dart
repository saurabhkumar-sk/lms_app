import 'package:flutter/material.dart';

import 'package:gyanavi_academy/models/courses/my_courses.dart';
import '../../repository/course/my_courses_repository.dart';
import 'class_details.dart';

class PurchasedCourseScreen extends StatefulWidget {
  @override
  _PurchasedCourseScreenState createState() => _PurchasedCourseScreenState();
}

class _PurchasedCourseScreenState extends State<PurchasedCourseScreen> {
  late PurchasedCourseRepository _repository;
  late Future<List<PurchasedCourse>> _purchasedCourses;

  @override
  void initState() {
    super.initState();
    _repository = PurchasedCourseRepository('https://api.classwix.com/api'); // Use your base URL
    _purchasedCourses = _repository.fetchPurchasedCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Courses'),
      ),
      body: FutureBuilder<List<PurchasedCourse>>(
        future: _purchasedCourses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No courses purchased.'));
          } else {
            final courses = snapshot.data!;
            return ListView(
              children: [
                // Featured Course Section
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Replace with featured course image from assets
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                          child: Image.asset(
                            'assets/24747255_6997673.jpg',
                            width: double.infinity,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Featured Course: Advanced Guitar Techniques',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Elevate your guitar skills with this comprehensive course.',
                                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // List of Purchased Courses
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(12.0),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              _getCourseImage(course.courseTitle), // Method to get image asset
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            course.courseTitle,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course.courseDescription,
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Purchased on: ${course.purchaseDate}',
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClassesOverviewScreen(),
                                ),
                              );
                            },
                            child: Text('Continue'),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }

  // Method to return image paths based on course title
  String _getCourseImage(String courseTitle) {
    switch (courseTitle) {
      case 'Beginner Piano Lessons':
        return 'assets/24747255_6997673.jpg';
      case 'Jazz Drumming':
        return 'assets/24747255_6997673.jpg';
      case 'Classical Violin Mastery':
        return 'assets/24747255_6997673.jpg';
      case 'Electronic Music Production':
        return 'assets/24747255_6997673.jpg';
      case 'Blues Harmonica Basics':
        return 'assets/24747255_6997673.jpg';
      default:
        return 'assets/24747255_6997673.jpg'; // Fallback image
    }
  }
}
