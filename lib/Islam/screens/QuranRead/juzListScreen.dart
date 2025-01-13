import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Utility/appColors.dart';
import '../../Utility/juzListTile.dart';
import 'juzDetail.dart';
import 'juzNamesClass.dart';

class JuzListScreen extends StatefulWidget {
  const JuzListScreen({Key? key}) : super(key: key);

  @override
  State<JuzListScreen> createState() => _JuzListScreenState();
}

class _JuzListScreenState extends State<JuzListScreen> {
  late Future<List<Map<String, dynamic>>> juzDataFuture;
  List<Map<String, dynamic>> allJuzData = [];
  List<Map<String, dynamic>> filteredJuzData = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    juzDataFuture = fetchJuzData();
    juzDataFuture.then((juzData) {
      setState(() {
        allJuzData = juzData;
        filteredJuzData = juzData;
      });
    });
  }

  Future<List<Map<String, dynamic>>> fetchJuzData() async {
    return JuzNames.juzList; // Fetch all Juz data
  }

  void filterJuz(String query) {
    query = query.toLowerCase();
    setState(() {
      filteredJuzData = allJuzData.where((juz) {
        final arabicName = juz['nameArabic'].toLowerCase();
        final englishName = juz['nameEnglish'].toLowerCase();
        final juzNumber = juz['juzNumber'].toString();
        return arabicName.contains(query) ||
            englishName.contains(query) ||
            juzNumber.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search Juz',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
              ),
              style: TextStyle(fontSize: 12.0),
              onChanged: (query) => filterJuz(query),
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: juzDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CupertinoActivityIndicator(
                    color: AppColors.primaryColor,
                    radius: size.height / 30,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          final juz = filteredJuzData[index];
                          final juzNumber = juz['juzNumber'].toString();
                          final arabicName = juz['nameArabic'];
                          final englishName = juz['nameEnglish'];
                          final totalAyat = juz['totalAyat'].toString();

                          return JuzListUi(
                            index: juzNumber,
                            JuzName: englishName,
                            arabic: arabicName,
                            verses: 'Verses: $totalAyat',
                            onPressed: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => JuzDetailScreen(juzNumber: int.parse(juzNumber)),
                                ),
                              );
                            },
                          );
                        },
                        childCount: filteredJuzData.length,
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
