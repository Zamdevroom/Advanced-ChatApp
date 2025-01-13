import 'dart:async';
import 'package:flutter/material.dart';
import '../../ClassModals/QuranModal.dart';
import '../../ClassModals/jsonParse.dart';

class JuzDetailScreen extends StatefulWidget {
  final int juzNumber;

  const JuzDetailScreen({Key? key, required this.juzNumber}) : super(key: key);

  @override
  State<JuzDetailScreen> createState() => _JuzDetailScreenState();
}

class _JuzDetailScreenState extends State<JuzDetailScreen> {
  late ScrollController _scrollController;
  Timer? _autoScrollTimer;
  bool _isAutoScrollingEnabled = false;
  double _scrollSpeed = 10.0; // Default to normal speed
  final Map<double, int> speedDurations = {
    1.0: 500, // Slow speed: 1000 ms per scroll
    2.0: 250,  // Normal speed: 500 ms per scroll
    3.0: 50,  // Fast speed: 250 ms per scroll
  };

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    final scrollDurationMs = speedDurations[_scrollSpeed] ?? 500; // Default to normal speed if no valid speed
    final scrollDuration = Duration(milliseconds: scrollDurationMs);

    _autoScrollTimer = Timer.periodic(scrollDuration, (timer) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.offset + 2.0, // Scroll by a fixed amount
          duration: scrollDuration,
          curve: Curves.linear,
        );
      }
    });
  }

  void _stopAutoScroll() {
    _autoScrollTimer?.cancel();
  }

  Future<Map<Surah, List<Ayah>>> fetchAyahsGroupedBySurah(int juzNumber) async {
    // Load Quran data
    final data = await loadQuranData();

    // Parse Surahs
    final surahs = (data['data']['surahs'] as List)
        .map((surahJson) => Surah.fromJson(surahJson))
        .toList();

    // Filter Ayahs by Juz number and group them by Surah
    final surahAyahMap = <Surah, List<Ayah>>{};
    for (var surah in surahs) {
      final ayahsInJuz = surah.ayahs.where((ayah) => ayah.juz == juzNumber).toList();
      if (ayahsInJuz.isNotEmpty) {
        surahAyahMap[surah] = ayahsInJuz;
      }
    }

    return surahAyahMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juz ${widget.juzNumber}'),
        actions: [
          // Toggle for Auto-Scrolling
          Switch(
            value: _isAutoScrollingEnabled,
            onChanged: (value) {
              setState(() {
                _isAutoScrollingEnabled = value;
              });

              if (_isAutoScrollingEnabled) {
                _startAutoScroll();
              } else {
                _stopAutoScroll();
              }
            },
          ),
          // Dropdown for Speed Selection
          PopupMenuButton<double>(
            onSelected: (speed) {
              setState(() {
                _scrollSpeed = speed;
              });

              // Restart auto-scroll with the new speed
              if (_isAutoScrollingEnabled) {
                _stopAutoScroll();
                _startAutoScroll();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<double>(
                  value: 1.0, // Slow speed
                  child: Text('Slow'),
                ),
                PopupMenuItem<double>(
                  value: 2.0, // Normal speed
                  child: Text('Normal'),
                ),
                PopupMenuItem<double>(
                  value: 3.0, // Fast speed
                  child: Text('Fast'),
                ),
              ];
            },
            icon: Icon(Icons.speed),
          ),
        ],
      ),
      body: FutureBuilder<Map<Surah, List<Ayah>>>(
        future: fetchAyahsGroupedBySurah(widget.juzNumber),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found.'));
          }

          final surahAyahMap = snapshot.data!;
          return ListView.builder(
            controller: _scrollController, // Attach the ScrollController
            itemCount: surahAyahMap.length,
            itemBuilder: (context, index) {
              final surah = surahAyahMap.keys.elementAt(index);
              final ayahs = surahAyahMap[surah]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Surah Header
                  Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Surah ${surah.name} (${surah.englishName})',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Revelation Type: ${surah.revelationType}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Total Ayat: ${surah.ayahs.length}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // List of Ayahs
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontFamily: 'Amiri', // Replace with your Quranic font
                          height: 2, // Adjust line height for better readability
                        ),
                        children: ayahs.map((ayah) {
                          return TextSpan(
                            text: '${ayah.text} (${ayah.numberInSurah}) ',
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
