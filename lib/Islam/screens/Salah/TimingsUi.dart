
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
    return Card(
      color: Colors.white,
      elevation: 4,
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor.withOpacity(0.75),
            // gradient: AppColors.linearGrad,
          ),
          child: CircleAvatar(
            backgroundColor: Colors.transparent, // Make the CircleAvatar background transparent
            child: Text(
              '${index + 1}',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,

                // fontStyle: FontStyle.italic,
                color: Colors.black ,
              ),
            ),
          ),
        ),
        title: Text(
          text, // Use dynamic text here
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w900, fontSize: 14 ),
        ),
        subtitle: Text(
          time,
          style: TextStyle(fontFamily: 'Poppins'),
        ), // Display the time string dynamically
      ),
    );
  }
}
