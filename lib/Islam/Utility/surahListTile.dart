import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'appColors.dart';

class ListUi extends StatefulWidget {
  String index;
  String surahName;
  String engName;
  String arabic;
  String reveal;
  VoidCallback onPressed;
  ListUi({
    super.key,
    required this.index,
    required this.surahName,
    required this.engName,
    required this.arabic,
    required this.reveal,
    required this.onPressed,
  });

  @override
  State<ListUi> createState() => _ListUiState();
}

class _ListUiState extends State<ListUi> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: widget.onPressed,
      child: Card(
        elevation: 5,
        color: Colors.white,
        child: Container(
          height: size.height / 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width / 5,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Replace background with SVG
                    SvgPicture.asset('assets/svgs/round1.svg',
                      height: size.height/13,
                      fit: BoxFit.cover,
                    ),
                    Center(
                      child: Text(
                        '${widget.index}',
                        style: TextStyle(
                          fontSize: size.width / 34,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.surahName}",
                      style: TextStyle(
                        fontSize: size.width / 20,
                        fontFamily: 'Amiri',
                        fontWeight: FontWeight.bold,
                        // fontStyle: FontStyle.italic,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      "${widget.engName}",
                      style: TextStyle(fontSize: size.width / 35, color: AppColors.primaryColor, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${widget.reveal}",
                      style: TextStyle(fontSize: size.width / 35),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: size.width / 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${widget.arabic}",
                      style: TextStyle(
                        fontSize: size.width / 18,
                        fontFamily: 'Amiri',
                        height: 2,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
