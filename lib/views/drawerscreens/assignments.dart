import 'package:flutter/material.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Assignment'),
      ),
      body: Column(
        children: [
          Image.asset('assets/JPEG-1221.jpg'),
          const Text(
            'Your Assignment',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'For this week\'s assignment, you need to practice the song \'Imagine\' by John Lennon. Focus on the chord transitions and try to maintain a steady rhythm throughout the song. Record your practice...',
              style: TextStyle(fontSize: 16),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle submit assignment action
            },
            child: const Text('Submit Assignment'),
          ),
        ],
      ));

  }
}