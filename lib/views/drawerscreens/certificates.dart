import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(CertificateApp());
}

class CertificateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Certificates',
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: CertificatesScreen(),
    );
  }
}

class CertificatesScreen extends StatelessWidget {
  final List<Map<String, String>> certificates = [
    {
      'image': 'assets/JPEG-1221.jpg',
      'title': 'Data Science Certificate',
      'issuer': 'Issued by Coursera',
    },
    {
      'image': 'assets/JPEG-1221.jpg',
      'title': 'Web Development Certificate',
      'issuer': 'Issued by Udacity',
    },
    {
      'image': 'assets/JPEG-1221.jpg',
      'title': 'Digital Marketing Certificate',
      'issuer': 'Issued by Google',
    },
    {
      'image': 'assets/JPEG-1221.jpg',
      'title': 'Graphic Design Certificate',
      'issuer': 'Issued by Adobe',
    },
    {
      'image': 'assets/JPEG-1221.jpg',
      'title': 'Cybersecurity Certificate',
      'issuer': 'Issued by IBM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Certificates', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Certificates',
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.mic),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: 'Date Issued',
                  items: <String>['Date Issued', 'Course Name', 'Completion']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ],
            ),
          ),
          Expanded(
            child: certificates.isNotEmpty
                ? ListView.builder(
              itemCount: certificates.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ListTile(
                      leading: Image.asset(
                        certificates[index]['image']!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        certificates[index]['title']!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(certificates[index]['issuer']!),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: () {
                          // Navigate to details screen or handle action
                        },
                        child: Text('View Details'),
                      ),
                    ),
                  ),
                );
              },
            )
                : NoCertificatesPlaceholder(),
          ),
        ],
      ),
    );
  }
}

class NoCertificatesPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/no_certificates.png',
            width: 150,
            height: 150,
          ),
          SizedBox(height: 16),
          Text(
            'No Certificates Yet',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 8),
          Text('Complete more courses to earn certificates.'),
        ],
      ),
    );
  }
}
