import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../ClassModals/QuranModal.dart';

class SurahCard extends StatelessWidget {
  final Surah selectedSurah; // Assuming Surah is a defined model class

  const SurahCard({
    Key? key,
    required this.selectedSurah,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF71D48F), // Slightly lighter shade
              const Color(0xFF2E8E4D), // Base color
              const Color(0xFF2E8E4D),
              const Color(0xFF2E8E4D), // Base color
              const Color(0xFF71D48F), // Slightly lighter shade
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.circular(size.height / 70),
        ),
        child: Padding(
          padding: EdgeInsets.all(size.height / 90),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedSurah.englishName ?? '',
                          style: TextStyle(
                            fontSize: size.width / 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${selectedSurah.englishNameTranslation ?? ''} (${selectedSurah.ayahs.length})",
                          style: TextStyle(
                            fontSize: size.width / 36,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width / 300,
                    color: Colors.white,
                    height: size.height / 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          selectedSurah.name ?? '',
                          style: TextStyle(
                            fontFamily: 'Amiri',
                            fontSize: size.width / 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          selectedSurah.revelationType == "Meccan"
                              ? '\u0645\u064E\u0643\u0651\u0650\u064A\u0651\u0629'
                              : '\u0645\u064E\u062F\u064E\u0646\u0650\u064A\u0651\u0629',
                          style: TextStyle(
                            fontFamily: 'Amiri',
                            fontSize: size.width / 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const Divider(color: Colors.white),
              if (selectedSurah.number != 9)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height / 100),
                  child: SvgPicture.asset(
                    'assets/svgs/bismillah.svg',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
