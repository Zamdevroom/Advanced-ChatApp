import 'package:flutter/material.dart';
import 'package:wa_business/Islam/Utility/topPart.dart';
import 'package:wa_business/Islam/screens/AsmaUlHusna/nameText.dart';

import '../../Utility/appColors.dart';

class AsmaUlHusnaScreen extends StatelessWidget {

  const AsmaUlHusnaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Asma-ul-Husna', style: TextStyle(fontFamily: 'Poppins', color: AppColors.primaryColor, fontWeight: FontWeight.bold),),
        iconTheme: IconThemeData(
            color: AppColors.primaryColor
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListWheelScrollView(
                  diameterRatio: 3,
                  itemExtent: 240,
                  physics: FixedExtentScrollPhysics(),
                  children: List.generate(
                    99,
                        (index) {
                      return Card(
                        child: Center(
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(size.width/80),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('${NamesOfALLAH.asmaulHusna[index]['name']}', textAlign: TextAlign.center,style: TextStyle(fontSize: size.height/40,fontFamily: 'Amiri', fontWeight: FontWeight.bold),),
                                      SizedBox(height: size.height/100,),
                                      Text('${NamesOfALLAH.asmaulHusna[index]['meaning']}', textAlign: TextAlign.center,style: TextStyle(fontSize: size.height/60)),
                                      SizedBox(height: size.height/100,),
                                      Text('${NamesOfALLAH.asmaulHusna[index]['urdu']}', textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Amiri', fontSize: size.height/50, color: AppColors.primaryColor),),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(size.height/50),
                                child: Container(width: 1, height: double.maxFinite, color: Colors.black,),
                              ),
                              Expanded(
                                  child: Center(
                                      child: Text('${NamesOfALLAH.asmaulHusna[index]['arabic']}', textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Amiri', fontSize: size.height/20, color: AppColors.primaryColor),),
                                  )
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
