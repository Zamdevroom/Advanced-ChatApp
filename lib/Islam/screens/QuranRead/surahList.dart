import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wa_business/Islam/Utility/appColors.dart';

import '../../ClassModals/QuranModal.dart';
import '../../ClassModals/jsonParse.dart';
import '../../Utility/surahListTile.dart';
import 'SurahDetail.dart';

class SurahListView extends StatefulWidget {
  const SurahListView({super.key});

  @override
  State<SurahListView> createState() => _SurahListView();
}

class _SurahListView extends State<SurahListView> {
  late Future<List<Surah>> surahsFuture;
  List<Surah> allSurahs = [];
  List<Surah> filteredSurahs = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    surahsFuture = fetchSurahs();
    surahsFuture.then((surahs) {
      setState(() {
        allSurahs = surahs;
        filteredSurahs = surahs;
      });
    });
  }

  Future<List<Surah>> fetchSurahs() async {
    final data = await loadQuranData();
    final surahs = (data['data']['surahs'] as List)
        .map((surah) => Surah.fromJson(surah))
        .toList();
    return surahs;
  }

  void filterSurahs(String query) {
    query = query.toLowerCase();
    setState(() {
      filteredSurahs = allSurahs.where((surah) {
        return surah.englishName.toLowerCase().contains(query) ||
            surah.name.toLowerCase().contains(query) ||
            surah.revelationType.toLowerCase().contains(query) ||
            surah.number.toString() == query;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final myHeight = size.height;
    final myWidth = size.width;

    return Column(
      children: [
        Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search Surah',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[200], // Light gray color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide.none, // No visible border
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0), // Reduced vertical padding
              ),
              style: TextStyle(fontSize: 12.0),
              onChanged: (query) => filterSurahs(query),
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Surah>>(
            future: surahsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
              } else if (snapshot.hasError) {
                return Center(child: Text('Error loading Quran'));
              } else if (snapshot.hasData) {
                return CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          final surah = filteredSurahs[index];
                          return ListUi(
                            index: (surah.number).toString(),
                            surahName: surah.englishName,
                            engName: surah.englishNameTranslation,
                            arabic: surah.name,
                            reveal: surah.revelationType,
                            onPressed: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => SurahView(selectedSurah: surah),
                                ),
                              );
                            },
                          );
                        },
                        childCount: filteredSurahs.length, // Ensure child count matches the filtered list size
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: Text('No data found'));
              }
            },
          ),
        ),
      ],
    );
  }
}
