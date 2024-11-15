import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class StudyMaterialScreen extends StatelessWidget {
  StudyMaterialScreen();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // For All, Photos, Audio, PDFs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Study Material'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Photos'),
              Tab(text: 'Audio'),
              Tab(text: 'PDF'),
            ],
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
          ),
        ),
        body: TabBarView(
          children: [
            StudyMaterialGrid(materialType: 'All'),
            StudyMaterialGrid(materialType: 'Photos'),
            StudyMaterialGrid(materialType: 'Audio'),
            StudyMaterialGrid(materialType: 'PDF'),
          ],
        ),
      ),
    );
  }
}

class StudyMaterialGrid extends StatelessWidget {
  final String materialType;

  StudyMaterialGrid({required this.materialType});

  // Updated material list with types and URLs
  final List<Map<String, String>> materials = [
    {'title': 'Sheet Music for Piano', 'type': 'image', 'url': 'https://img.freepik.com/free-photo/portrait-person-playing-music-violin_23-2151051668.jpg?ga=GA1.1.855842492.1728977590&semt=ais_hybrid'},
    {'title': 'Chords Diagram', 'type': 'image', 'url': 'https://img.freepik.com/free-photo/string-instruments-close-up-musical-concert-generative-ai_169016-28900.jpg?ga=GA1.1.855842492.1728977590&semt=ais_hybrid'},
    {'title': 'Jazz Play Along', 'type': 'audio', 'url': 'https://example.com/audio1.mp3'},
    {'title': 'Piano Practice Sheet', 'type': 'pdf', 'url': 'https://example.com/pdf1.pdf'},
    {'title': 'Music Theory', 'type': 'pdf', 'url': 'https://example.com/pdf2.pdf'},
    {'title': 'Drum Lessons', 'type': 'audio', 'url': 'https://example.com/audio2.mp3'},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredMaterials = materials;

    // Filter materials based on materialType
    if (materialType != 'All') {
      filteredMaterials = materials
          .where((material) => material['type'] == materialType.toLowerCase())
          .toList();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: filteredMaterials.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1.5,
        ),
        itemBuilder: (context, index) {
          final material = filteredMaterials[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                    child: _buildMaterialPreview(material, context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    material['title']!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // This function displays the appropriate preview (image, audio player, or PDF)
  Widget _buildMaterialPreview(Map<String, String> material, BuildContext context) {
    switch (material['type']) {
      case 'image':
        return Image.network(
          material['url']!,
          fit: BoxFit.cover,
          width: double.infinity,
        );
      case 'audio':
        return AudioPlayerWidget(url: material['url']!);
      case 'pdf':
        return PDFPreviewWidget(url: material['url']!);
      default:
        return Container();
    }
  }
}

// Audio player widget
class AudioPlayerWidget extends StatefulWidget {
  final String url;

  AudioPlayerWidget({required this.url});

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.play_circle_fill, size: 50),
      onPressed: () async {
        await _audioPlayer.play(widget.url as Source);
      },
    );
  }
}

// PDF preview widget
class PDFPreviewWidget extends StatelessWidget {
  final String url;

  PDFPreviewWidget({required this.url});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.picture_as_pdf, size: 50),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PDFViewScreen(url: url),
          ),
        );
      },
    );
  }
}

// PDF viewing screen
class PDFViewScreen extends StatelessWidget {
  final String url;

  PDFViewScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PDF Viewer')),
      body: PDFView(
        filePath: url,
      ),
    );
  }
}
