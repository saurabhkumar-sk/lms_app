import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // For opening Google Meet
import 'package:video_player/video_player.dart'; // For playing videos

class ClassesOverviewScreen extends StatelessWidget {
  final List<Map<String, String>> recordedClasses = [
    {
      'title': 'guitar',
      'instructor': 'John Doe',
      'videoUrl': 'https://samplelib.com/lib/preview/mp4/sample-5s.mp4', // Dummy video URL
    },
    {
      'title': 'music',
      'instructor': 'Jane Smith',
      'videoUrl': 'https://samplelib.com/lib/preview/mp4/sample-10s.mp4',
    },
    {
      'title': 'rap',
      'instructor': 'Albert Newton',
      'videoUrl': 'https://samplelib.com/lib/preview/mp4/sample-15s.mp4',
    },
  ];

  final List<Map<String, String>> liveClasses = [
    {
      'title': 'music',
      'instructor': 'Emily Clark',
      'meetUrl': 'https://meet.google.com/abc-defg-hij', // Dummy Google Meet URL
    },
    {
      'title': 'flute',
      'instructor': 'Michael Johnson',
      'meetUrl': 'https://meet.google.com/xyz-wxyz-wxyz',
    },
    {
      'title': 'guitar',
      'instructor': 'Sarah Lee',
      'meetUrl': 'https://meet.google.com/pqr-abcd-wxyz',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Learning Hub'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search for classes...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              // Recorded Classes Section
              Text(
                'Recorded Classes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              _buildRecordedClasses(context),
              SizedBox(height: 24),

              // Upcoming Live Classes Section
              Text(
                'Upcoming Live Classes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              _buildUpcomingLiveClasses(),
            ],
          ),
        ),
      ),
    );
  }
// Widget to display Recorded Classes
  Widget _buildRecordedClasses(BuildContext context) {
    return SizedBox(
      height: 150, // Slightly increased height for a better layout
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recordedClasses.length,
        itemBuilder: (context, index) {
          final classData = recordedClasses[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                // Play video in full screen when tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerScreen(
                      videoUrl: classData['videoUrl']!,
                    ),
                  ),
                );
              },
              child: Container(
                width: 160, // Adjust width as needed
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 4,
                      spreadRadius: 2,
                      offset: Offset(0, 2), // Shadow position
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Thumbnail image section
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: AspectRatio(
                        aspectRatio: 16 / 9, // Standard aspect ratio for videos
                        child: Image.asset(
                          'assets/thumbnails/${classData['title']?.toLowerCase().replaceAll(" ", "_")}.jpg', // Thumbnail image path
                          fit: BoxFit.cover, // Ensure the image fits the container properly
                          errorBuilder: (context, error, stackTrace) {
                            // Display a placeholder if the image fails to load
                            return Container(
                              color: Colors.grey[200],
                              child: Center(
                                child: Icon(
                                  Icons.broken_image,
                                  color: Colors.grey[400],
                                  size: 50,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // Title and Instructor Information
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            classData['title']!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis, // Handle long titles
                          ),
                          Text(
                            'Instructor: ${classData['instructor']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  // Widget to display Upcoming Live Classes
  Widget _buildUpcomingLiveClasses() {
    return Column(
      children: liveClasses.map((classData) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: Icon(Icons.video_call, size: 40, color: Colors.blue),
              title: Text(
                classData['title']!,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Instructor: ${classData['instructor']}'),
              trailing: ElevatedButton(
                onPressed: () async {
                  // Open Google Meet link
                  final url = classData['meetUrl']!;
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Text('Join'),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// Video Player Screen
class VideoPlayerScreen extends StatefulWidget {
final String videoUrl;

VideoPlayerScreen({required this.videoUrl});

@override
_VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {}); // Once initialized, rebuild to display the video
        _controller.play(); // Auto-play the video
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio, // Maintain video aspect ratio
          child: VideoPlayer(_controller),
        )
            : CircularProgressIndicator(), // Show loading while video initializes
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying ? _controller.pause() : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
