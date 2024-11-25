import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart';

class DownloadSyllabusScreen extends StatefulWidget {
  @override
  _DownloadSyllabusScreenState createState() => _DownloadSyllabusScreenState();
}

class _DownloadSyllabusScreenState extends State<DownloadSyllabusScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<Offset>> _slideAnimations;

  final List<Map<String, String>> subjects = [
    {
      "title": "Hindustani Classical Vocal (Bhatkhande Sangit Vidyapith)",
      "description": "Explore the world of Hindustani Classical music...",
      "imageUrl": "https://img.freepik.com/free-vector/gradient-vasant-panchami-festival-illustration_23-2149967341.jpg?uid=R140677545&ga=GA1.1.1738895608.1731651292&semt=ais_hybrid",
      "pdf": "assets/syllabus/1. Hindustani Classical Vocal (Bhatkhande Sangit Vidyapith).pdf",
    },
    {
      "title": "Hindustani Classical Vocal (Surnandan Bharati)",
      "description": "Discover the beauty of Indian classical vocals...",
      "imageUrl": "https://img.freepik.com/free-vector/decorative-happy-vasant-panchami-festival-card-with-veena-illustration_1055-20317.jpg?uid=R140677545&ga=GA1.1.1738895608.1731651292&semt=ais_hybrid",
      "pdf": "assets/syllabus/2. Hindustani Classical Vocal (Surnandan Bharati).pdf",
    },
    {
      "title": "Western Vocal (Trinity College)",
      "description": "Learn Western vocal techniques...",
      "imageUrl": "https://img.freepik.com/free-vector/hand-drawn-country-music-illustration_52683-86250.jpg?uid=R140677545&ga=GA1.1.1738895608.1731651292&semt=ais_hybrid",
      "pdf": "assets/syllabus/3. Western Vocal (Trinity College).pdf",
    },
    {
      "title": "Western Vocal (RockSchool)",
      "description": "Master Western vocals with RockSchool...",
      "imageUrl": "https://img.freepik.com/free-vector/flat-design-gaucho-character-dancing-illustration_23-2149217270.jpg?uid=R140677545&ga=GA1.1.1738895608.1731651292&semt=ais_hybrid",
      "pdf": "assets/syllabus/western_vocal_rockschool.pdf",
    },
    {
      "title": "Electronic Keyboard (Trinity College)",
      "description": "Explore the art of electronic keyboard...",
      "imageUrl": "https://img.freepik.com/free-photo/top-view-female-musician-blogger-streaming-home-with-smartphone_23-2148771588.jpg?uid=R140677545&ga=GA1.1.1738895608.1731651292&semt=ais_hybrid",
      "pdf": "assets/syllabus/4. Electronic Keyboard (trinity college).pdf",
    },
    {
      "title": "Electronic Keyboard (RockSchool)",
      "description": "Master keyboard techniques with RockSchool...",
      "imageUrl": "https://img.freepik.com/free-photo/close-up-artists-playing-instruments_23-2149130810.jpg?uid=R140677545&ga=GA1.1.1738895608.1731651292&semt=ais_hybrid",
      "pdf": "assets/syllabus/electronic_keyboard_rockschool.pdf",
    },
    {
      "title": "Keyboard (Surnandan Bharati)",
      "description": "Dive into keyboard techniques by Surnandan Bharati...",
      "imageUrl": "https://img.freepik.com/free-photo/electronic-musical-instrument-audio-mixer-sound-equalizer-analog-modular-synthesizer_1381-3.jpg?uid=R140677545&ga=GA1.1.1738895608.1731651292&semt=ais_hybrid",
      "pdf": "assets/syllabus/5. Keybaord (Surnandan Bharati).pdf",
    },
    {
      "title": "Acoustic Guitar (Trinity College)",
      "description": "Learn acoustic guitar from Trinity College...",
      "imageUrl": "https://img.freepik.com/free-photo/classic-acoustic-guitar_144627-26953.jpg?uid=R140677545&ga=GA1.1.1738895608.1731651292&semt=ais_hybrid",
      "pdf": "assets/syllabus/6. Acoustic Guitar (trinity College).pdf",
    },
    {
      "title": "Acoustic Guitar (RockSchool)",
      "description": "Master acoustic guitar with RockSchool...",
      "imageUrl": "https://img.freepik.com/premium-photo/man-with-guitar-ruined-building-urban-style_123827-10875.jpg?uid=R140677545&ga=GA1.1.1738895608.1731651292&semt=ais_hybrid",
      "pdf": "assets/syllabus/acoustic_guitar_rockschool.pdf",
    },
    {
      "title": "Guitar Badya (Surnandan Bharati)",
      "description": "Explore the traditional art of Guitar Badya...",
      "imageUrl": "https://img.freepik.com/free-photo/close-up-acoustic-guitar-guy-sitting_23-2148366455.jpg?uid=R140677545&ga=GA1.1.1738895608.1731651292&semt=ais_hybrid",
      "pdf": "assets/syllabus/8. Guitar Badya (Surnandan Bharati).pdf",
    },
    {
      "title": "Guitar Classical (Surnandan Bharati)",
      "description": "Master classical guitar techniques...",
      "imageUrl": "https://img.freepik.com/premium-photo/acoustic-guitar-music-concept-guitar-rusty-dark-room-with-lights-room-with-guitar_85672-502.jpg?uid=R140677545&ga=GA1.1.1738895608.1731651292&semt=ais_hybrid",
      "pdf": "assets/syllabus/9. Rock & Pop Guitar Syllabus ( Trinity College).pdf",
    },
    {
      "title": "Flute (Surnandan Bharati)",
      "description": "Discover the soothing art of flute playing...",
      "imageUrl": "https://img.freepik.com/free-vector/happy-janmashtami-with-lord-krishna-hand-playing-bansuri-card-background_1035-29092.jpg?uid=R140677545&ga=GA1.1.1738895608.1731651292&semt=ais_hybrid",
      "pdf": "assets/syllabus/10. Flute (Surnandan Bharati).pdf",
    },
  ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // Initialize slide animations for each card
    _slideAnimations = List.generate(
      subjects.length,
          (index) => Tween<Offset>(
        begin: Offset(1.0, 0.0), // Start off-screen to the right
        end: Offset(0.0, 0.0), // End at its normal position
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.1, // Delay for each card
            1.0,
            curve: Curves.easeOut,
          ),
        ),
      ),
    );

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _downloadPdf(String pdfPath) async {
    try {
      final ByteData data = await rootBundle.load(pdfPath);
      final String tempDir = (await getTemporaryDirectory()).path;
      final String tempPath = '$tempDir/${pdfPath.split('/').last}';
      final File file = File(tempPath);
      await file.writeAsBytes(data.buffer.asUint8List());

      Share.shareXFiles(
        [XFile(file.path)],
        text: "Download your syllabus!",
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error downloading file: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download Syllabus'),
        actions: [
        ],
      ),
      body: ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          final subject = subjects[index];
          return SlideTransition(
            position: _slideAnimations[index],
            child: Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                contentPadding: const EdgeInsets.all(15),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    subject['imageUrl']!,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  subject['title']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(subject['description']!),
                trailing: ElevatedButton(
                  onPressed: () => _downloadPdf(subject['pdf']!),
                  child: const Text('Download Now'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
