import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wa_business/Islam/screens/Tasbeeh/tasbeeh.dart';

import '../../Utility/appColors.dart';
import '../../Utility/topPart.dart';
import '../../home.dart';
import 'Dialogs.dart';

class Tasbeehmainscreen extends StatefulWidget {
  const Tasbeehmainscreen({super.key});

  @override
  State<Tasbeehmainscreen> createState() => _TasbeehmainscreenState();
}

class _TasbeehmainscreenState extends State<Tasbeehmainscreen> {
  RxList<String> engPhrases = <String>[].obs;
  RxList<String> arabPhrases = <String>[].obs;

  List<String> addArabTasbeeh = [];
  List<String> addEngTasbeeh = [];

  @override
  void initState() {
    super.initState();
    // Initialize with saved tasbeehs from SharedPreferences
    arabPhrases.assignAll(MyTasbeeh.arabWords ?? []);
    engPhrases.assignAll(MyTasbeeh.engWords ?? []);
    fetchTasbeeh();
  }

  Future<void> fetchTasbeeh() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    addArabTasbeeh = prefs.getStringList('arabTasbeeh') ?? [];
    addEngTasbeeh = prefs.getStringList('engTasbeeh') ?? [];

    // Update the reactive lists directly, this will trigger UI updates
    arabPhrases.addAll(addArabTasbeeh);
    engPhrases.addAll(addEngTasbeeh);

    arabPhrases.reversed;
    engPhrases.reversed;
  }

  Future<void> addTasbeeh(String arabTxt, String engTxt) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Add new tasbeeh items to the local lists
    addArabTasbeeh.add(arabTxt);
    addEngTasbeeh.add(engTxt);

    // Save updated tasbeeh lists in SharedPreferences
    await prefs.setStringList('arabTasbeeh', addArabTasbeeh);
    await prefs.setStringList('engTasbeeh', addEngTasbeeh);

    // Directly add the new tasbeehs to RxList to update UI
    arabPhrases.add(arabTxt);
    engPhrases.add(engTxt);
  }

  Future<void> deleteTasbeeh(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Remove the custom-added Tasbeeh at the given index from the local lists
    // if (index >= 0 && index < engPhrases.length) {
    print(addArabTasbeeh);
    print(engPhrases.length);
    print(index-7);
      addArabTasbeeh.removeAt(index-7);
      addEngTasbeeh.removeAt(index-7);

      // Update SharedPreferences
      await prefs.setStringList('arabTasbeeh', addArabTasbeeh);
      await prefs.setStringList('engTasbeeh', addEngTasbeeh);

    await prefs.remove('arabTasbeeh');
    await prefs.remove('engTasbeeh');
      // Update the reactive lists
      arabPhrases.removeAt(index);
      engPhrases.removeAt(index);
    // }
    print(engPhrases);

  }


  Future<void> editTasbeeh(int index, String newArabTxt, String newEngTxt) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // print(index-7);
    // Update the custom-added Tasbeeh at the given index
    // print(addArabTasbeeh[index-7]);
    addArabTasbeeh[index-7] = newArabTxt;
    addEngTasbeeh[index-7] = newEngTxt;

    // Update SharedPreferences
    await prefs.setStringList('arabTasbeeh', addArabTasbeeh);
    await prefs.setStringList('engTasbeeh', addEngTasbeeh);
    // Update the custom RxList
    // print(engPhrases[index]);
    engPhrases[index] = newEngTxt;
    arabPhrases[index] = newArabTxt;
    // customArabPhrases[index] = newArabTxt;
    // customEngPhrases[index] = newEngTxt;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Tasbeeh', style: TextStyle(fontFamily: 'Poppins', color: AppColors.primaryColor, fontWeight: FontWeight.bold),),
        iconTheme: IconThemeData(
            color: AppColors.primaryColor
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        mini:true,
        onPressed: () {
          MyDialogs.engTxt.clear();
          MyDialogs.arabTxt.clear();
          MyDialogs.TasbeehAdd(context, size.height, size.width, () async {
            if (MyDialogs.arabTxt.text.isEmpty || MyDialogs.engTxt.text.isEmpty) {
              Get.snackbar('Alert', 'Please enter the texts of Tasbeeh',
                  backgroundColor: Color(0xBFFF1C1C));
            } else {
              await addTasbeeh(MyDialogs.arabTxt.text, MyDialogs.engTxt.text);
              Navigator.pop(context);
            }
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            CustomCard(pic: 'frontLogo.png',
                expand: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dhikr: The Light of the Heart', style: TextStyle(fontFamily: 'Amiri', fontWeight: FontWeight.bold, color: Colors.white, fontSize: size.height/56),),
                      Text("Deepen your connection with Allah—let Dhikr bring peace to your heart and endless blessings to your life.", style: TextStyle(fontSize: size.height/84, color: Colors.white, fontFamily: 'Poppins'),),
                    ],
                  ),
                ), height: 5.5),
            Expanded(
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  Obx(()=>
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                print(index);
                                MyDialogs.target.clear();
                                MyDialogs.TasbeehTarget(context, size.height, size.width,
                                    engPhrases[index], arabPhrases[index]);
                              },
                              child: StylishCard(
                                index: index,
                                arabicText: arabPhrases[index],
                                engText: engPhrases[index],
                                trailing: addArabTasbeeh.contains(arabPhrases[index])?IconButton(onPressed: (){
                                  MyDialogs.arabTxt.text = arabPhrases[index];
                                  MyDialogs.engTxt.text = engPhrases[index];

                                  MyDialogs.TasbeehEdit(context, size.height, size.width,
                                          (){
                                        Navigator.pop(context);
                                        editTasbeeh(index, MyDialogs.arabTxt.text.toString(), MyDialogs.engTxt.text.toString());
                                      },
                                          (){
                                        Navigator.pop(context);
                                        deleteTasbeeh(index);
                                      });
                                }, icon: Icon(Icons.edit)):SizedBox.shrink(),

                              ),
                            );
                          },
                          childCount: arabPhrases.length,
                        ),
                      ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
class StylishCard extends StatelessWidget {
  final int index;
  final String arabicText; // Dynamic text input
  final String engText; // Dynamic time input
  Widget? trailing;

  StylishCard({
    Key? key,
    required this.index,
    required this.arabicText,
    required this.engText,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width / 50, vertical: size.height / 500),
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: size.height/40, horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Index on the leftmost side
              CircleAvatar(
                backgroundColor: AppColors.primaryColor, // Custom color
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 10), // Space between index and English text
              // English text on the left
              Expanded(
                child: Text(
                  engText,
                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              // Arabic text on the right
              Expanded(
                child: Text(
                  arabicText,
                  style: TextStyle(fontFamily: 'Amiri', fontSize: size.height/40),
                  textAlign: TextAlign.right,
                ),
              ),
              if (trailing != null) trailing!, // Optional trailing widget
            ],
          ),
        ),
      ),
    );
  }
}
