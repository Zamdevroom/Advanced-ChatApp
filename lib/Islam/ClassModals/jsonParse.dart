import 'dart:convert';
import 'package:flutter/services.dart';

Future<Map<String, dynamic>> loadQuranData() async {
  // Load the JSON file
  final String response = await rootBundle.loadString('assets/jsons/quran-uthmani.json');
  // Decode the JSON data
  return json.decode(response);
}
