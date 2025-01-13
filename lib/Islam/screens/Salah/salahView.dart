import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Import your custom widgets and utility files
import '../../Utility/topPart.dart';
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
              height: size.height / 3.5,
              text: "${SalahTimingsFetch.cityName} Timings",
              customWidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.height/40, vertical: size.height/100),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Surah Taha (20:14)", style: TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'Amiri', fontWeight: FontWeight.bold),),
                              Text(style: TextStyle(fontSize: 10, color: Colors.white),"\"Indeed, I am Allah. There is no deity except Me, so worship Me and establish prayer for My remembrance.\""),
                            ],
                          ),
                        ),
                      ),
                  ),
                  Expanded(
                    flex: 4,
                      child: Center(
                        child: Image.asset('assets/images/salah1.png'),
                      ),
                  ),
                ],
              ),
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
                    SizedBox(height: size.height/150,),
                    Expanded(
                      child: CustomScrollView(
                        physics: const BouncingScrollPhysics(),
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
