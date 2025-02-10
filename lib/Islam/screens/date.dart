import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';


class HijriDate extends StatefulWidget {
  const HijriDate({Key? key}) : super(key: key);

  @override
  _HijriDateState createState() => _HijriDateState();
}

class _HijriDateState extends State<HijriDate> {
  RxString _hijriDate = "".obs;

  @override
  void initState() {
    super.initState();
    _convertToHijri();
  }

  void _convertToHijri() {
    final hijri = HijriCalendar.now();
      _hijriDate.value = hijri.toFormat("dd MMMM yyyy");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Hijri',
          style: TextStyle(
            fontSize: size.height/50,
            color: Colors.white,
            fontFamily: 'Poppins',
            // fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${_hijriDate.value}',
          style: TextStyle(
              color: Colors.white60,
              // color: Color(0xFF2E8E4D),
              fontSize: size.height/60,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold
            // fontSize: 18,
            // fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}


Future<void> pickDate(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );
}

