import 'package:prayers_times/prayers_times.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalahTimingsFetch {
  static String cityName = 'Karachi';
  static double? lat;
  static double? long;
  static Coordinates? coordinates;  // Make coordinates nullable initially
  static List<String> prayerTimesList = [];
  static List<String> timeLabels = [
    'Fajr Start Time',
    'Fajr End Time',
    'Sunrise Time',
    'Dhuhr Start Time',
    'Dhuhr End Time',
    'Asr Start Time',
    'Asr End Time',
    'Maghrib Start Time',
    'Maghrib End Time',
    'Isha Start Time',
    'Isha End Time'
  ];

  Future<void> fetchLoc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Safely fetch lat and long values from SharedPreferences
    lat = prefs.getDouble('lat');
    long = prefs.getDouble('long');

    // Check if lat and long are not null before creating Coordinates
    if (lat != null && long != null) {
      coordinates = Coordinates(lat!, long!);  // Assign coordinates after lat and long are assigned
    } else {
      print('Location data is missing!');
    }
  }
}
