import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wa_business/Islam/Utility/SurahCard.dart';
import 'package:wa_business/Islam/Utility/appColors.dart';
import 'package:wa_business/Islam/screens/QuranRead/juzNamesClass.dart';
import 'package:wa_business/Islam/screens/Settings/settingController.dart';
import '../../ClassModals/QuranModal.dart';
import '../../ClassModals/jsonParse.dart';
import '../../Utility/topPart.dart';

class JuzDetailScreen extends StatefulWidget {
  final int juzNumber;

  const JuzDetailScreen({Key? key, required this.juzNumber}) : super(key: key);

  @override
  State<JuzDetailScreen> createState() => _JuzDetailScreenState();
}

class _JuzDetailScreenState extends State<JuzDetailScreen> {
  final settingCont getxSetting = Get.put(settingCont());
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
      final ayahsInJuz =
          surah.ayahs.where((ayah) => ayah.juz == juzNumber).toList();
      if (ayahsInJuz.isNotEmpty) {
        surahAyahMap[surah] = ayahsInJuz;
      }
    }

    return surahAyahMap;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('${JuzNames.juzList[widget.juzNumber - 1]['nameEnglish']}',
          style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic,color: AppColors.primaryColor),),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size.height / 30),
                    topRight: Radius.circular(size.height / 30),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      color: Color.fromARGB(50, 150, 240, 170),
                      height: size.height / 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              widget.juzNumber == 30
                                  ? SizedBox.shrink()
                                  : IconButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    JuzDetailScreen(
                                                        juzNumber:
                                                            widget.juzNumber +
                                                                1)));
                                      },
                                      icon: Icon(Icons.arrow_back_ios))
                            ],
                          )),
                          Text('Chapter ${widget.juzNumber}'),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              widget.juzNumber == 1
                                  ? SizedBox.shrink()
                                  : IconButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    JuzDetailScreen(
                                                        juzNumber:
                                                            widget.juzNumber -
                                                                1)));
                                      },
                                      icon: Icon(Icons.arrow_forward_ios))
                            ],
                          ))
                        ],
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder<Map<Surah, List<Ayah>>>(
                        future: fetchAyahsGroupedBySurah(widget.juzNumber),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(child: Text('No data found.'));
                          }

                          final surahAyahMap = snapshot.data!;
                          return ListView.builder(
                            itemCount: surahAyahMap.length,
                            itemBuilder: (context, index) {
                              final surah = surahAyahMap.keys.elementAt(index);
                              final ayahs = surahAyahMap[surah]!;

                              return Card(
                                elevation: 5,
                                // color: Colors.white70,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SurahCard(selectedSurah: surah),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Obx(
                                            () => RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            style: TextStyle(
                                              fontSize: size.height / 35 * getxSetting.sliderValue.value,
                                              color: Colors.black,
                                              fontFamily: 'Amiri', // Replace with your Quranic font
                                              height: 2.3, // Adjust line height for better readability
                                            ),
                                            children: ayahs.map((ayah) {
                                              return TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: '${ayah.text} (${ayah.numberInSurah}) ',
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.normal,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
