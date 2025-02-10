import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utility/appColors.dart';
import '../Utility/topPart.dart';
import '../home.dart';
import '../screens/QuranRead/SurahJuzController.dart';
import '../screens/QuranRead/juzListScreen.dart';
import '../screens/QuranRead/surahList.dart';
import 'BayanScreen.dart';

class VideoHomePage extends StatelessWidget {
  const VideoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final SurahJuzController controller = Get.put(SurahJuzController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('IlmTube', style: TextStyle(fontFamily: 'Poppins', color: AppColors.primaryColor, fontWeight: FontWeight.bold),),
        iconTheme: IconThemeData(
            color: AppColors.primaryColor
        ),
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                    left: size.width / 70,
                    right: size.width / 70,
                  ),
                  child: CustomCard(pic: 'frontLogo.png',
                    expand: Padding(
                      padding: EdgeInsets.all(size.width/40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Islamic Scholars Hub", style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: size.height/60, fontWeight: FontWeight.bold)),
                          Text(
                            "Enlighten your soul with Islamic videos, bayans, and beautiful Qirat—let Allah's words guide you.",
                            style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: size.height / 76),
                          ),
                        ],
                      ),
                    ), height: 6,
                  )
              ),
              // Buttons for Surah and Juz
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width/15),
                child: Container(
                  height: size.height/20,
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
                                "Bayan",
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
                                "Recitation",
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
                    ? BayanScreen(isBayan: true,)
                    : BayanScreen(isBayan: false,)),
              ),
              // Content for Surah or Juz
            ],
          ),
        ),
      ),
    );
  }
}
