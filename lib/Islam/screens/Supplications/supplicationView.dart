// import 'package:al_hidayah/Supplications/supplicationList.dart';
// import 'package:al_hidayah/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wa_business/Islam/screens/Supplications/supplicationList.dart';
// import 'package:google_fonts/google_fonts.dart';

import '../../Utility/appColors.dart';
import '../../Utility/topPart.dart';
import '../../home.dart';
import '../Salah/TimingsUi.dart';
import 'duaDetail.dart';

class SupplicationListView extends StatelessWidget {

  List<Map<String, String>> duas = DuaList.masnoonDuas;

  SupplicationListView({super.key});

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
            CustomCard(pic: 'frontLogo.png',
                expand: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Soulful Supplications', style: TextStyle(fontFamily: 'Amiri', fontWeight: FontWeight.bold, color: Colors.white, fontSize: size.height/56),),
                      Text("Strengthen your connection with Allah through heartfelt supplications—duas are the key to peace, mercy, and endless blessings.", style: TextStyle(fontSize: size.height/84, color: Colors.white, fontFamily: 'Poppins'),),
                    ],
                  ),
                ), height: 5.5),
            Expanded(
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, CupertinoPageRoute(builder: (context)=> DuaView(selectedDua: duas[index],)));
                          },
                          child: StylishCard(
                            index: index,
                            text: '${duas[index]['context']}',
                            time: '${duas[index]['reference']}',
                            // time: '${index + 1}',
                          ),
                        );
                      },
                      childCount: duas.length,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
