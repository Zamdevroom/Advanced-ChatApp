// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:wa_business/Islam/Utility/appColors.dart';
//
// import '../../ClassModals/QuranModal.dart';
// import '../../ClassModals/jsonParse.dart';
// import '../../Utility/surahListTile.dart';
// import '../Translation/SurahScreen.dart';
// import '../Translation/TranslationModal.dart';
// import '../Translation/translationController.dart';
// import 'SurahDetail.dart';
//
// class SurahListView extends StatefulWidget {
//   bool isQuran;
//   SurahListView({super.key, required this.isQuran});
//
//   @override
//   State<SurahListView> createState() => _SurahListView();
// }
//
// class _SurahListView extends State<SurahListView> {
//   late List<Surahs> surahsFuture;
//   List<Surahs> allSurahs = [];
//   List<Surahs> filteredSurahs = [];
//   TextEditingController searchController = TextEditingController();
//   TranslationControl qCont = Get.put(TranslationControl());
//
//   @override
//   void initState() {
//     super.initState();
//     surahsFuture = qCont.quran.value.data!.surahs!;
//     allSurahs = qCont.quran.value.data!.surahs!;
//     filteredSurahs = qCont.quran.value.data!.surahs!;
//   }
//
//   Future<List<Surah>> fetchSurahs() async {
//     final data = await loadQuranData();
//     final surahs = (data['data']['surahs'] as List)
//         .map((surah) => Surah.fromJson(surah))
//         .toList();
//     return surahs;
//   }
//
//   void filterSurahs(String query) {
//     query = query.toLowerCase();
//     setState(() {
//       filteredSurahs = allSurahs.where((surah) {
//         return surah.englishName!.toLowerCase().contains(query) ||
//             surah.name!.toLowerCase().contains(query) ||
//             surah.revelationType!.toLowerCase().contains(query) ||
//             surah.number.toString() == query;
//       }).toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final myHeight = size.height;
//     final myWidth = size.width;
//
//     return Column(
//       children: [
//         Container(
//           height: 60,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//             child: TextFormField(
//               controller: searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search Surah',
//                 hintStyle: TextStyle(color: Colors.grey),
//                 prefixIcon: Icon(Icons.search, color: Colors.grey),
//                 filled: true,
//                 fillColor: Colors.grey[200], // Light gray color
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(50.0),
//                   borderSide: BorderSide.none, // No visible border
//                 ),
//                 contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0), // Reduced vertical padding
//               ),
//               style: TextStyle(fontSize: 12.0),
//               onChanged: (query) => filterSurahs(query),
//             ),
//           ),
//         ),
//
//         Expanded(
//           child: Obx((){
//             return FutureBuilder<List<Surahs>>(
//               future: Future.value(surahsFuture),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error loading Quran'));
//                 } else if (snapshot.hasData) {
//                   return CustomScrollView(
//                     physics: BouncingScrollPhysics(),
//                     slivers: [
//                       SliverList(
//                         delegate: SliverChildBuilderDelegate(
//                               (context, index) {
//                             final surah = filteredSurahs[index];
//                             return ListUi(
//                               index: (surah.number).toString(),
//                               surahName: surah.englishName!,
//                               engName: surah.englishNameTranslation!,
//                               arabic: surah.name!,
//                               reveal: surah.revelationType!,
//                               onPressed: () {
//                                 if(widget.isQuran){
//                                   // Navigator.push(
//                                   //   context,
//                                   //   CupertinoPageRoute(
//                                   //     builder: (context) => SurahView(selectedSurah: surah!),
//                                   //   ),
//                                   // );
//                                 }else{
//                                   // Navigator.push(
//                                   //   context,
//                                   //   CupertinoPageRoute(
//                                   //     builder: (context) => TranslationSurahView(selectedSurah: surah),
//                                   //   ),
//                                   // );
//                                 }
//
//                               },
//                             );
//                           },
//                           childCount: filteredSurahs.length, // Ensure child count matches the filtered list size
//                         ),
//                       ),
//                     ],
//                   );
//                 } else {
//                   return Center(child: Text('No data found'));
//                 }
//               },
//             );
//           }),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Utility/appColors.dart';
import '../../ClassModals/QuranModal.dart';
import '../Translation/SurahScreen.dart';
import '../Translation/TranslationModal.dart';
import '../Translation/translationController.dart';
import '../../Utility/surahListTile.dart';
import 'SurahDetail.dart';

class SurahListView extends StatefulWidget {
  final bool isQuran;
  SurahListView({super.key, required this.isQuran});

  @override
  State<SurahListView> createState() => _SurahListView();
}

class _SurahListView extends State<SurahListView> {
  final TranslationControl qCont = Get.put(TranslationControl());
  final TextEditingController searchController = TextEditingController();
  var filteredSurahs = <Surahs>[].obs;

  @override
  void initState() {
    super.initState();
    // qCont.getQuran(); // Fetch Quran data on screen load
    // ever(qCont.quran, (_) => updateFilteredSurahs());
  }

  // void updateFilteredSurahs() {
  //   if (qCont.quran.value.data != null) {
  //     filteredSurahs.assignAll(qCont.quran.value.data!.surahs!);
  //   }
  // }
  //
  // void filterSurahs(String query) {
  //   query = query.toLowerCase();
  //   filteredSurahs.assignAll(qCont.quran.value.data!.surahs!.where((surah) {
  //     return surah.englishName!.toLowerCase().contains(query) ||
  //         surah.name!.toLowerCase().contains(query) ||
  //         surah.revelationType!.toLowerCase().contains(query) ||
  //         surah.number.toString() == query;
  //   }).toList());
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search Surah',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[200], // Light gray color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide.none, // No visible border
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 5.0), // Reduced vertical padding
              ),
              style: TextStyle(fontSize: 12.0),
              onChanged: (query){
                qCont.filterSurahs(query);
              },
            ),
          ),
        ),

        // Surah List
        Expanded(
          child: Obx(() {
            if (qCont.isQuran.value || qCont.isTranslation.value) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            }

            if (qCont.filteredSurahs.isEmpty) {
              return Center(child: Text('No Surah found'));
            }

            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: qCont.filteredSurahs.length,
              itemBuilder: (context, index) {
                final surah = qCont.filteredSurahs[index];
                Surahs? translationSurah ;
                if(!widget.isQuran){
                  qCont.filteredTranslationSurahs.assignAll(qCont.translationQuran.value.data!.surahs!); // This will work now
                  translationSurah = qCont.filteredTranslationSurahs[index];
                  print(qCont.filteredTranslationSurahs[1].name);
                }
                return ListUi(
                  index: surah.number.toString(),
                  surahName: surah.englishName!,
                  engName: surah.englishNameTranslation!,
                  arabic: surah.name!,
                  reveal: surah.revelationType!,
                  onPressed: () {
                    // Navigation logic for Surah details
                    if (widget.isQuran) {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) =>
                              SurahView(selectedSurah: surah!),
                        ),
                      );
                    } else {
                      print('askljdfh');
                      print(surah.name);
                      print('askljdfh');
                      print(translationSurah!.name);
                      print('askljdfh');
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) =>
                              TranslationSurahView(selectedSurah: surah, translationSurah: translationSurah!,),
                        ),
                      );
                    }
                  },
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
