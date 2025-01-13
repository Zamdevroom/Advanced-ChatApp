import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:wa_business/Islam/Utility/appColors.dart';
import 'package:wa_business/Islam/screens/Tasbeeh/tasbeehCount.dart';

class MyDialogs{
  static final target = TextEditingController();
  static final arabTxt = TextEditingController();
  static final engTxt = TextEditingController();
  static bool canShowSnackBar = true;
  static void TasbeehTarget(BuildContext context,double h, double w, String str, String arabStr){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(w/20),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Set Target', style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
            Divider(),
            Text.rich(
              softWrap: true,
              TextSpan(
                children: [
                  TextSpan(
                    text: "Tasbeeh: ", // Non-bold text
                    style: TextStyle(
                      fontSize: w / 24,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  TextSpan(
                    text: str, // Bold text
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: w / 24,
                      fontWeight: FontWeight.bold, // Bold style for `str`
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        content: TextFormField(
          controller: target,
          keyboardType: TextInputType.number,
          style: TextStyle(),
          decoration: InputDecoration(
            hintText: "Set Tasbeeh Target",
            hintStyle: TextStyle(
              fontSize: w/26,
              // color: Get.isDarkMode ? Colors.black : Colors.white,
            ),
            prefixIcon: Icon(
              Icons.numbers,
            ),
            filled: true, // Enable background color
            fillColor: AppColors.primaryColor.withOpacity(0.1), // Change the field color
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(w/5), // Circular border
              borderSide: BorderSide(
                color: Colors.transparent, // Transparent border color
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0), // Circular border on focus
              borderSide: BorderSide(
                color: Colors.transparent, // Transparent border color on focus
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: h / 70, // Responsive vertical padding
            ),
          ),
        ),
        actions: [
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.primaryColor),
              ),onPressed: (){
            Navigator.pop(context);
          }, child: Text("Cancel", style: TextStyle(
            color: AppColors.primaryColor,
          ),)),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor
              ),
              onPressed: (){
                if(target.value.text.isEmpty && canShowSnackBar){
                  canShowSnackBar = false;
                  Get.snackbar('Track Your Dhikr', 'Please enter a value for Tasbeeh', backgroundColor: AppColors.primaryColor);
                  Future.delayed(Duration(seconds: 6), () {
                    canShowSnackBar = true;
                  });
                }else if(target.value.text.isNotEmpty){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=> CounterScreen(engTxt: str, arabTxt: arabStr, target: target.text,)));
                }
                }, child: Text("Set", style: TextStyle( color: Colors.white
            // color: Get.isDarkMode ? Colors.white : Colors.black,
          ),)),
        ],

      );
    });
  }

  static void TasbeehAdd(BuildContext context, double h, double w, VoidCallback onTap,) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(w / 20),
          ),
          // backgroundColor: Color(0xFF00CDC9),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Tasbeeh',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: arabTxt,
                  style: TextStyle(),
                  decoration: InputDecoration(
                    hintText: "Arabic of tasbeeh",
                    hintStyle: TextStyle(
                      fontSize: w / 26,
                      // color: Get.isDarkMode ? Colors.black : Colors.white,
                    ),
                    prefixIcon: Icon(
                      Icons.numbers,
                    ),
                    filled: true, // Enable background color
                    fillColor: AppColors.primaryColor.withOpacity(0.1), // Change the field color
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w / 5), // Circular border
                      borderSide: BorderSide(
                        color: Colors.transparent, // Transparent border color
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), // Circular border on focus
                      borderSide: BorderSide(
                        color: Colors.transparent, // Transparent border color on focus
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: h / 70, // Responsive vertical padding
                    ),
                  ),
                ),
                SizedBox(height: h / 50),
                TextFormField(
                  controller: engTxt,
                  style: TextStyle(),
                  decoration: InputDecoration(
                    hintText: "English of tasbeeh",
                    hintStyle: TextStyle(
                      fontSize: w / 26,
                      // color: Get.isDarkMode ? Colors.black : Colors.white,
                    ),
                    prefixIcon: Icon(
                      Icons.numbers,
                    ),
                    filled: true, // Enable background color
                    fillColor: AppColors.primaryColor.withOpacity(0.1), // Change the field color
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w / 5), // Circular border
                      borderSide: BorderSide(
                        color: Colors.transparent, // Transparent border color
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), // Circular border on focus
                      borderSide: BorderSide(
                        color: Colors.transparent, // Transparent border color on focus
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: h / 70, // Responsive vertical padding
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.primaryColor)
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              onPressed: () {
                onTap(); // Call the onTap function here
              },
              child: Text(
                "Add",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }


  static void TasbeehEdit(BuildContext context, double h, double w, VoidCallback onTap, VoidCallback onDltTap) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(w / 20),
          ),
          // backgroundColor: Color(0xFF00CDC9),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Edit Tasbeeh',
                      style: TextStyle(
                        fontSize: w/18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(onPressed: (){
                    onDltTap();
                  }, icon: Icon(Icons.delete, color: Colors.red,))
                ],
              ),
              Divider(),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: arabTxt,
                  style: TextStyle(),
                  decoration: InputDecoration(
                    hintText: "Arabic of tasbeeh",
                    hintStyle: TextStyle(
                      fontSize: w / 26,
                      // color: Get.isDarkMode ? Colors.black : Colors.white,
                    ),
                    prefixIcon: Icon(
                      Icons.numbers,
                    ),
                    filled: true, // Enable background color
                    fillColor: AppColors.primaryColor.withOpacity(0.1), // Change the field color
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w / 5), // Circular border
                      borderSide: BorderSide(
                        color: Colors.transparent, // Transparent border color
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), // Circular border on focus
                      borderSide: BorderSide(
                        color: Colors.transparent, // Transparent border color on focus
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: h / 70, // Responsive vertical padding
                    ),
                  ),
                ),
                SizedBox(height: h / 50),
                TextFormField(
                  controller: engTxt,
                  style: TextStyle(),
                  decoration: InputDecoration(
                    hintText: "English of tasbeeh",
                    hintStyle: TextStyle(
                      fontSize: w / 26,
                      // color: Get.isDarkMode ? Colors.black : Colors.white,
                    ),
                    prefixIcon: Icon(
                      Icons.numbers,
                    ),
                    filled: true, // Enable background color
                    fillColor: AppColors.primaryColor.withOpacity(0.1),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w / 5), // Circular border
                      borderSide: BorderSide(
                        color: Colors.transparent, // Transparent border color
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), // Circular border on focus
                      borderSide: BorderSide(
                        color: Colors.transparent, // Transparent border color on focus
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: h / 70, // Responsive vertical padding
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: AppColors.primaryColor
                )
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              onPressed: () {
                onTap(); // Call the onTap function here
              },
              child: Text(
                "Update",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

}