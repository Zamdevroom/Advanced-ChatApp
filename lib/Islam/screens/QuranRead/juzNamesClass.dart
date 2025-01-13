// class JuzNames {
//   // List of Arabic names for each Juz
//   static const List<String> names = [
//     'الم', // Juz 1: Alif Lam Mim
//     'سيقول السفهاء', // Juz 2
//     'تلك الرسل', // Juz 3
//     'لن تنالوا البر', // Juz 4
//     'والمحصنات', // Juz 5
//     'لا يحب الله', // Juz 6
//     'وإذا سمعوا', // Juz 7
//     'ولو أننا', // Juz 8
//     'قد أفلح', // Juz 9
//     'واعلموا', // Juz 10
//     'يعتذرون', // Juz 11
//     'وما من دابة', // Juz 12
//     'وما أبريء', // Juz 13
//     'ربما يود', // Juz 14
//     'سبحان الذي أسرى', // Juz 15
//     'قال ألم', // Juz 16
//     'اقتربت الساعة', // Juz 17
//     'قد أفلح المؤمنون', // Juz 18
//     'وقال الذين', // Juz 19
//     'أمن خلق', // Juz 20
//     'أتل ما أوحي', // Juz 21
//     'ومن يقنت', // Juz 22
//     'وما أنزلنا', // Juz 23
//     'فمن أظلم', // Juz 24
//     'إليه يرد', // Juz 25
//     'حم', // Juz 26
//     'قال فما خطبكم', // Juz 27
//     'قد سمع الله', // Juz 28
//     'تبارك الذي', // Juz 29
//     'عم يتساءلون', // Juz 30
//   ];
//
//   // List of English names for each Juz
//   static const List<String> englishNames = [
//     'Alif Lam Mim', // Juz 1
//     'Sayuqalu As-Sufahaa', // Juz 2
//     'Tilka Ar-Rusul', // Juz 3
//     'Lan Tanaalu Al-Birr', // Juz 4
//     'Wal-Muhsanat', // Juz 5
//     'La Yuhibbu Allah', // Juz 6
//     'Wa-Iza Samiuu', // Juz 7
//     'Walaw Annana', // Juz 8
//     'Qad Aflaha', // Juz 9
//     'Wa\'lamuu', // Juz 10
//     'Ya\'tadhiruun', // Juz 11
//     'Wa Ma Min Daabah', // Juz 12
//     'Wa Ma Abri', // Juz 13
//     'Rubbama Yuddu', // Juz 14
//     'Subhana Alladhi Asra', // Juz 15
//     'Qala Alam', // Juz 16
//     'Iqtarabat As-Sa\'ah', // Juz 17
//     'Qad Aflaha Al-Mu\'minun', // Juz 18
//     'Wa Qala Al-Ladhina', // Juz 19
//     'Aman Khalaq', // Juz 20
//     'Atlu Ma Uhiy', // Juz 21
//     'Wa Man Yaqnt', // Juz 22
//     'Wa Ma Anzalna', // Juz 23
//     'Faman Azlam', // Juz 24
//     'Ilayhi Yurd', // Juz 25
//     'Ha-Mim', // Juz 26
//     'Qalafama Khatbukum', // Juz 27
//     'Qad Sami\'Allah', // Juz 28
//     'Tabarakalladhi', // Juz 29
//     'Amma Yatasa\'alun', // Juz 30
//   ];
//
//   // List of total number of Ayat in each Juz (corrected for Juz 1)
//   static const List<int> totalAyat = [
//     148, // Juz 1 (corrected)
//     111, // Juz 2
//     126, // Juz 3
//     131, // Juz 4
//     124, // Juz 5
//     110, // Juz 6
//     149, // Juz 7
//     142, // Juz 8
//     159, // Juz 9
//     127, // Juz 10
//     151, // Juz 11
//     170, // Juz 12
//     154, // Juz 13
//     227, // Juz 14
//     185, // Juz 15
//     269, // Juz 16
//     190, // Juz 17
//     202, // Juz 18
//     339, // Juz 19
//     171, // Juz 20
//     178, // Juz 21
//     169, // Juz 22
//     357, // Juz 23
//     175, // Juz 24
//     246, // Juz 25
//     195, // Juz 26
//     399, // Juz 27
//     137, // Juz 28
//     431, // Juz 29
//     564,  // Juz 30
//   ];
// }

