import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utility/appColors.dart';
import '../../home.dart';
import 'HadithController.dart';
import 'hadithHeadings.dart';


class HadithHomePage extends StatelessWidget {
  HadithHomePage({super.key});
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
          CustomCard(pic: 'frontLogo.png',
              expand: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Words of the\nProphet ﷺ', style: TextStyle(fontFamily: 'Amiri', fontWeight: FontWeight.bold, color: Colors.white),),
                    Text("\"Reading Hadith illuminates the heart, enriches the soul, and guides us toward a life of wisdom and righteousness\"", style: TextStyle(fontSize: size.width/34, color: Colors.white, fontFamily: 'Poppins'),),
                  ],
                ),
              ), height: 5),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4 / 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: HadithController.hadithBooks.length,
                itemBuilder: (context, index) {
                  final hadith = HadithController.hadithBooks[index];
                  return InkWell(
                    onTap: (){
                      hdCont.fetchHadith(hadith['apiName'].toString());
                      Navigator.push(context, CupertinoPageRoute(builder: (context)=>Hadithchapters(hadithBook: hadith,)));
                      // hadith['apiName']
                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              hadith['arabicName']!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: size.height/30,
                                fontFamily: 'Amiri',
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              hadith['englishName']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HadithHeadCard extends StatelessWidget {
  final String eng;
  final String arabic;
  const HadithHeadCard({super.key, required this.eng, required this.arabic});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 3,
        child: Container(
          height: size.height / 5.5,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/back1.png'), fit: BoxFit.cover),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(100, 113, 212, 143), // Original green
                Color.fromARGB(100, 80, 180, 120),  // Darker green
                Color.fromARGB(100, 150, 240, 170), // Lighter green
                Color.fromARGB(100, 80, 180, 120),  // Darker green
                Color.fromARGB(100, 150, 240, 170), // Lighter green
                Color.fromARGB(100, 100, 200, 140), // Muted green
                Color.fromARGB(100, 150, 240, 170), // Lighter green
                Color.fromARGB(100, 100, 200, 140), // Muted green
                Color.fromARGB(100, 113, 212, 143), // Original green
                Color.fromARGB(100, 150, 255, 200), // Lighter green
                Color.fromARGB(100, 100, 200, 140), // Muted green
              ],
            ),
            // color: Color.fromARGB(100, 113, 212, 143), // Background color
            borderRadius: BorderRadius.circular(size.height/70), // Set border radius
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(eng, style: TextStyle(fontFamily: 'Poppins', fontSize: size.height/29, color: Colors.white,fontWeight: FontWeight.bold),),
              Text(arabic, style: TextStyle(fontFamily: 'Amiri', color: Colors.white, fontWeight: FontWeight.bold, fontSize: size.height/36),),
            ],
          ),
        ),
      ),
    );
  }
}
