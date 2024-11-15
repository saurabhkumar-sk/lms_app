import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';

class ContentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.purple),
          onPressed: () {},
        ),
        title: Text('Classes', style: TextStyle(color: Colors.purple)),
        centerTitle: true,
        actions: [
          Icon(Icons.signal_wifi_statusbar_null_rounded, color: Colors.black),
        ],
      ),
      body: Container(
        color: Colors.purple[100],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back\nJohn Doe',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.purple[800]),
              ),
              SizedBox(height: 20),
              SizedBox(height: 30),
              Text(
                'Last Classes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple[800]),
              ),
              SizedBox(height: 10),
              // Last Classes Section
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ClassCard(
                      category: 'Arts & Humanities',
                      title: 'Draw and paint Arts',
                      duration: '2h 25min',
                      color: Colors.lightBlueAccent,
                      isVideo: true,
                      videoUrl: 'https://www.example.com/video1.mp4', // Dummy video link
                    ),
                    ClassCard(
                      category: 'Computer & Technology',
                      title: 'Programming Basics',
                      duration: '7h 2min',
                      color: Colors.deepPurple,
                      isVideo: true,
                      videoUrl: 'https://www.example.com/video2.mp4', // Dummy video link
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Upcoming Live Classes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple[800]),
              ),
              SizedBox(height: 10),
              // Upcoming Live Classes Section
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ClassCard(
                      category: 'Science',
                      title: 'Physics Live Session',
                      duration: 'Starts in 30min',
                      color: Colors.greenAccent,
                      isLive: true,
                      meetUrl: 'https://meet.google.com/xyz-abc-pqr', // Google Meet link
                    ),
                    ClassCard(
                      category: 'Math',
                      title: 'Calculus Workshop',
                      duration: 'Starts in 2h',
                      color: Colors.orangeAccent,
                      isLive: true,
                      meetUrl: 'https://meet.google.com/abc-def-ghi', // Google Meet link
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ClassCard extends StatelessWidget {
  final String category;
  final String title;
  final String duration;
  final Color color;
  final bool isVideo;
  final bool isLive;
  final String? videoUrl;
  final String? meetUrl;

  ClassCard({
    required this.category,
    required this.title,
    required this.duration,
    required this.color,
    this.isVideo = false,
    this.isLive = false,
    this.videoUrl,
    this.meetUrl,
  });

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isVideo && videoUrl != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VideoScreen(videoUrl: videoUrl!)),
          );
        } else if (isLive && meetUrl != null) {
          _launchUrl(meetUrl!);
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.only(right: 16),
        color: color,
        child: Container(
          width: 150,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Ensures the Column only uses the necessary space
            children: [
              Text(
                category,
                style: TextStyle(fontSize: 12, color: Colors.white70),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              Text(
                duration,
                style: TextStyle(fontSize: 14, color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class VideoScreen extends StatefulWidget {
  final String videoUrl;

  VideoScreen({required this.videoUrl});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
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
        backgroundColor: Colors.purple[100],
        title: Text('Class Video', style: TextStyle(color: Colors.purple)),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : CircularProgressIndicator(),
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
