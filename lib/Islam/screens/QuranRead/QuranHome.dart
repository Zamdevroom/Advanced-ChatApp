import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wa_business/Islam/Utility/appColors.dart';
import 'package:wa_business/Islam/Utility/topPart.dart';
import 'package:wa_business/Islam/home.dart';
import 'package:wa_business/Islam/screens/QuranRead/surahList.dart';

import '../../ClassModals/QuranModal.dart';
import '../../ClassModals/jsonParse.dart';
import '../../Utility/surahListTile.dart';
import 'SurahDetail.dart';
import 'SurahJuzController.dart';
import 'juzListScreen.dart';

class QuranHome extends StatelessWidget {
  // Instantiate the controller
  final SurahJuzController controller = Get.put(SurahJuzController());

  Future<List<Surah>> fetchSurahs() async {
    final data = await loadQuranData();
    final surahs = (data['data']['surahs'] as List)
        .map((surah) => Surah.fromJson(surah))
        .toList();
    return surahs;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        title: Text("Quran", style: TextStyle(color: AppColors.primaryColor, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
      ),
      body: Container(
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/images/background.png'),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: Column(
          children: [
            CustomCard(pic: 'frontLogo.png',
                expand: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Surah Al-Baqarah, (2:2)', style: TextStyle(fontFamily: 'Amiri', fontWeight: FontWeight.bold, color: Colors.white),),
                      Text("\"This is the Book about which there is no doubt, a guidance for those conscious of Allah.\"", style: TextStyle(fontSize: size.width/30, color: Colors.white),),
                    ],
                  ),
                ), height: 5.5),
            // Buttons for Surah and Juz
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width/15),
                      child: Container(
                        height: size.height/21,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Obx(() => InkWell(
                                onTap: () {
                                  controller.toggleView(true); // Set to Surah
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: controller.isSurahSelected.value
                                            ? Colors.green
                                            : Colors.transparent, // Green underline if Surah is selected
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Surah",
                                      style: TextStyle(
                                        color: controller.isSurahSelected.value
                                            ? Colors.green
                                            : Colors.black, // Change text color if Surah is selected
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                            ),
                            SizedBox(width: size.width/20,),
                            Expanded(
                              child: Obx(() => InkWell(
                                onTap: () {
                                  controller.toggleView(false); // Set to Juz
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: !controller.isSurahSelected.value
                                            ? Colors.green
                                            : Colors.transparent, // Green underline if Juz is selected
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Juz",
                                      style: TextStyle(
                                        color: !controller.isSurahSelected.value
                                            ? Colors.green
                                            : Colors.black, // Change text color if Juz is selected
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Obx(() => controller.isSurahSelected.value
                          ? SurahListView()
                          : JuzListScreen()),
                    ),
                  ],
                ),
              ),
            ),

            // Content for Surah or Juz
          ],
        ),
      ),
    );
  }
}
