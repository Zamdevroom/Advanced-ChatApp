import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math' show pi;
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';

import '../../Utility/appColors.dart';

class Qibladirection extends StatefulWidget {
  const Qibladirection({super.key});

  @override
  State<Qibladirection> createState() => _QibladirectionState();
}

class _QibladirectionState extends State<Qibladirection> {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Qibla Direction', style: TextStyle(fontFamily: 'Poppins', color: AppColors.primaryColor, fontWeight: FontWeight.bold),),
        iconTheme: IconThemeData(
            color: AppColors.primaryColor
        ),
      ),
      body: FutureBuilder(
          future: _deviceSupport,
          builder: (_, AsyncSnapshot<bool?> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }
            else if(snapshot.hasError){
              return Center(child: Text('Error: ${snapshot.error}'));
            }else if(snapshot.hasData){
              return Qiblacompass();
            }else{
              return Text("Your device is not support the compass");
            }
          }),
    );
  }
}


class Qiblacompass extends StatefulWidget {
  const Qiblacompass({super.key});

  @override
  State<Qiblacompass> createState() => _QiblacompassState();
}

class _QiblacompassState extends State<Qiblacompass> {
  final _locationStreamController = StreamController<LocationStatus>.broadcast();

  get stream => _locationStreamController.stream;

  void checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled && locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else {
      _locationStreamController.sink.add(locationStatus);
    }
  }

  @override
  void initState() {
    checkLocationStatus();
    super.initState();
  }

  @override
  void dispose() {
    FlutterQiblah().dispose();
    _locationStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: StreamBuilder(
          stream: stream,
          builder: (_, AsyncSnapshot<LocationStatus> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.data?.enabled == true) {
              switch (snapshot.data?.status) {
                case LocationPermission.always:
                case LocationPermission.whileInUse:
                  return QiblaCompassWidget(); // Replace with your Qibla compass widget
                case LocationPermission.denied:
                case LocationPermission.deniedForever:
                  return const Center(child: Text('Location permission denied.'));
                default:
                  return const Center(child: Text('Unknown error.'));
              }
            } else {
              return const Center(child: Text('Please enable location services.'));
            }
          }),
    );
  }
}

class QiblaCompassWidget extends StatelessWidget {
  final compassSvg = SvgPicture.asset(
    'assets/svgs/compass.svg',
    fit: BoxFit.contain,
    height: 300, // Adjust height according to your layout
    alignment: Alignment.center,
  );

  final needleSvg = SvgPicture.asset(
    'assets/svgs/needle.svg',
    fit: BoxFit.contain,
    height: 200, // Adjust the height to fit inside the compass
    alignment: Alignment.center,
  );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FlutterQiblah.qiblahStream,
      builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final qiblaDirection = snapshot.data;

        if (qiblaDirection == null) {
          return const Center(child: Text("Error loading Qibla direction"));
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Transform.rotate(
                  angle: (qiblaDirection.direction * (pi / 180) * -1),
                  child: compassSvg,
                ),
                Transform.rotate(
                  angle: (qiblaDirection.qiblah * (pi / 176) * -1),
                  alignment: Alignment.center,
                  child: needleSvg,
                ),
              ],
            ),
            Text(
              'Offset: ${qiblaDirection.offset.toStringAsFixed(2)}°',
              style: TextStyle(fontSize: size.height/40, fontWeight: FontWeight.bold),
            ),

          ],
        );
      },
    );
  }
}


