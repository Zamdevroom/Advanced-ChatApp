// import 'package:al_hidayah/Supplications/supplicationList.dart';
// import 'package:al_hidayah/appBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wa_business/Islam/screens/Supplications/supplicationList.dart';
// import 'package:google_fonts/google_fonts.dart';

import '../../Utility/topPart.dart';
import '../Salah/TimingsUi.dart';
import 'duaDetail.dart';

class SupplicationListView extends StatelessWidget {

  List<Map<String, String>> duas = DuaList.masnoonDuas;

  SupplicationListView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
              height: size.height/3.5,
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
                child: Column(
                  children: [
                    SizedBox(height: size.height/100,),
                    Expanded(
                      child: CustomScrollView(
                        physics: BouncingScrollPhysics(),
                        slivers: [
                          // SliverToBoxAdapter(
                          //   child: Padding(
                          //     padding: EdgeInsets.all(size.width / 36),
                          //     child: Container(
                          //       height: size.height/5,
                          //       width: double.infinity,
                          //       decoration: BoxDecoration(
                          //         image: DecorationImage(
                          //           image: AssetImage('assets/dec1.jpg'),
                          //           fit: BoxFit.cover,
                          //         ),
                          //         borderRadius: BorderRadius.circular(size.width / 30),
                          //         boxShadow: [
                          //           BoxShadow(
                          //             color: Get.isDarkMode
                          //                 ? Colors.white.withOpacity(0.2)
                          //                 : Colors.black.withOpacity(0.2),
                          //             blurRadius: 10,
                          //             spreadRadius: 5,
                          //             offset: Offset(0, 5),
                          //           ),
                          //         ],
                          //       ),
                          //       child: Row(
                          //         children: [
                          //           Expanded(
                          //             child: Padding(
                          //               padding: EdgeInsets.all(size.width / 50),
                          //               child: Column(
                          //                 children: [
                          //                   Expanded(
                          //                     child: Column(
                          //                       crossAxisAlignment: CrossAxisAlignment.start,
                          //                       mainAxisAlignment: MainAxisAlignment.center,
                          //                       children: [
                          //                         Text(
                          //                           "Let your heart find peace in the beauty of today’s supplications.",
                          //                           style: TextStyle(
                          //                             fontStyle: FontStyle.italic,
                          //                             color: Colors.white,
                          //                             fontSize: size.width / 24,
                          //                             fontWeight: FontWeight.bold,
                          //                           ),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           ),
                          //           Expanded(
                          //             child: Image.asset(
                          //               'assets/pray.png',
                          //               fit: BoxFit.cover,
                          //             ),
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> DuaView(selectedDua: duas[index],)));
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
            ),
          ],
        ),
      ),
    );
  }
}
