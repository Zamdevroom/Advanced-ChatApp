import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'TranslationModal.dart';

class TranslationControl extends GetxController{
  RxBool isQuran = false.obs;
  RxBool isTranslation = false.obs;
  Rx<Quran> quran = Quran().obs;
  RxList<Surahs> filteredSurahs = <Surahs>[].obs;
  RxList<Surahs> filteredTranslationSurahs = <Surahs>[].obs;
  Rx<Quran> translationQuran = Quran().obs;
  RxString language = 'English'.obs;

  void toggleQuran(){
    isQuran.value = !isQuran.value;
  }

  void toggleTranslation(){
    isTranslation.value = !isTranslation.value;
  }

  void changeLanguage(String ln){
    language.value = ln;
  }
  String getUrl(){
    return "https://zamdevroom.github.io/Quran-Api/$language.json";
  }

  void filterSurahs(String query) {
    query = query.toLowerCase();
    filteredSurahs.assignAll(quran.value.data!.surahs!); // This will work now
    filteredSurahs.assignAll(quran.value.data!.surahs!.where((surah) {
      return surah.englishName!.toLowerCase().contains(query) ||
          surah.name!.toLowerCase().contains(query) ||
          surah.revelationType!.toLowerCase().contains(query) ||
          surah.number.toString() == query;
    }).toList());
  }


  Future<void> getQuran()async{
    toggleQuran();
    print('hello i am here');
    try{
      String url = "https://zamdevroom.github.io/Quran-Api/Quran.json";
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        final quranData = json.decode(response.body);
        quran.value = Quran.fromJson(quranData);
        filteredSurahs.assignAll(quran.value.data!.surahs!); // This will work now
        print(quran.value.data!.surahs![0].ayahs![1].text);
        print('after fetching');
      }
      toggleQuran();
    }on SocketException{
      toggleQuran();
      print("No Internet Connection");
    }catch(e){
      toggleQuran();
      print('error');
      print(e.toString());
    }
  }

  Future<void> getTranslation()async{
    toggleQuran();
    toggleTranslation();
    print('hello i am here');
    try{
      final response = await http.get(Uri.parse(getUrl()));
      if(response.statusCode == 200){
        final quranData = json.decode(response.body);
        translationQuran.value = Quran.fromJson(quranData);
        print(translationQuran.value.data!.surahs![0].ayahs![1].text);
        print('after fetching');
        print('after fetching');
      }
      toggleQuran();
      toggleTranslation();
    }on SocketException{
      toggleQuran();
      toggleTranslation();
      print("No Internet Connection");
    }catch(e){
      toggleQuran();
      toggleTranslation();
      print('error');
      print(e.toString());
    }


  }



  RxString ayatTranslation = ''.obs;
  RxString ayatArabic = ''.obs;
  RxString randomAyah = ''.obs;
  var surahOfDailAyah = Rxn<Surahs>(); // Rxn allows null values
  RxInt ayatNumber = 0.obs;
  RxInt surahNo = 0.obs;

  Future<void> fetchRandomAyah() async {
    Random random = Random();
    print("Fetching Random Ayah.");

    DateTime now = DateTime.now();
    int currentDay = now.weekday;

    // Get the stored values from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? storedDay = prefs.getInt('currentDay');
    int? storedSurahNo = prefs.getInt('surahNo');
    int? storedAyatNo = prefs.getInt('ayatNo');

    // Check if the current day is the same as the stored day
    if (storedDay != null && storedDay == currentDay) {
      // If the day is the same, load the stored Surah and Ayah numbers
      print("Same day as stored, using stored Surah and Ayah.");
      surahNo.value = storedSurahNo ?? 0;
      ayatNumber.value = storedAyatNo ?? 0;

      // Fetch Quran data and use the stored values to set the Ayah
      fetchAyat(surahNo.value, ayatNumber.value);
      if (quran.value.data?.surahs?.isNotEmpty ?? false) {
        surahOfDailAyah.value = quran.value.data!.surahs![storedSurahNo!];
        List<Ayahs>? ayahs = surahOfDailAyah.value!.ayahs;

        if (ayahs != null && ayahs.isNotEmpty) {
            randomAyah.value = ayahs[storedAyatNo!].text.toString();
            randomAyah.value = randomAyah.value.replaceFirst("بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ", '').trim();
        }
      }
    } else {
      // If the day is different, generate a new random Ayah
      print("New day, generating new random Ayah.");
      print(quran.value.data?.surahs?.isNotEmpty);

      if (quran.value.data?.surahs?.isNotEmpty ?? false) {
        int randomSurahIndex = random.nextInt(quran.value.data!.surahs!.length);
        // int randomSurahIndex = 1;
        surahNo.value = randomSurahIndex;
        surahOfDailAyah.value = quran.value.data!.surahs![randomSurahIndex];
        List<Ayahs>? ayahs = surahOfDailAyah.value!.ayahs;

        if (ayahs != null && ayahs.isNotEmpty) {
          int randomAyahIndex = random.nextInt(ayahs.length);
          // int randomAyahIndex = 62;
          ayatNumber.value = randomAyahIndex;
          fetchAyat(surahNo.value, ayatNumber.value);
          randomAyah.value = ayahs[randomAyahIndex].text.toString();
          randomAyah.value = randomAyah.value.replaceFirst("بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ", '').trim();
          print(randomAyah);
          print('askldjfh');

          // Store the new values in SharedPreferences
          await prefs.setInt('currentDay', currentDay);
          await prefs.setInt('surahNo', surahNo.value);
          await prefs.setInt('ayatNo', ayatNumber.value);
        }
      }
    }
    print(ayatArabic.value);
    print(ayatTranslation.value);
    print(ayatNumber.value);
    print(surahNo.value);
    print(surahOfDailAyah.value!.name);
    print(surahOfDailAyah.value!.number);
    print(surahOfDailAyah.value!.englishName);
    print("Fetching Random Ayah complete.");
  }

  Future<void> fetchAyat(int suratNo, int ayatNo)async{
    Quran? quranApi = translationQuran.value;
    Quran? quranApi2 = quran.value;
    Surahs surah = quranApi!.data!.surahs![suratNo];
    Surahs surah2 = quranApi2!.data!.surahs![suratNo];
    ayatTranslation.value = surah!.ayahs![ayatNo].text.toString();
    ayatArabic.value = surah!.ayahs![ayatNo].text.toString();
    print(ayatArabic);
    print(ayatTranslation);
  }

}