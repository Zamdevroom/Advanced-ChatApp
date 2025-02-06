// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'TranslationControl.dart';
// import 'TranslationModal.dart';
//
// class QuranTranslationScreen extends StatelessWidget {
//   final TranslationControl controller = Get.put(TranslationControl());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Obx(() => Text("Quran - ${controller.language.value}")),
//         actions: [
//           PopupMenuButton<String>(
//             onSelected: (String value) {
//               controller.changeLanguage(value);
//               controller.getTranslation();
//             },
//             itemBuilder: (BuildContext context) {
//               return ['English', 'Urdu', 'French'].map((String choice) {
//                 return PopupMenuItem<String>(
//                   value: choice,
//                   child: Text(choice),
//                 );
//               }).toList();
//             },
//           ),
//         ],
//       ),
//       body: Obx(() {
//         if (controller.quran.value.data == null ||
//             controller.translationQuran.value.data == null) {
//           return Center(child: CircularProgressIndicator());
//         }
//         return ListView.builder(
//           itemCount: controller.quran.value.data!.surahs!.length,
//           itemBuilder: (context, surahIndex) {
//             final surah = controller.quran.value.data!.surahs![surahIndex];
//             final translatedSurah =
//             controller.translationQuran.value.data!.surahs![surahIndex];
//
//             return ExpansionTile(
//               title: Text(
//                 "${surah.name} - ${translatedSurah.name}",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               children: surah.ayahs!.asMap().entries.map((entry) {
//                 int index = entry.key;
//                 final ayah = entry.value;
//                 final translatedAyah = translatedSurah.ayahs![index];
//
//                 return ListTile(
//                   title: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         ayah.text!,
//                         textAlign: TextAlign.right,
//                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         translatedAyah.text!,
//                         textAlign: TextAlign.left,
//                         style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//                       ),
//                     ],
//                   ),
//                 );
//               }).toList(),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
