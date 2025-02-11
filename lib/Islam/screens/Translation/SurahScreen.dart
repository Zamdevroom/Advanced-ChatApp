import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wa_business/Islam/Utility/appColors.dart';
import 'package:wa_business/Islam/screens/Settings/settingController.dart';
import 'package:wa_business/Islam/screens/Translation/translationController.dart';
import '../../ClassModals/QuranModal.dart';
import '../../Utility/SurahCard.dart';
import '../../Utility/topPart.dart';
import 'BottomSheet.dart';
import 'TranslationModal.dart';

class TranslationSurahView extends StatefulWidget {
  final Surahs selectedSurah;
  final Surahs translationSurah;

  TranslationSurahView({super.key, required this.selectedSurah, required this.translationSurah});

  @override
  State<TranslationSurahView> createState() => _TranslationSurahViewState();
}

class _TranslationSurahViewState extends State<TranslationSurahView> {
  final settingCont getxSetting = Get.put(settingCont());
  final TranslationControl trCont = Get.put(TranslationControl());
  // Surah? translationSurah;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(widget.translationSurah.name);
    // Quran trQuran = trCont.translationQuran.value;
    // int num = widget.selectedSurah.number;
    // translationSurah = trQuran.data?.surahs?.firstWhere(
    //       (surah) => surah.number == num,
    //   orElse: () => null, // Return null if no matching Surah is found
    // );
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Surah',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: AppColors.primaryColor,
          ),
        ),
        iconTheme: IconThemeData(
          color: AppColors.primaryColor,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            // Header Section
            SurahCard(selectedSurah: widget.selectedSurah,),
            if (widget.selectedSurah.ayahs != null &&
                widget.selectedSurah.ayahs!.isNotEmpty)
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.selectedSurah.ayahs!.length,
                itemBuilder: (context, index) {
                  String ayahText =
                      widget.selectedSurah.ayahs![index].text ?? "";
                  String transText = widget.translationSurah.ayahs![index].text ?? "";

                  // Handle "Bismillah" removal for non-Surah Al-Fatihah
                  if (widget.selectedSurah.number != 1 &&
                      index == 0 &&
                      ayahText.contains(
                          "بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ")) {
                    ayahText = ayahText.replaceFirst(
                        "بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ", "").trim();
                    transText = transText.replaceFirst(
                        "بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ", "").trim();
                  }

                  return _buildAyahCard(ayahText, transText, index, size);
                },
              )
            else
              const Center(child: Text("No Ayahs available")),
          ],
        ),
      ),
    );
  }

  // Widget for displaying each ayah
  Widget _buildAyahCard(String ayahText, String transText, int index, Size size) {
    return Container(
      width: size.width,
      child: Card(
        color: const Color(0xFFF9F9F9),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width / 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: size.height / 30),
              Obx(()=>
                  Text(
                    '$ayahText (${index + 1})',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      // fontSize: size.width / 30,
                      fontSize: size.height/35 * getxSetting.sliderValue.value,
                      height: 2.3, // Adjusted line height
                      decorationColor: const Color(0xFF00A49B),
                    ),
                  ),
              ),
              Obx(()=>
                  Text(
                    '$transText',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: 'Amiri',
                      // fontSize: size.width / 30,
                      fontSize: size.height/50 * getxSetting.sliderValue.value,
                      height: 2.3, // Adjusted line height
                      decorationColor: const Color(0xFF00A49B),
                    ),
                  ),
              ),
              SizedBox(height: size.height / 30),
            ],
          ),
        ),
      ),
    );
  }
}
