import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../../models/category.dart';
import '../payment_gateway/payment.dart';

class CourseDetailsScreen extends StatefulWidget {
  final Course course;

  CourseDetailsScreen({required this.course});

  @override
  _CourseDetailsScreenState createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  bool isTrialStarted = false;
  int timerSeconds = 60; // Trial duration in seconds
  Timer? trialTimer;
  VideoPlayerController? _videoController;

  // List of dummy video URLs
  final List<String> videoUrls = [
    'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
    'https://sample-videos.com/video123/mp4/480/asdasdas.mp4',
  ];

  @override
  void dispose() {
    trialTimer?.cancel();
    _videoController?.dispose();
    super.dispose();
  }

  // Start the trial and initialize video playback for the first video
  void startTrial() {
    setState(() {
      isTrialStarted = true;
    });

    _playVideo(videoUrls[0]); // Automatically start playing the first video

    trialTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerSeconds > 0) {
        setState(() {
          timerSeconds--;
        });
      } else {
        trialTimer?.cancel();
        setState(() {}); // Update UI to reflect trial ended
      }
    });
  }

  // Play a selected video
  void _playVideo(String videoUrl) {
    if (_videoController != null) {
      _videoController!.dispose();
    }
    _videoController = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        setState(() {}); // Ensure UI is updated after video is initialized
        _videoController!.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.course.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: widget.course.thumbnailUrl != null && widget.course.thumbnailUrl!.isNotEmpty
                  ? Image.network(
                widget.course.thumbnailUrl!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/JPEG-1221.jpg', // Path to your placeholder image
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              )
                  : Image.asset(
                'assets/JPEG-1221.jpg',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),

            // Instructor Info and Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.person, color: Colors.purple),
                    SizedBox(width: 8),
                    Text(
                      "Dr. Jane Doe", // Static example, should be dynamic if needed
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange),
                    SizedBox(width: 4),
                    Text("4.5", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            // Course Description
            Text(
              "Course Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              widget.course.description,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),

            // Key Features
            Text(
              "Key Features",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            featureTile("Interactive Quizzes"),
            featureTile("Video Lectures"),
            featureTile("Course Certificates"),
            SizedBox(height: 20),

            // FAQ Section
            Text(
              "Frequently Asked Questions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            expansionTile("What is the duration of this course?", "The duration is approximately 10 hours."),
            expansionTile("Do I get a certificate after completion?", "Yes, you will receive a certificate."),
            SizedBox(height: 20),

            // Trial or Buy Buttons
            if (!isTrialStarted)
              Column(
                children: [
                  ElevatedButton(
                    onPressed: startTrial,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Colors.blue,
                    ),
                    child: Text('Start Free Trial'),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      String? userId = prefs.getString('userId');

                      if (userId != null) {
                        // Navigate to PaymentScreen with courseId, userId, and coursePrice
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentScreen(
                              userId: userId,
                              courseId: widget.course.id, // Assuming your course has an id property
                              coursePrice: 1000,  // Pass the actual course price here
                            ),
                          ),
                        );
                      } else {
                        // Handle case where user ID is not found in shared preferences
                        print('User ID not found');
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text('Buy Now'),
                  ),

                ],
              )
            else
              Column(
                children: [
                  Text(
                    'Trial started: $timerSeconds seconds left',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  if (_videoController != null && _videoController!.value.isInitialized)
                    AspectRatio(
                      aspectRatio: _videoController!.value.aspectRatio,
                      child: VideoPlayer(_videoController!),
                    ),
                  SizedBox(height: 10),
                  if (timerSeconds == 0)

// Inside your CourseDetailsScreen where you have the Buy Now button
     OutlinedButton(
    onPressed: () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');

    if (userId != null) {
    // Navigate to PaymentScreen with courseId, userId, and coursePrice
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => PaymentScreen(
    userId: userId,
    courseId: widget.course.id, // Assuming your course has an id property
    coursePrice: 1000,  // Pass the actual course price here
    ),
    ),
    );
    } else {
    // Handle case where user ID is not found in shared preferences
    print('User ID not found');
    }
    },
    style: OutlinedButton.styleFrom(
    minimumSize: Size(double.infinity, 50),
    ),
    child: Text('Buy Now'),
    ),

    ],
              ),
          ],
        ),
      ),
    );
  }

  // Helper Widgets
  Widget featureTile(String feature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, color: Colors.green),
          SizedBox(width: 8),
          Text(feature, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget expansionTile(String question, String answer) {
    return ExpansionTile(
      title: Text(question, style: TextStyle(fontWeight: FontWeight.bold)),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(answer, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
        ),
      ],
    );
  }
}
