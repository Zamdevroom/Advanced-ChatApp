import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wa_business/Islam/Utility/appColors.dart';

import '../../Utility/topPart.dart';

class DuaView extends StatelessWidget {
  Map<String, String> selectedDua;
  DuaView({super.key, required this.selectedDua});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(title: Text("Supplications"),),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            TopSection(
              height: size.height/8,
              text: "Supplications",
              customWidget: Center(),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size.height / 30),
                    topRight: Radius.circular(size.height / 30),
                  ),
                ),
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: DuaTag(selectedDua: selectedDua),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

class DuaTag extends StatelessWidget {
  Map<String, String> selectedDua;
  DuaTag({super.key, required this.selectedDua});

  Widget MyText(String txt, double fSize, bool isBold, bool isItalic){
    return Text(
      txt,
      style: TextStyle(
        fontSize: fSize,
        color: Colors.white,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w300,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.width / 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(size.width / 30),
              boxShadow: [
                BoxShadow(
                  // color: Get.isDarkMode ? Colors.white12 : Colors.black12,
                  color: AppColors.primaryColor,
                  blurRadius: 40,
                  spreadRadius: 4,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(size.width / 20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: MyText('${selectedDua['context']}:', size.width / 16, true, true),
                  ),
                  Divider(color: Colors.white,),
                  Container(height: size.height / 50),

                  // Dua text in Arabic (centered)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${selectedDua['dua']}',
                      style: TextStyle(fontSize: size.width / 12, height:size.height/450, fontFamily: 'Amiri'),
                      textDirection: TextDirection.rtl, // Ensures right-to-left direction
                      textAlign: TextAlign.right, // Aligns text to the right
                    ),
                  ),
                  Container(height: size.height / 100),
                  Align(
                    alignment: Alignment.centerRight,
                    child: MyText('${selectedDua['reference']}', size.width / 30, false, true),
                  ),
                  Divider(),
                  Container(height: size.height / 100),
                  // English Translation (left-to-right, default)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: MyText('${selectedDua['english_translation']}', size.width/22, false, true),
                  ),
                  Container(height: size.height / 100),
                  Divider(),
                  Container(height: size.height / 100),
                  // Urdu Translation (right-to-left)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${selectedDua['urdu_translation']}',
                      style: TextStyle(fontSize: size.width / 22, height: size.height/450, fontFamily: 'Amiri'), // Use Urdu-supporting font
                      textDirection: TextDirection.rtl, // Ensures right-to-left direction
                      textAlign: TextAlign.right, // Aligns text to the right
                    ),
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}


