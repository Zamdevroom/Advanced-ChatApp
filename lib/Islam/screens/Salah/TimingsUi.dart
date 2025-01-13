
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wa_business/Islam/Utility/appColors.dart';

class StylishCard extends StatelessWidget {
  final int index;
  final String text; // Dynamic text input
  final String time; // Dynamic time input

  const StylishCard({
    Key? key,
    required this.index,
    required this.text,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width/50),
      child: Card(
        child: ListTile(
          leading: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor,
              // gradient: AppColors.linearGrad,
            ),
            child: CircleAvatar(
              backgroundColor: Colors.transparent, // Make the CircleAvatar background transparent
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  // fontStyle: FontStyle.italic,
                  color: Colors.white ,
                ),
              ),
            ),
          ),
          title: Text(
            text, // Use dynamic text here
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            time,
            style: TextStyle(),
          ), // Display the time string dynamically
        ),
      ),
    );
  }
}
