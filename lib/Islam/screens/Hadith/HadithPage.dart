import 'package:flutter/material.dart';

import '../../Utility/appColors.dart';
import 'hadithModal.dart';

class HadithListPage extends StatelessWidget {
  final List<HadithDetail> hadiths;
  final String chapterTitle;
  final String bookName;
  final String chapterInArabic;

  HadithListPage({super.key, required this.hadiths, required this.chapterTitle, required this.bookName, required this.chapterInArabic});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          bookName,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: AppColors.primaryColor),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: hadiths.length,
        itemBuilder: (context, index) {
          final hadith = hadiths[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width/500, vertical: size.height/300),
            child: Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Padding(
                padding: EdgeInsets.all(size.width/70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Card(
                        color: AppColors.primaryColor,
                        child: Padding(
                          padding: EdgeInsets.all(size.height/100),
                          child: Column(children: [
                            Text(
                              'Hadith # ${index + 1}',
                              style: TextStyle(
                                fontSize: size.width/20,
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: size.height/200,),
                            Text(
                              '${chapterTitle}',
                              style: TextStyle(
                                  fontSize: size.width/26,
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: size.height/200,),
                            Text(
                              '${chapterInArabic}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width/20,
                                color: Colors.white,
                                fontFamily: 'Amiri',
                              ),
                            ),
                          ],),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height/90),
                    Text(
                      hadith.arabic ??
                          '',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                        height: 2,
                        fontFamily: 'Amiri',
                        color: Colors.black87,
                      ),
                    ),
                    Divider(),
                    SizedBox(height: size.height/90),
                    Text(
                      hadith.english?.narrator ?? 'No Text available',
                      style: TextStyle(fontFamily: 'Poppins', color: AppColors.primaryColor, fontWeight: FontWeight.w500),
                    ),
                    Divider(),
                    SizedBox(height: size.height/90),
                    Text(
                      hadith.english?.text ?? 'No translation available',
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                    SizedBox(height: size.height/90),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
