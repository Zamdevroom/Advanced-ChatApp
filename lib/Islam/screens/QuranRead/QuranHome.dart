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
import '../Translation/BottomSheet.dart';
import '../Translation/translationController.dart';
import 'SurahDetail.dart';
import 'SurahJuzController.dart';
import 'juzListScreen.dart';

class QuranHome extends StatefulWidget {
  bool isQuran;
  QuranHome({required this.isQuran});

  @override
  State<QuranHome> createState() => _QuranHomeState();
}

class _QuranHomeState extends State<QuranHome> {
  // Instantiate the controller
  final SurahJuzController controller = Get.put(SurahJuzController());
  final TranslationControl quranController = Get.put(TranslationControl());

  @override
  void initState(){
    super.initState();
    // if(widget.isQuran){
    //   print('asdkjhf');
    //   quranController.getQuran();
    // }else{
    //   fetchTrans();
    // }
  }

  Future<void> fetchTrans()async{
    print('trans');
    quranController.getQuran();
    quranController.getTranslation();
  }

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
          color: AppColors.primaryColor,
        ),
        title: Text(widget.isQuran?"Quran":"Translation", style: TextStyle(color: AppColors.primaryColor, fontFamily: 'Poppins', fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        actions: [
          widget.isQuran?SizedBox.shrink():
          IconButton(onPressed: (){
            print('fat');
            LanguageBottomSheet.showLanguageSelectionBottomSheet(context);
          }, icon: Icon(Icons.language))
        ],
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
                      Text('Quran: Light & Guidance', style: TextStyle(fontFamily: 'Amiri', fontWeight: FontWeight.bold, color: Colors.white, fontSize: size.height/66),),
                      Text("\"Let the Quran be your guide, your light, and your comfort. Every verse brings you closer to Allah and fills your heart with peace\"", style: TextStyle(fontSize: size.height/80, color: Colors.white),),
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
                                  print('hello');
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
                                        fontFamily: 'Poppins',
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
                                  print('hello');
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
                                        fontFamily: 'Poppins',
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
                          ? SurahListView(isQuran: widget.isQuran,)
                          : JuzListScreen(isQuran: widget.isQuran,)),
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
