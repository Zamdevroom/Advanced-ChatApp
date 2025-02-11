import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // For CupertinoPageRoute
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prayers_times/prayers_times.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wa_business/Islam/screens/AsmaUlHusna/AsmUlHusnaScreen.dart';
import 'package:wa_business/Islam/screens/AsmaUlHusna/nameText.dart';
import 'package:wa_business/Islam/screens/Qibla/diblaDir.dart';
import 'package:wa_business/Islam/screens/Salah/SalahTimingFetch.dart';
import 'package:wa_business/Islam/screens/Salah/displayTime.dart';
import 'package:wa_business/Islam/screens/Salah/salahView.dart';
import 'package:wa_business/Islam/screens/Supplications/duaDetail.dart';
import 'package:wa_business/Islam/screens/Supplications/supplicationView.dart';
import 'package:wa_business/Islam/screens/Tasbeeh/tasbeeh.dart';
import 'package:wa_business/Islam/screens/Tasbeeh/tasbeehMainScreen.dart';
import 'package:wa_business/Islam/screens/Translation/TranslationModal.dart';
import 'package:wa_business/Islam/screens/Translation/translationController.dart';
import 'package:wa_business/Islam/screens/dailyAyat.dart';
import 'package:wa_business/Islam/screens/date.dart';
import 'Utility/HomeScreenButtons.dart';
import 'Utility/appColors.dart'; // Custom utility file
import 'Utility/ButtonOptions.dart'; // Custom button list and utility file

import 'Utility/topPart.dart';
import 'screens/QuranRead/QuranHome.dart';
import 'screens/QuranRead/juzListScreen.dart';

