import 'package:intl/intl.dart';

import 'SalahTimingFetch.dart';

class DisplayTiming {
  static List<String> setSalah() {
    // DateTime now = DateTime.parse("2024-09-21 14:30:00");
    DateTime now = DateTime.now();
    String dayName = DateFormat('EEEE').format(now); // Full day name (e.g., "Monday")
    String todayDate = now.toString().substring(0, 10); // Get today's date in 'yyyy-MM-dd' format

    DateTime sunrise = DateTime.parse('$todayDate ${SalahTimingsFetch.prayerTimesList[2]}');
    DateTime dhuhrStart = DateTime.parse('$todayDate ${SalahTimingsFetch.prayerTimesList[3]}');

    // Check if current time is between sunrise and dhuhr start time
    if (now.isAfter(sunrise) && now.isBefore(dhuhrStart)) {
      print('No obligatory salah is expected');
      return ['No obligatory salah is expected', 'Dhuhr'];
    }

    // Assuming SalahTimingsFetch.prayerTimesList contains time strings like '05:04:14'
    DateTime fajrStart = DateTime.parse('$todayDate ${SalahTimingsFetch.prayerTimesList[0]}');
    DateTime fajrEnd = DateTime.parse('$todayDate ${SalahTimingsFetch.prayerTimesList[1]}');
    DateTime dhuhrEnd = DateTime.parse('$todayDate ${SalahTimingsFetch.prayerTimesList[4]}');
    DateTime asrStart = DateTime.parse('$todayDate ${SalahTimingsFetch.prayerTimesList[5]}');
    DateTime asrEnd = DateTime.parse('$todayDate ${SalahTimingsFetch.prayerTimesList[6]}');
    DateTime maghribStart = DateTime.parse('$todayDate ${SalahTimingsFetch.prayerTimesList[7]}');
    DateTime maghribEnd = DateTime.parse('$todayDate ${SalahTimingsFetch.prayerTimesList[8]}');
    DateTime ishaStart = DateTime.parse('$todayDate ${SalahTimingsFetch.prayerTimesList[9]}');
    DateTime ishaEnd = DateTime.parse('$todayDate ${SalahTimingsFetch.prayerTimesList[10]}');

    // Compare the current time with prayer times
    if (now.isAfter(dhuhrStart) && now.isBefore(dhuhrEnd)) {
      if(dayName == "Friday"){
        return ['Jumma', 'Asr'];
      }
      print(dayName);
      print("DHUR");
      return ['Dhuhr', 'Asr'];
    } else if (now.isAfter(asrStart) && now.isBefore(asrEnd)) {
      print("ASR");
      return ['Asr', 'Maghrib'];
    } else if (now.isAfter(maghribStart) && now.isBefore(maghribEnd)) {
      print("MAGHRIB");
      return ['Maghrib', 'Isha'];
    } else if (now.isAfter(ishaStart) || now.isBefore(ishaEnd)) {
      print("ISHA");
      return ['Isha', 'Fajr'];
    } else if (now.isAfter(fajrStart) && now.isBefore(fajrEnd)) {
      print("FAJR");
      return ['Fajr', 'Dhuhr'];
    } else {
      print("No Salah Currently");
      return ['No Salah currently', 'Next Salah']; // Default case
    }
  }
}
