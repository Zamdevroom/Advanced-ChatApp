import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wa_business/Islam/screens/Hadith/hadithModal.dart';
class HadithController extends GetxController{
  Rx<Hadith> hadith = Hadith().obs;
  RxBool isLoading = false.obs;
  static final List<Map<String, String>> hadithBooks = [
    {
      'arabicName': 'صحيح البخاري',
      'englishName': 'Sahih al-Bukhari',
      'apiName': 'bukhari',
    },
    {
      'arabicName': 'صحيح مسلم',
      'englishName': 'Sahih Muslim',
      'apiName': 'muslim',
    },
    {
      'arabicName': 'سنن أبي داود',
      'englishName': 'Sunan Abi Dawood',
      'apiName': 'abudawud',
    },
    {
      'arabicName': 'مسند أحمد',
      'englishName': 'Musnad Ahmad',
      'apiName': 'ahmed',
    },
    {
      'arabicName': 'سنن الدارمي',
      'englishName': 'Sunan al-Darimi',
      'apiName': 'darimi',
    },
    {
      'arabicName': 'سنن ابن ماجه',
      'englishName': 'Sunan Ibn Majah',
      'apiName': 'ibnmajah',
    },
    {
      'arabicName': 'سنن النسائي',
      'englishName': 'Sunan an-Nasa\'i',
      'apiName': 'nasai',
    },
    {
      'arabicName': 'جامع الترمذي',
      'englishName': 'Jami\' at-Tirmidhi',
      'apiName': 'tirmidhi',
    },
  ];

  void toggleLoad(){
    isLoading.value = !isLoading.value;
  }


  List<HadithDetail> getHadithsByChapter(int chapterId, Hadith hadithCollection) {
    return hadithCollection.hadiths
        ?.where((hadith) => hadith.chapterId == chapterId)
        .toList() ?? [];
  }

  Future<void> fetchHadith(String hadithBook) async {
    toggleLoad();
    String url = "https://zamdevroom.github.io/Hadith-Api/$hadithBook.json";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final hadithData = json.decode(response.body);
        hadith.value = Hadith.fromJson(hadithData);
        print("Fetch it");
        print(hadith.value.chapters![0].english);
      } else {
        print("Failed to load Hadith. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching Hadith: $e");
    }finally{
      toggleLoad();
    }
  }
}