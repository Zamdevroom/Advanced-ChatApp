import 'package:get/get.dart';

import '../../ClassModals/QuranModal.dart';

class SurahJuzController extends GetxController {
  // Boolean to manage the toggle state
  var isSurahSelected = true.obs;

  // Function to toggle between Surah and Juz
  void toggleView(bool isSurah) {
    isSurahSelected.value = isSurah;
  }
}


class SurahSearchController extends GetxController {
  var searchQuery = ''.obs;  // Observable variable for search text
  var filteredSurahs = <Surah>[].obs;  // Observable list to store filtered surahs

  // Function to filter surahs based on search query
  void filterSurahs(List<Surah> surahs) {
    filteredSurahs.value = surahs.where((surah) {
      return surah.englishName.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          surah.name.toLowerCase().contains(searchQuery.value.toLowerCase());
    }).toList();
  }
}

