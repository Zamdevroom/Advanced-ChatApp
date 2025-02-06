import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wa_business/Islam/Utility/SurahCard.dart';
import 'package:wa_business/Islam/Utility/appColors.dart';
import 'package:wa_business/Islam/screens/QuranRead/juzNamesClass.dart';
import 'package:wa_business/Islam/screens/Settings/settingController.dart';
import '../Translation/TranslationModal.dart';
import '../Translation/translationController.dart';
import 'BottomSheet.dart';

class Juztranslation extends StatefulWidget {
  final int juzNumber;

  const Juztranslation({Key? key, required this.juzNumber}) : super(key: key);

  @override
  State<Juztranslation> createState() => _JuzDetailScreenState();
}

class _JuzDetailScreenState extends State<Juztranslation> {
  final settingCont getxSetting = Get.put(settingCont());
  final TranslationControl translationController =
      Get.put(TranslationControl());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '${JuzNames.juzList[widget.juzNumber - 1]['nameEnglish']}',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: AppColors.primaryColor),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actions: [
          IconButton(onPressed: (){
            LanguageBottomSheet.showLanguageSelectionBottomSheet(context);
          }, icon: Icon(Icons.language))
        ],
      ),
      body: Obx(() {
        if (translationController.quran.value.data == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final surahAyahList = <Map<String, dynamic>>[]; // List of Surah and Ayah
        final surahAyahTranslation = <Map<String, dynamic>>[]; // List of Surah and Ayah

        for (var surah in translationController.quran.value.data!.surahs!) {
          final ayahsInJuz = surah.ayahs!
              .where((ayah) => ayah.juz == widget.juzNumber)
              .toList();
          if (ayahsInJuz.isNotEmpty) {
            surahAyahList.add({'surah': surah, 'ayahs': ayahsInJuz});
          }
        }
        for (var surah in translationController.translationQuran.value.data!.surahs!) {
          final ayahsInJuz = surah.ayahs!
              .where((ayah) => ayah.juz == widget.juzNumber)
              .toList();
          if (ayahsInJuz.isNotEmpty) {
            surahAyahTranslation.add({'surah': surah, 'ayahs': ayahsInJuz});
          }
        }

        return Column(
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
                                        builder: (context) => Juztranslation(
                                            juzNumber: widget.juzNumber + 1)),
                                  );
                                },
                                icon: Icon(Icons.arrow_back_ios))
                      ],
                    ),
                  ),
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
                                        builder: (context) => Juztranslation(
                                            juzNumber: widget.juzNumber - 1)),
                                  );
                                },
                                icon: Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: surahAyahList.length,
                itemBuilder: (context, index) {
                  final surah = surahAyahList[index]['surah'] as Surahs;
                  final ayahs = surahAyahList[index]['ayahs'] as List<Ayahs>;
                  final trans = surahAyahTranslation[index]['ayahs'] as List<Ayahs>;
                  return Card(
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SurahCard(selectedSurah: surah),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: ayahs.length,
                          itemBuilder: (context, ayahIndex) {
                            final ayah = ayahs[ayahIndex];
                            final tran = trans[ayahIndex];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Obx(
                                () => Column(
                                  // mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ayahIndex == 0?SizedBox.shrink():Divider(),
                                    Text(
                                      '${ayah.text} (${ayah.numberInSurah}) ',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: size.height /
                                            35 *
                                            getxSetting.sliderValue.value,
                                        color: Colors.black,
                                        fontFamily:
                                            'Amiri', // Replace with your Quranic font
                                        height:
                                            2.3, // Adjust line height for better readability
                                      ),
                                    ),
                                    Text(
                                      '${tran.text}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: size.height /
                                            60 *
                                            getxSetting.sliderValue.value,
                                        color: Colors.black,
                                        fontFamily:
                                            'Amiri', // Replace with your Quranic font
                                        height:
                                            2.3, // Adjust line height for better readability
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
