
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/Settings/settings.dart';

class TopSection extends StatelessWidget {
  double height;
  String text;
  Widget customWidget;

  TopSection({super.key, required this.height,required this.text, required this.customWidget});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: height,
      color: Colors.transparent,
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width / 20),
                  child: Text(
                    text,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: size.height / 40,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>Setting()));
                  },
                  icon: const Icon(Icons.settings, color: Colors.white),
                ),
              ],
            ),
            // const Spacer(),
            Expanded(child: customWidget ),
          ],
        ),
      ),
    );
  }
}