import 'package:location/location.dart' as loc;



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final loc.Location location = loc.Location();
  bool _serviceEnabled = false;
  loc.PermissionStatus? _permissionGranted;
  loc.LocationData? _locationData;

  late SalahTimingsFetch timeFetch = SalahTimingsFetch();

  // prayerTimesList

  late PrayerTimes prayerTimes;
  List<String> prayerList = [];
  RxList<String> nowSalah = <String>[].obs;


  final Map<String, Widget> buttonRoutes = {
    ButtonList.texts[0]: QuranHome(isQuran: true,),
    ButtonList.texts[1]: QuranHome(isQuran: false,),
    ButtonList.texts[2]: Salahview(),
    ButtonList.texts[3]: AsmaUlHusnaScreen(),
    ButtonList.texts[5]: SupplicationListView(),
    ButtonList.texts[6]: Tasbeehmainscreen(),
    ButtonList.texts[7]: Qibladirection(),
  };


  List<String> arabicPhrases = [
    'سُبْحَانَ اللَّهِ',              // Subhan Allah
    'الْحَمْدُ لِلَّهِ',             // Alhadhulillah
    'اللَّهُ أَكْبَرُ',              // Allah u Akbar
    'لَا إِلٰهَ إِلَّا اللَّهُ',     // La ilaha illallah
    'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ', // Subhan allahi wabi hamdi
    'سُبْحَانَ اللَّهِ الْعَظِيمِ',  // Subhan allahil Azeem
    'أَسْتَغْفِرُ اللَّهَ'            // Astagfirullah
  ];

  List<String> englishPhrases = [
    'Subhan Allah',              // Glory be to Allah
    'Alhamdhulillah',             // Praise be to Allah
    'Allah u Akbar',             // Allah is the Greatest
    'La ilaha illalah',          // There is no god but Allah
    'Subhan allahi wabi hamdi',  // Glory be to Allah and praise Him
    'Subhan allahil Azeem',      // Glory be to Allah, the Almighty
    'Astagfirullah'              // I seek forgiveness from Allah
  ];

  int ind1 = 1;
  int ind2 = 2;
  int ind3 = 2;
  String randomAyah = "";
  Surahs? surahOfDailAyah;
  int? ayatNumber;
  int? surahNo;
  final TranslationControl quranController = Get.put(TranslationControl());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeSalahTimings();
    fetchQuran();
    setTasbeeh();
    // fetchRandomAyah();
    final Random random = Random();
    ind1 = random.nextInt(min(Colors.primaries.length, Colors.accents.length) - 2); // Ensures valid range
    ind2 = random.nextInt(min(Colors.primaries.length, Colors.accents.length) - 2); // Ensures valid range
    ind3 = random.nextInt(NamesOfALLAH.asmaulHusna.length); // Ensures valid range

  }

  Future<void> fetchQuran()async{
    await quranController.getQuran();
    await quranController.getTranslation();
    await quranController.fetchRandomAyah();
  }



  Future<void> setTasbeeh()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('arabicPhrases', arabicPhrases);
    prefs.setStringList('englishPhrases', englishPhrases);
    // MyTasbeeh.engWords = prefs.getStringList('englishPhrases');
    MyTasbeeh.engWords = englishPhrases;
    // MyTasbeeh.arabWords = prefs.getStringList('arabicPhrases');
    MyTasbeeh.arabWords = arabicPhrases;
  }

  void _handleButtonPress(String text) {
    if (buttonRoutes.containsKey(text)) {
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => buttonRoutes[text]!),
      );
    }
  }

  Future<void> initializeSalahTimings() async {

    await _checkPermissions();
    await _listenToLocationChanges();

    await timeFetch.fetchLoc();

    if (SalahTimingsFetch.lat != null && SalahTimingsFetch.long != null) {
      SalahTimingsFetch.coordinates = Coordinates(SalahTimingsFetch.lat!, SalahTimingsFetch.long!);

      prayerTimes = PrayerTimes(
        coordinates: SalahTimingsFetch.coordinates!,
        calculationParameters: PrayerCalculationMethod.karachi(),
        precision: true,
        locationName: 'Asia/Karachi',
        dateTime: DateTime.now(),
      );

      populatePrayerTimes();
      nowSalah.value = DisplayTiming.setSalah();
      print(nowSalah.value);
    } else {
      print('Location data is missing!');
    }
  }

  Future<void> setLocation() async {
    try {
      if (_locationData != null) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          _locationData!.latitude!,
          _locationData!.longitude!,
        );
        Placemark place = placemarks[0];
        SalahTimingsFetch.cityName = place.locality ?? 'Unknown';
        print(SalahTimingsFetch.cityName);
      }
    } catch (e) {
      print('Error occurred while getting location: $e');
    }
  }

  Future<void> _checkPermissions() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) return;
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) return;
    }

    _locationData = await location.getLocation();
    await setLocation();
    setState(() {});
  }

  Future<void> _listenToLocationChanges() async {
    location.onLocationChanged.listen((loc.LocationData currentLocation) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setDouble('lat', currentLocation.latitude!.toDouble());
      prefs.setDouble('long', currentLocation.longitude!.toDouble());

      await timeFetch.fetchLoc();

      setState(() {
        _locationData = currentLocation;
      });
      await setLocation();
    });
  }

  void populatePrayerTimes() {
    setState(() {
      prayerList = [
        prayerTimes.fajrStartTime!.toString().substring(11, 19),
        prayerTimes.fajrEndTime!.toString().substring(11, 19),
        prayerTimes.sunrise!.toString().substring(11, 19),
        prayerTimes.dhuhrStartTime!.toString().substring(11, 19),
        prayerTimes.dhuhrEndTime!.toString().substring(11, 19),
        prayerTimes.asrStartTime!.toString().substring(11, 19),
        prayerTimes.asrEndTime!.toString().substring(11, 19),
        prayerTimes.maghribStartTime!.toString().substring(11, 19),
        prayerTimes.maghribEndTime!.toString().substring(11, 19),
        prayerTimes.ishaStartTime!.toString().substring(11, 19),
        prayerTimes.ishaEndTime!.toString().substring(11, 19),
      ];
    });
    SalahTimingsFetch.prayerTimesList = prayerList;
    for(int i = 0; i < SalahTimingsFetch.prayerTimesList.length; i++){
      print(SalahTimingsFetch.prayerTimesList[i]);
    }
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // final Random random = Random();
    // int ind1 = random.nextInt(min(Colors.primaries.length, Colors.accents.length) - 2); // Ensures valid range
    // int ind2 = random.nextInt(min(Colors.primaries.length, Colors.accents.length) - 2); // Ensures valid range

    return Scaffold(
      appBar: AppBar(
        title: Text('KM Chat Now', style: TextStyle(fontFamily: 'Poppins', color: AppColors.primaryColor, fontWeight: FontWeight.bold, fontSize: size.height/40),),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: AppColors.primaryColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: size.width / 70,
                  right: size.width / 70,
                  bottom: size.width / 70,
                ),
                child: CustomCard(pic: 'frontLogo.png',
                    expand: Padding(
                      padding: EdgeInsets.all(size.width/100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center, // Align text to the left
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withAlpha(25),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(size.width/200),
                                      child: Obx((){
                                        return nowSalah.value.isEmpty?
                                        Center(
                                          child: SizedBox(
                                            width: size.width/18, // Adjust size
                                            height: size.width/18, // Adjust size
                                            child: CircularProgressIndicator(
                                              strokeWidth: 1,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ):
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Now',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: size.height/50,
                                                color: Colors.white,
                                                // fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '${nowSalah[0]}',
                                              // '',
                                              style: TextStyle(
                                                color: Colors.greenAccent,
                                                fontFamily: 'Poppins',
                                                fontSize: size.height/56,
                                                // fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        );
                                      })
                                    ),
                                  ),
                                ),
                                SizedBox(width: size.width/80,),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withAlpha(25),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Obx((){
                                      return nowSalah.value.isEmpty?
                                      Center(
                                        child: SizedBox(
                                          width: size.width/18, // Adjust size
                                          height: size.width/18, // Adjust size
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                          :
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Next',
                                            style: TextStyle(
                                              fontSize: size.height/50,
                                              color: Colors.white,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${nowSalah[1]}',
                                            // '',
                                            style: TextStyle(
                                              color: Colors.white60,
                                              fontFamily: 'Poppins',
                                              fontSize: size.height/56,
                                              // fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: size.height/200,),
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(25),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: HijriDate(),
                            ),
                          ),
                        ],
                      ),
                    ), height: 4.5, isHome: true,
                )
              ),
              Container(
                height: size.height/3.4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size.height / 30),
                    topRight: Radius.circular(size.height / 30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width / 60),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: size.width > 600 ? 4 : 4, // Adjust for larger screens
                      crossAxisSpacing: size.width/100.0,
                      mainAxisSpacing: 14.0,
                      childAspectRatio: size.width > 600 ? 0.9 : 0.80,
                    ),
                    itemCount: ButtonList.logos.length,
                    itemBuilder: (context, index){
                      return ContentButtons(
                        image: ButtonList.logos[index],
                        text: ButtonList.texts[index],
                        onTap: ()async{
                          if(index == 4){
                            await pickDate(context);
                          }else{
                            _handleButtonPress(ButtonList.texts[index]);
                          }
                        }
                      );
                    },
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Ayat of the day:', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'), textAlign: TextAlign.start,),
                          ),
                          Card(
                            elevation: 4, // Adds a shadow effect
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Same rounded corners
                            ),
                            child: Container(
                              height: size.height / 4.5,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                // gradient: LinearGradient(
                                //   colors: [Colors.primaries[9], Colors.accents[11]],
                                // ),
                                borderRadius: BorderRadius.circular(10), // Ensures smooth edges
                              ),
                              child: Obx(() {
                                if (quranController.ayatArabic.value.isEmpty || quranController.ayatArabic.value == null || quranController.ayatNumber.value == null) {
                                  return Center(child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(strokeWidth: 1, color: Colors.black,)),
                                      Text("Loading Ayah", style: TextStyle(fontFamily: 'Poppins', fontSize: size.width/30),),
                                    ],
                                  ));
                                }

                                return InkWell(
                                  onTap: (){
                                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>ayatTag()));
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: size.height / 100),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Reference:',
                                              style: TextStyle(fontSize: size.height / 80),
                                            ),
                                            SizedBox(width: size.width / 50),
                                            Text(
                                              '${quranController.surahOfDailAyah.value!.englishName} ${quranController.surahOfDailAyah.value!.number}:${quranController.ayatNumber.value + 1}',
                                              style: TextStyle(fontSize: size.height / 80),
                                            ),
                                            SizedBox(width: size.width / 100),
                                            Text(
                                              '(${quranController.surahOfDailAyah.value!.name})',
                                              style: TextStyle(fontSize: size.height / 80),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(color: Colors.black),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: size.height / 50),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                quranController.randomAyah.value,
                                                textAlign: TextAlign.end,
                                                maxLines: 1,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                  fontFamily: 'Amiri',
                                                  fontSize: size.height / 30,
                                                  height: size.height / 490,
                                                ),
                                              ),
                                              Text(
                                                quranController.ayatTranslation.value,
                                                textAlign: TextAlign.end,
                                                maxLines: 1,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: size.height / 50,
                                                  height: size.height / 490,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height/100,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Allah name of the day: ', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'), textAlign: TextAlign.start,),
                          ),
                          InkWell(
                            onTap: (){
                              print(ind2.toString());
                              print(ind2 - 2);
                            },
                            child: Card(
                              elevation: 4, // Adds a shadow effect
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // Same rounded corners
                              ),
                              child: Container(
                                height: size.height / 4.5,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.primaries[4], Colors.accents[7]],
                                    begin:Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    // colors: [Colors.primaries[ind2], Colors.accents[ind2 + 2]],
                                  ),
                                  borderRadius: BorderRadius.circular(10), // Ensures smooth edges
                                ),
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
                                              Text('${NamesOfALLAH.asmaulHusna[ind3]['name']}', textAlign: TextAlign.center,style: TextStyle(color:Colors.white,fontSize: size.height/42,fontFamily: 'Amiri', fontWeight: FontWeight.bold),),
                                              SizedBox(height: size.height/100,),
                                              Text('${NamesOfALLAH.asmaulHusna[ind3]['meaning']}', textAlign: TextAlign.center,style: TextStyle(color:Colors.white,fontSize: size.height/62, fontFamily: 'Poppins')),
                                              SizedBox(height: size.height/100,),
                                              Text('${NamesOfALLAH.asmaulHusna[ind3]['urdu']}', textAlign: TextAlign.center,style: TextStyle(color:Colors.white,fontFamily: 'Amiri', fontSize: size.height/52,),),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(size.height/52),
                                        child: Container(width: 1, height: double.maxFinite, color: Colors.white,),
                                      ),
                                      Expanded(
                                          child: Center(
                                            child: Text('${NamesOfALLAH.asmaulHusna[ind3]['arabic']}', textAlign: TextAlign.center,style: TextStyle(color:Colors.white,fontFamily: 'Amiri', fontSize: size.height/22),),
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Expanded(child: Container(color: Colors.blue,))
            ],
          ),
        ),
      ),
    );
  }

}

class CustomCard extends StatelessWidget {
  final String pic;
  final Widget expand;
  final double height;
  bool? isHome;
  CustomCard({super.key, required this.pic, required this.expand, required this.height, this.isHome});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime now = DateTime.now();
    String monthName = DateFormat('MMMM').format(now);
    return Card(
      elevation: 3,
      child: Container(
        height: size.height / height,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Side: Salah Timings
            Expanded(
                flex: 5,
                child: expand),
            // Right Side: SVG Mosque
            isHome != null?
            Expanded(
              flex: 3, // Adjust flex as needed
              child: Padding(
                padding: EdgeInsets.only(top:size.width/100, bottom: size.width/100, right: size.width/100, left: size.width/400),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(25),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${now.day}', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', fontSize: size.height/12, color: Colors.white),),
                        Text('${monthName}', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', fontSize: size.height/60, color: Colors.white70,),),
                        Text('${now.year}', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', fontSize: size.height/40, color: Colors.white70),),
                    ],)
                ),
              ),
            ):
            Expanded(
              flex: 4, // Adjust flex as needed
              child: Image.asset('assets/images/${pic}', fit: BoxFit.contain,),
            )
          ],
        ),
      ),
    );
  }
}
