import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Import your custom widgets and utility files
import '../../Utility/appColors.dart';
import '../../Utility/topPart.dart';
import '../../home.dart';
import 'SalahTimingFetch.dart';
import 'TimingsUi.dart';

class Salahview extends StatefulWidget {
  const Salahview({super.key});

  @override
  State<Salahview> createState() => _SalahviewState();
}

class _SalahviewState extends State<Salahview> {
  bool isNotifOn = false;

  RxString city = ''.obs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Salah Timings', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w900, color: AppColors.primaryColor)),
      ),
      body: Container(
        child: Column(
          children: [
            CustomCard(pic: 'frontLogo.png',
                expand: Padding(
                  padding: EdgeInsets.all(size.width/20),
                  child: Text('${SalahTimingsFetch.cityName}\nNamaz\nTimings',style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontWeight: FontWeight.bold, fontSize: size.width/20),),
                ), height: 5.5),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: size.height/150,),
                    Expanded(
                      child: CustomScrollView(
                        physics: const ClampingScrollPhysics(),
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return StylishCard(
                                  index: index,
                                  text: SalahTimingsFetch.timeLabels[index],
                                  time: SalahTimingsFetch.prayerTimesList[index],
                                );
                              },
                              childCount: SalahTimingsFetch.timeLabels.length,
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