class JuzNames {
  // Combined data for all Juz with Arabic diacritics
  static const List<Map<String, dynamic>> juzList = [
    {'juzNumber': 1, 'nameArabic': 'ٱلم', 'nameEnglish': 'Alif Lam Mim', 'totalAyat': 148},
    {'juzNumber': 2, 'nameArabic': 'سَيَقُولُ ٱلسُّفَهَآءُ', 'nameEnglish': 'Sayuqalu As-Sufahaa', 'totalAyat': 111},
    {'juzNumber': 3, 'nameArabic': 'تِلْكَ ٱلرُّسُلُ', 'nameEnglish': 'Tilka Ar-Rusul', 'totalAyat': 126},
    {'juzNumber': 4, 'nameArabic': 'لَن تَنَالُوا۟ ٱلْبِرَّ', 'nameEnglish': 'Lan Tanaalu Al-Birr', 'totalAyat': 131},
    {'juzNumber': 5, 'nameArabic': 'وَٱلْمُحْصَنَٰتُ', 'nameEnglish': 'Wal-Muhsanat', 'totalAyat': 124},
    {'juzNumber': 6, 'nameArabic': 'لَا يُحِبُّ ٱللَّهُ', 'nameEnglish': 'La Yuhibbu Allah', 'totalAyat': 110},
    {'juzNumber': 7, 'nameArabic': 'وَإِذَا سَمِعُوا۟', 'nameEnglish': 'Wa-Iza Samiuu', 'totalAyat': 149},
    {'juzNumber': 8, 'nameArabic': 'وَلَوْ أَنَّنَآ', 'nameEnglish': 'Walaw Annana', 'totalAyat': 142},
    {'juzNumber': 9, 'nameArabic': 'قَدْ أَفْلَحَ', 'nameEnglish': 'Qad Aflaha', 'totalAyat': 159},
    {'juzNumber': 10, 'nameArabic': 'وَٱعْلَمُوٓا۟', 'nameEnglish': 'Wa\'lamuu', 'totalAyat': 127},
    {'juzNumber': 11, 'nameArabic': 'يَعْتَذِرُونَ', 'nameEnglish': 'Ya\'tadhiruun', 'totalAyat': 151},
    {'juzNumber': 12, 'nameArabic': 'وَمَا مِن دَآبَّةٍ', 'nameEnglish': 'Wa Ma Min Daabah', 'totalAyat': 170},
    {'juzNumber': 13, 'nameArabic': 'وَمَآ أُبَرِّئُ', 'nameEnglish': 'Wa Ma Abri', 'totalAyat': 154},
    {'juzNumber': 14, 'nameArabic': 'رُّبَمَا يَوَدُّ', 'nameEnglish': 'Rubbama Yuddu', 'totalAyat': 227},
    {'juzNumber': 15, 'nameArabic': 'سُبْحَٰنَ ٱلَّذِىٓ أَسْرَىٰ', 'nameEnglish': 'Subhana Alladhi Asra', 'totalAyat': 185},
    {'juzNumber': 16, 'nameArabic': 'قَالَ أَلَمْ', 'nameEnglish': 'Qala Alam', 'totalAyat': 269},
    {'juzNumber': 17, 'nameArabic': 'ٱقْتَرَبَتِ ٱلسَّاعَةُ', 'nameEnglish': 'Iqtarabat As-Sa\'ah', 'totalAyat': 190},
    {'juzNumber': 18, 'nameArabic': 'قَدْ أَفْلَحَ ٱلْمُؤْمِنُونَ', 'nameEnglish': 'Qad Aflaha Al-Mu\'minun', 'totalAyat': 202},
    {'juzNumber': 19, 'nameArabic': 'وَقَالَ ٱلَّذِينَ', 'nameEnglish': 'Wa Qala Al-Ladhina', 'totalAyat': 339},
    {'juzNumber': 20, 'nameArabic': 'ءَامَنْ خَلَقَ', 'nameEnglish': 'Aman Khalaq', 'totalAyat': 171},
    {'juzNumber': 21, 'nameArabic': 'ٱتْلُ مَآ أُو۟حِىَ', 'nameEnglish': 'Atlu Ma Uhiy', 'totalAyat': 178},
    {'juzNumber': 22, 'nameArabic': 'وَمَن يَقْنُتْ', 'nameEnglish': 'Wa Man Yaqnt', 'totalAyat': 169},
    {'juzNumber': 23, 'nameArabic': 'وَمَآ أَنزَلْنَا', 'nameEnglish': 'Wa Ma Anzalna', 'totalAyat': 357},
    {'juzNumber': 24, 'nameArabic': 'فَمَنْ أَظْلَمُ', 'nameEnglish': 'Faman Azlam', 'totalAyat': 175},
    {'juzNumber': 25, 'nameArabic': 'إِلَيْهِ يُرَدُّ', 'nameEnglish': 'Ilayhi Yurd', 'totalAyat': 246},
    {'juzNumber': 26, 'nameArabic': 'حٓمٓ', 'nameEnglish': 'Ha-Mim', 'totalAyat': 195},
    {'juzNumber': 27, 'nameArabic': 'قَالَ فَمَا خَطْبُكُمْ', 'nameEnglish': 'Qalafama Khatbukum', 'totalAyat': 399},
    {'juzNumber': 28, 'nameArabic': 'قَدْ سَمِعَ ٱللَّهُ', 'nameEnglish': 'Qad Sami\'Allah', 'totalAyat': 137},
    {'juzNumber': 29, 'nameArabic': 'تَبَارَكَ ٱلَّذِى', 'nameEnglish': 'Tabarakalladhi', 'totalAyat': 431},
    {'juzNumber': 30, 'nameArabic': 'عَمَّ يَتَسَآءَلُونَ', 'nameEnglish': 'Amma Yatasa\'alun', 'totalAyat': 564},
  ];
}
