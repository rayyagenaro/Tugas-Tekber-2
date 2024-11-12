import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AboutPage',
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: const AboutPage(),
    );
  }
}

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int _currentPhotoIndex = 0;
  final PageController _activityPageController = PageController();

  // Foto untuk tampilan utama
  final List<String> _photos = [
    'assets/foto1.jpg',
    'assets/foto2.jpg',
    'assets/foto3.jpg',
  ];

  // Foto untuk carousel kegiatan
  final List<String> _activityPhotos = [
    'assets/foto4.jpg',
    'assets/foto5.jpg',
    'assets/foto6.jpg',
    'assets/foto7.jpg',
  ];

  String _selectedTab = 'Pengenalan';

  // Function to open URL
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Function to change photo
  void _nextPhoto() {
    setState(() {
      _currentPhotoIndex = (_currentPhotoIndex + 1) % _photos.length;
    });
  }

  void _previousPhoto() {
    setState(() {
      _currentPhotoIndex =
          (_currentPhotoIndex - 1 + _photos.length) % _photos.length;
    });
  }

  // Function to navigate carousel activities
  void _nextActivityPhoto() {
    _activityPageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousActivityPhoto() {
    _activityPageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Function to display content based on selected tab
  String _getTabContent() {
    switch (_selectedTab) {
      case 'Pengalaman':
        return 'Director Operational ISE! 2024\nProject Officer PMO HMSI 2024\nStaff HRD HMSI Kabinet Inovasi';
      case 'Harapan':
        return 'Sehat selalu dan diberkati oleh Tuhan';
      default:
        return 'Hai, kenalin aku Genaro, aku berasal dari Kota Surabaya. Aku adalah Pemuda yang sekarang menempuh pendidikan di ITS di Jurusan Sistem Informasi. Saya memiliki sebuah funfact yaitu saya tidak bisa makan pisang :), dan juga saya sering tidur menggelinding jadi jatuh ke lantai.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: const Text(
          'Genaros Life',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          // Nama dan NRP di atas foto
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Rayya Genaro',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.7),
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  '5026221116',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.7),
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Foto dengan tombol navigasi
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _previousPhoto,
              ),
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(_photos[_currentPhotoIndex]),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: _nextPhoto,
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Nama lengkap dan NRP di bawah foto
          const Text(
            'Athaalla Rayya Genaro Iswandoko',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
            '5026221116',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontFamily: 'Poppins',
            ),
          ),

          const SizedBox(height: 20),

          // Ikon Sosial Media
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Image.asset('assets/wa.png', width: 48, height: 48),
                onPressed: () {
                  _launchURL('https://wa.me/6282231065750');
                },
              ),
              IconButton(
                icon: Image.asset('assets/insta.png', width: 48, height: 48),
                onPressed: () {
                  _launchURL('https://www.instagram.com/rayyagenaro');
                },
              ),
              IconButton(
                icon: Image.asset('assets/spotify.png', width: 48, height: 48),
                onPressed: () {
                  _launchURL(
                      'https://open.spotify.com/user/21o3uzwppglp24boininoiffy?si=PtGDWaUFToGieAUa3FdL0A');
                },
              ),
            ],
          ),

          const SizedBox(height: 26),

          // Bagian tab untuk Pengenalan, Pengalaman, dan Harapan
          Container(
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTabButton('Pengenalan'),
                _buildTabButton('Pengalaman'),
                _buildTabButton('Harapan'),
              ],
            ),
          ),

          // Konten berdasarkan tab yang dipilih
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              _getTabContent(),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Bagian "Kegiatan"
          const Divider(),
          const Text(
            'Kegiatan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  controller: _activityPageController,
                  itemCount: _activityPhotos.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        _activityPhotos[index],
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
                Positioned(
                  left: 0,
                  top: 50,
                  bottom: 50,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: _previousActivityPhoto,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 50,
                  bottom: 50,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: _nextActivityPhoto,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk tombol tab
  Widget _buildTabButton(String title) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = title;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _selectedTab == title ? Colors.blue : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: _selectedTab == title ? Colors.blue[800] : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
