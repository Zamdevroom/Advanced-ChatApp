//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../ClassModals/QuranModal.dart';
//
// class Surahview extends StatefulWidget {
//   final Surah selectedSurah;
//   Surahview({super.key, required this.selectedSurah});
//
//   @override
//   State<Surahview> createState() => _SurahviewState();
// }
//
// class _SurahviewState extends State<Surahview> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     // Check if the first ayah contains "Bismillah"
//     bool isFirstAyahBismillah = widget.selectedSurah.ayahs!.isNotEmpty &&
//         widget.selectedSurah.ayahs![0].text!.contains("بِسْمِ ٱللَّهِ");
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Card(
//               color: Color(0xFF89DAD6),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(size.height / 90),
//                     child: Column(
//                       children: [
//                         Text(
//                           "${widget.selectedSurah.name}",
//                           style: TextStyle(
//                               fontSize: size.width / 18, fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           "${widget.selectedSurah.englishNameTranslation} (${widget.selectedSurah.revelationType})",
//                           style: TextStyle(fontSize: size.width / 30),
//                         ),
//                         Divider(),
//                       ],
//                     ),
//                   ),
//                   widget.selectedSurah.number == 9?
//
//                   Divider(color: Colors.transparent,)
//                       :Padding(
//                     padding: EdgeInsets.all(size.width/30),
//                     child: Center(
//                       child: Text(
//                         "",
//                         // "${Bismillah.bismillah}",
//                         style: TextStyle(
//                           fontSize: size.width / 12,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Generate ayahs, handling the case where the first ayah contains both "Bismillah" and another part of the Quran
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: List.generate(widget.selectedSurah.ayahs!.length, (index) {
//                 if (index == 0 && isFirstAyahBismillah) {
//                   // Remove "Bismillah" from the first ayah and display the remaining text
//                   String ayahText = widget.selectedSurah.ayahs![index].text!;
//                   String remainingText = ayahText.replaceFirst(
//                       "بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ", '').trim();
//
//                   // Display "Ayah 1" with the remaining text (even if it contains no further text after Bismillah)
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       if (remainingText.isNotEmpty)
//                         Container(
//                           width: size.width,
//                           child: Card(
//                             color: Color(0xFFF9F9F9),
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(horizontal:size.width/50),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   SizedBox(height: size.height/20,),
//                                   Text(
//                                     "${remainingText} (1)",
//                                     textAlign: TextAlign.end,
//                                     style: TextStyle(
//                                       fontSize: size.width/30,
//                                       height: size.height/500, // Set line height
//                                       decorationColor: Color(0xFF00A49B),
//                                     ),
//                                   ),
//                                   SizedBox(height: size.height/20,),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       // Divider(color: Get.isDarkMode ? Colors.white70 : Colors.black87),
//                     ],
//                   );
//                 }
//
//                 // Display all other ayahs normally, ensuring correct numbering starts from the second ayah
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: size.width,
//                       child: Card(
//                         // elevation: 3,
//                         color: Color(0xFFF9F9F9),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(horizontal: size.width/50),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               SizedBox(height: size.height/20,),
//                               Text(
//                                 '${widget.selectedSurah.ayahs![index].text} (${index + 1})',
//                                 textAlign: TextAlign.end,
//                                 style: TextStyle(
//                                   fontSize: size.width/30,
//                                   height: size.height/400, // Set line height for long ayahs
//                                   decorationColor: Color(0xFF00A49B),
//                                 ),
//                               ),
//                               SizedBox(height: size.height/20,),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
