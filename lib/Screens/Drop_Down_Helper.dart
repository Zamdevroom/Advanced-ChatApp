import 'package:flutter/material.dart';
import 'main.dart';
class DropDownHelper extends StatefulWidget {
  const DropDownHelper({super.key});

  @override
  State<DropDownHelper> createState() => _DropDownHelperState();
}

class _DropDownHelperState extends State<DropDownHelper> {
  void _showLanguageListSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return languageList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return
          Column(
            children: [
              SizedBox(height: 40),
              Center(
                child: InkWell(
                  onTap: () {
                    _showLanguageListSheet(context);
                  },
                  child: Container(
                    height: 40,
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(
                          Icons.language,
                          size: 30,
                          color: Colors.green,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "English",
                          style: TextStyle(color: Colors.green, fontSize: 20),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 30,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}



