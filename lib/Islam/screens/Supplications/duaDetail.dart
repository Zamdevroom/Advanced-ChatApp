import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wa_business/Islam/Utility/appColors.dart';

import '../../Utility/topPart.dart';
import '../../home.dart';

class DuaView extends StatelessWidget {
  Map<String, String> selectedDua;
  DuaView({super.key, required this.selectedDua});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Supplications', style: TextStyle(fontFamily: 'Poppins', color: AppColors.primaryColor, fontWeight: FontWeight.bold),),
          iconTheme: IconThemeData(
              color: AppColors.primaryColor
          ),
        ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: DuaTag(selectedDua: selectedDua),
                  ),
                ],
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

  Widget MyText(String txt, double fSize, bool isBold, bool isItalic, Color cl){
    return Text(
      txt,
      style: TextStyle(
        fontSize: fSize,
        color: cl,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w300,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        fontFamily: 'Poppins'
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
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size.width/30), // Optional: Rounded corners
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(size.width/30)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(size.width / 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: MyText('${selectedDua['context']}:', size.width / 18, true, false, Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(size.width / 20),
                  child: Column(
                    children: [
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
                        child: MyText('${selectedDua['reference']}', size.width / 30, false, false, AppColors.primaryColor),
                      ),
                      Divider(),
                      Container(height: size.height / 100),
                      // English Translation (left-to-right, default)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: MyText('${selectedDua['english_translation']}', size.width/22, false, false, Colors.black),
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

              ],
            ),
          ),

        ],
      ),
    );
  }
}


