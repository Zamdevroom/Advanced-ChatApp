
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContentButtons extends StatelessWidget {
  String image;
  String text;
  VoidCallback onTap;
  ContentButtons({super.key, required this.image, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Card(
            color: Colors.white,
            elevation: 3,
            child: InkWell(
              onTap: onTap,
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Match border radius
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover, // Adjusts the image to fit within the size
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: size.height / 100),
        Text(text, style: TextStyle(fontSize: size.width/36, fontWeight: FontWeight.w400),)
      ],
    );
  }
}
