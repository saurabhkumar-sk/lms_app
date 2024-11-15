import 'package:flutter/material.dart';

class BookmarksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Bookmarks'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your bookmarks will appear here.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            // Add a watermark as a child widget
            Watermark(
              text: 'Bookmark Screen',
              opacity: 0.5, // Adjust opacity as needed
              fontSize: 12,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

class Watermark extends StatelessWidget {
  final String text;
  final double opacity;
  final double fontSize;
  final Color color;

  Watermark({
    required this.text,
    required this.opacity,
    required this.fontSize,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}