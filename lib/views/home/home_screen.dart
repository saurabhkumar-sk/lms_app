import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyanavi_academy/views/compo/course_details.dart';
import 'package:gyanavi_academy/views/home/components/drawer.dart';
import '../../bloc/home_state.dart';
import '../../models/category.dart';
import '../../repository/home_repository.dart';
//import '../course/course_details.dart';
import 'components/home_header.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: BlocProvider(
        create: (_) => CourseBloc(CourseRepository())..add(FetchCourses()),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(),
              BlocBuilder<CourseBloc, CourseState>(
                builder: (context, state) {
                  if (state is CourseLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is CourseLoaded) {
                    return Column(
                      children: state.courses.map((category) {
                        return buildCourseSection(context, category); // Pass context here
                      }).toList(),
                    );
                  } else if (state is CourseError) {
                    return Center(child: Text('Error loading courses'));
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCourseSection(BuildContext context, CourseCategory category) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              category.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: category.courses.length,
              itemBuilder: (context, index) {
                return _buildCourseCard(context, category.courses[index]); // Pass context here
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, Course course) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseInfoScreen(),
            ),
          );
        },
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/placeholder.png', // Placeholder image
                    image: course.thumbnailUrl ?? '',
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/25523520_trend_watching_16.jpg', // Error image
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  course.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  course.description,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
