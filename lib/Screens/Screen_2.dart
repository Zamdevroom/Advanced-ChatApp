import 'package:flutter/material.dart';
import 'Phone_Number.dart';
import 'Drop_Down_Helper.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 10),
                child: Column(
                  children: [
                    Image.asset("lib/Images/wecome_image_2.PNG"),
                    Text(
                      "Read our Privacy Policy. Tap '\"Agree and\ncontinue \"' to accept the Terms of Service.",
                      style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DropDownHelper(),
                    Spacer(),
                    Builder(builder: (context) {
                      return ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PhoneNumber()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 70, right: 70, top: 9, bottom: 9),
                            child: Text(
                              "Agree and continue",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.grey[100]),
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ));
                    }),
                  ],
                ),
              ),
            )));
  }
}
