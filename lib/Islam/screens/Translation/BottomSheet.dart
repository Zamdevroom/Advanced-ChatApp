import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wa_business/Islam/Utility/appColors.dart';
import 'package:wa_business/Islam/screens/Translation/translationController.dart';

class LanguageBottomSheet {
  static final languages = {
    "Bengali": "bn",
    'Chinese': "zh",
    "Dutch": "nl",
    "English": "en",
    "French": "fr",
    "German": "de",
    "Hindi": "hi",
    "Indonesian": "id",
    "Italian": "it",
    "Japanese": "ja",
    "Korean": "ko",
    "Persian": "fa",
    "Romanian": "ro",
    "Russian": "ru",
    "Spanish": "es",
    "Swedish": "sv",
    "Turkish": "tr",
    "Urdu": "ur",
  };

  static void showLanguageSelectionBottomSheet(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Variable to store the selected language
    RxString selectedLanguage = 'English'.obs;
    TranslationControl tCont = Get.put(TranslationControl());

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(size.width / 16),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.horizontal_rule),
                  Text(
                    'Select Translation Language',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Divider(),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: languages.keys.length,
                      itemBuilder: (context, index) {
                        String language = languages.keys.elementAt(index);
                        return Obx((){
                          return RadioListTile<String>(
                            activeColor: AppColors.primaryColor,
                            value: language,
                            groupValue: selectedLanguage.value,
                            onChanged: (value) {
                              selectedLanguage.value = value.toString();
                              print("Selected Language: $selectedLanguage");
                            },
                            title: Text(
                              language,
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(onPressed: (){
                          print('object');
                        }, child: Text('Reset', style: TextStyle(fontFamily: 'Poppins', color: AppColors.primaryColor)), style: OutlinedButton.styleFrom(side: BorderSide(color: AppColors.primaryColor)),),
                      )),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(onPressed: ()async{
                          print(selectedLanguage.value);
                          tCont.changeLanguage(selectedLanguage.value);
                          // Navigator.pop(context);
                          Get.dialog(
                            barrierDismissible: false,
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(color: Colors.white,),
                                  SizedBox(height: 20,),
                                  Text('Getting things ready in your language', style: TextStyle(decoration: TextDecoration.none,fontSize: 10, fontFamily: 'Poppins', color: Colors.white),)
                                ],
                              ),
                            )
                          );
                          await tCont.getTranslation();

                          // Close the loading dialog after fetching data
                          Get.back();
                          Navigator.pop(context);
                        }, child: Text('Save', style: TextStyle(fontFamily: 'Poppins', color: Colors.white),), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor)),
                      )),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
