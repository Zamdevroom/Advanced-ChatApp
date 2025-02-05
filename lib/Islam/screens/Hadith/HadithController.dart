import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wa_business/Islam/screens/Hadith/hadithHeadings.dart';
import 'package:wa_business/Islam/screens/Hadith/hadithModal.dart';

import '../../Utility/appColors.dart';
import '../../home.dart';
import 'HadithHome.dart';
import 'HadithPage.dart';

class Hadithchapters extends StatelessWidget {
  Map<String, dynamic> hadithBook;
  Hadithchapters({super.key, required this.hadithBook});

  HadithController hdCont = Get.put(HadithController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Hadiths', style: TextStyle(fontFamily: 'Poppins', color: AppColors.primaryColor, fontWeight: FontWeight.bold),),
        iconTheme: IconThemeData(
            color: AppColors.primaryColor
        ),
      ),
      body: Column(
        children: [
          HadithHeadCard(eng: hadithBook['englishName'], arabic: hadithBook['arabicName'],),
          Expanded(
            child: Obx((){
              if(hdCont.isLoading.value){
                return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,));
              }
              return ListView.builder(
                  itemBuilder: (context, index){
                    final chap = hdCont.hadith.value.chapters![index];
                    final hadith = hdCont.hadith.value.hadiths;
                    return InkWell(
                      onTap: (){
                        List<HadithDetail> had = hdCont.getHadithsByChapter(chap.id!, hdCont.hadith.value);
                        Navigator.push(context, CupertinoPageRoute(builder: (context)=>HadithListPage(hadiths: had, chapterTitle: chap.english.toString(), bookName: hdCont.hadith.value.metadata!.english!.title.toString(), chapterInArabic: chap.arabic.toString())));
                        print('${chap}');
                      },
                        child: MyListTile(context, chap.id.toString(), chap.english.toString(), chap.arabic.toString(), hdCont.hadith.value.metadata!.english!.title.toString()));
              },
                itemCount: hdCont.hadith.value.chapters!.length,
              );
            }),
          ),
        ],
      ),
    );
  }

}


Widget MyListTile(BuildContext context, String id, String eng, String arabic, String book){
  final size = MediaQuery.of(context).size;
  return Card(
    elevation: 5,
    color: Colors.white,
    child: Container(
      constraints: BoxConstraints(
        minHeight: size.height / 8, // Minimum height
      ),
      // height: size.height / 8,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.height/200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width / 6,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Replace background with SVG
                  SvgPicture.asset('assets/svgs/round1.svg',
                    height: size.height/13,
                    fit: BoxFit.cover,
                  ),
                  Center(
                    child: Text(
                      '${id}',
                      style: TextStyle(
                        fontSize: size.width / 34,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${eng}",
                    style: TextStyle(
                      fontSize: size.width / 20,
                      fontFamily: 'Amiri',
                      fontWeight: FontWeight.bold,
                      // fontStyle: FontStyle.italic,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    "${book}",
                    style: TextStyle(fontSize: size.width / 40, color: AppColors.primaryColor, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: size.width / 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${arabic}",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: size.width / 18,
                        fontFamily: 'Amiri',
                        height: 2,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}