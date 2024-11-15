import 'package:flutter/material.dart';

class WorkshopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Workshops'),
        backgroundColor: Color(0xFF002666),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner
              Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://img.freepik.com/free-photo/3d-music-related-scene_23-2151124956.jpg?ga=GA1.1.855842492.1728977590&semt=ais_hybrid'), // replace with your image URL
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Learn from Experts\nEnhance Your Musical Skills',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.black45,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              SizedBox(height: 16),



              SizedBox(height: 16),

              // Featured Workshops
              Text(
                'Featured Workshops',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  FeaturedWorkshopCard(
                    imageUrl: 'https://img.freepik.com/premium-photo/dark-background-with-big-white-music-middle_1008415-127464.jpg?ga=GA1.1.855842492.1728977590&semt=ais_hybrid', // replace with your image URL
                    title: 'Mastering Guitar',
                    instructor: 'with John Mayer',
                  ),
                  SizedBox(width: 10),
                  FeaturedWorkshopCard(
                    imageUrl: 'https://img.freepik.com/premium-photo/dark-background-with-big-white-music-middle_1008415-127464.jpg?ga=GA1.1.855842492.1728977590&semt=ais_hybrid', // replace with your image URL
                    title: 'Piano Basics',
                    instructor: 'with Alicia Keys',
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Upcoming Workshops
              Text(
                'Upcoming Workshops',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              WorkshopCard(
                imageUrl: 'https://img.freepik.com/premium-photo/dark-background-with-big-white-music-middle_1008415-127464.jpg?ga=GA1.1.855842492.1728977590&semt=ais_hybrid', // replace with your image URL
                title: 'Advanced Piano',
                instructor: 'Hosted by Jane Smith',
                isJoinable: true,
              ),
              WorkshopCard(
                imageUrl: 'https://img.freepik.com/premium-photo/dark-background-with-big-white-music-middle_1008415-127464.jpg?ga=GA1.1.855842492.1728977590&semt=ais_hybrid', // replace with your image URL
                title: 'Jazz Guitar',
                instructor: 'Hosted by Michael Johnson',
                isJoinable: true,
              ),
              WorkshopCard(
                imageUrl: 'https://img.freepik.com/premium-photo/dark-background-with-big-white-music-middle_1008415-127464.jpg?ga=GA1.1.855842492.1728977590&semt=ais_hybrid', // replace with your image URL
                title: 'Songwriting 101',
                instructor: 'Hosted by Taylor Swift',
                isJoinable: true,
              ),

              SizedBox(height: 16),

              // Popular Instructors
              Text(
                'Popular Instructors',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  InstructorCard(
                    imageUrl: 'https://img.freepik.com/premium-photo/dark-background-with-big-white-music-middle_1008415-127464.jpg?ga=GA1.1.855842492.1728977590&semt=ais_hybrid', // replace with your image URL
                    name: 'Michael Johnson',
                    specialty: 'Jazz Guitar',
                  ),
                  SizedBox(width: 10),
                  InstructorCard(
                    imageUrl: 'https://img.freepik.com/premium-photo/dark-background-with-big-white-music-middle_1008415-127464.jpg?ga=GA1.1.855842492.1728977590&semt=ais_hybrid', // replace with your image URL
                    name: 'Alicia Keys',
                    specialty: 'Piano',
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Recommended for You
              Text(
                'Recommended for You',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              WorkshopCard(
                imageUrl: 'https://img.freepik.com/premium-photo/dark-background-with-big-white-music-middle_1008415-127464.jpg?ga=GA1.1.855842492.1728977590&semt=ais_hybrid', // replace with your image URL
                title: 'Beginner’s Violin',
                instructor: 'Instructed by Sarah Lee',
                isJoinable: false,
              ),
              WorkshopCard(
                imageUrl: 'https://img.freepik.com/premium-photo/dark-background-with-big-white-music-middle_1008415-127464.jpg?ga=GA1.1.855842492.1728977590&semt=ais_hybrid', // replace with your image URL
                title: 'Electronic Music',
                instructor: 'Instructed by Calvin Harris',
                isJoinable: false,
              ),
              WorkshopCard(
                imageUrl: 'https://img.freepik.com/premium-photo/dark-background-with-big-white-music-middle_1008415-127464.jpg?ga=GA1.1.855842492.1728977590&semt=ais_hybrid', // replace with your image URL
                title: 'Blues Guitar',
                instructor: 'Instructed by B.B. King',
                isJoinable: false,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Workshops',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// Reusable Widgets
class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  CategoryChip({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: isSelected ? Color(0xFF002666) : Colors.grey[300],
    );
  }
}

class FeaturedWorkshopCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String instructor;

  FeaturedWorkshopCard(
      {required this.imageUrl, required this.title, required this.instructor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(imageUrl, height: 100, fit: BoxFit.cover),
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            instructor,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class WorkshopCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String instructor;
  final bool isJoinable;

  WorkshopCard(
      {required this.imageUrl,
        required this.title,
        required this.instructor,
        this.isJoinable = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(imageUrl, width: 60, height: 60, fit: BoxFit.cover),
        ),
        title: Text(title),
        subtitle: Text(instructor),
        trailing: isJoinable
            ? ElevatedButton(
          onPressed: () {},
          child: Text('Join Now'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF002666),
          ),
        )
            : null,
      ),
    );
  }
}

class InstructorCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String specialty;

  InstructorCard(
      {required this.imageUrl, required this.name, required this.specialty});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(imageUrl, height: 80, width: 80, fit: BoxFit.cover),
          ),
          SizedBox(height: 5),
          Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(specialty, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
