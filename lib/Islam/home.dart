import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // For CupertinoPageRoute
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:prayers_times/prayers_times.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wa_business/Islam/screens/AsmaUlHusna/AsmUlHusnaScreen.dart';
import 'package:wa_business/Islam/screens/Salah/SalahTimingFetch.dart';
import 'package:wa_business/Islam/screens/Salah/displayTime.dart';
import 'package:wa_business/Islam/screens/Salah/salahView.dart';
import 'package:wa_business/Islam/screens/Supplications/supplicationView.dart';
import 'package:wa_business/Islam/screens/Tasbeeh/tasbeeh.dart';
import 'package:wa_business/Islam/screens/Tasbeeh/tasbeehMainScreen.dart';
import 'HomeScreen/HomeScreenButtons.dart';
import 'Utility/appColors.dart'; // Custom utility file
import 'Utility/ButtonOptions.dart'; // Custom button list and utility file

import 'Utility/topPart.dart';
import 'screens/QuranRead/QuranHome.dart';
import 'screens/QuranRead/juzListScreen.dart';
import 'HomeScreen/asmaUlHusna.dart';
import 'HomeScreen/qibla.dart';
import 'HomeScreen/salah.dart';
import 'HomeScreen/supplication.dart';
import 'HomeScreen/tasbeeh.dart';

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
  List<String> nowSalah = [];


  final Map<String, Widget> buttonRoutes = {
    ButtonList.texts[0]: QuranHome(),
    ButtonList.texts[1]: JuzListScreen(),
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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeSalahTimings();
    setTasbeeh();

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
      nowSalah = DisplayTiming.setSalah();
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

    return Scaffold(
      appBar: AppBar(
        title: Text('ZamStudios', style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold, fontSize: size.height/40),),
        backgroundColor: Colors.white,
      ),
      body: Container(
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
                    padding: EdgeInsets.all(size.width/40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center, // Align text to the left
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Now:',
                                  style: TextStyle(
                                    fontSize: size.height/50,
                                    color: Colors.white,
                                    // fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Maghrib',
                                  style: TextStyle(
                                    color: Colors.greenAccent,
                                    fontSize: size.height/56,
                                    // fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Next:',
                                  style: TextStyle(
                                    fontSize: size.height/50,
                                    color: Colors.white,
                                    // fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Fajr',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height/56,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: size.height/40,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hijri:',
                              style: TextStyle(
                                fontSize: size.height/50,
                                color: Colors.white,
                                // fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '01, Ramadan, 1440',
                              style: TextStyle(
                                color: Colors.white,
                                // color: Color(0xFF2E8E4D),
                                fontStyle: FontStyle.italic,
                                fontSize: size.height/60,
                                // fontSize: 18,
                                // fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ), height: 4.5,
              )
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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width / 60),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: size.width > 600 ? 4 : 4, // Adjust for larger screens
                      crossAxisSpacing: size.width/100.0,
                      mainAxisSpacing: 14.0,
                      childAspectRatio: size.width > 600 ? 0.9 : 0.80,
                    ),
                    itemCount: ButtonList.logos.length,
                    itemBuilder: (context, index) {
                      return ContentButtons(
                        image: ButtonList.logos[index],
                        text: ButtonList.texts[index],
                        onTap: () => _handleButtonPress(ButtonList.texts[index]),
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

class CustomCard extends StatelessWidget {
  final String pic;
  final Widget expand;
  final double height;
  const CustomCard({super.key, required this.pic, required this.expand, required this.height});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            Expanded(
              flex: 4, // Adjust flex as needed
              child: Image.asset('assets/images/${pic}', fit: BoxFit.contain,),
            ),
          ],
        ),
      ),
    );
  }
}
