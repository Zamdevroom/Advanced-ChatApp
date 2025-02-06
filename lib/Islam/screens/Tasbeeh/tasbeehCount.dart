import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wa_business/Islam/Utility/appColors.dart';

import '../../Utility/topPart.dart';

class CounterScreen extends StatefulWidget {
  final String? engTxt;
  final String? arabTxt;
  final String? target;

  CounterScreen({super.key, required this.engTxt, required this.arabTxt, this.target = '100'});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> with SingleTickerProviderStateMixin {
  RxInt _counter = 0.obs;
  bool isSnack = true;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _incrementCounter() {
    int? parseInt = int.tryParse(widget.target!);

    if (widget.target.toString() == _counter.toString() && isSnack) {
      isSnack = false;
      Get.snackbar(
        'Target Complete',
        "Congratulations! You have reached your target.\nTo continue your tasbeeh, please reset your count.",
        backgroundColor: AppColors.primaryColor.withOpacity(0.5),
        animationDuration: Duration(seconds: 2),
      );
      Timer(Duration(seconds: 10), () {
        isSnack = true;
      });
    } else if (parseInt! > _counter.value) {
      _counter++;
      _controller.forward().then((_) => _controller.reverse());
    } else {
      return;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            TopSection(
              height: size.height/8,
              text: "Tasbeeh Counter",
              customWidget: Center(),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size.height / 30),
                    topRight: Radius.circular(size.height / 30),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.arabTxt}ِ',
                        style: TextStyle(
                          fontSize: size.height / 16,
                          // fontWeight: FontWeight.bold,
                          fontFamily: 'Amiri',
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              offset: Offset(2, 2),
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        textAlign: TextAlign.center,
                        '${widget.engTxt}',
                        style: TextStyle(
                          fontSize: 22,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Progress Bar
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                        child: Obx(() {
                          double progress = (_counter.value / int.parse(widget.target!));
                          return Column(
                            children: [
                              Text(
                                "Progress: ${(_counter.value / int.parse(widget.target!) * 100).toStringAsFixed(0)}%",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 10),
                              LinearProgressIndicator(
                                value: progress,
                                backgroundColor: Colors.grey[300],
                                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                                minHeight: size.height/300,
                              ),
                            ],
                          );
                        }),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: size.width / 1.6,
                        height: size.height / 2.4,
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15), // Optional for rounded corners
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFF71D48F), // Slightly lighter shade
                                  const Color(0xFF2E8E4D), // Base color
                                  const Color(0xFF2E8E4D), // Darker shade for depth
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                              borderRadius: BorderRadius.circular(15), // Apply same border radius to container
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(
                                      () => ScaleTransition(
                                    scale: _scaleAnimation,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: size.width / 30,
                                          left: size.width / 30,
                                          top: size.height / 32,
                                          bottom: size.height / 100),
                                      child: Container(
                                        height: size.height / 8,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(size.height / 40),
                                          color: Color(0xFFDFF5E4),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '$_counter',
                                            style: TextStyle(
                                              fontSize:
                                              _counter < 1000 ? size.height / 14 : size.height / 24,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFF2E8E4D),
                                              shadows: [
                                                Shadow(
                                                  blurRadius: 15.0,
                                                  color: Colors.black26,
                                                  offset: Offset(3, 3),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: size.width / 12),
                                        child: Obx(
                                              () => Text(
                                            "Target: ${_counter}/${widget.target}",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width / 20, vertical: size.height / 100),
                                      child: IconButton(
                                        onPressed: () {
                                          isSnack = true;
                                          _counter.value = 0;
                                        },
                                        icon: Icon(Icons.restart_alt, size: 40, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Center(
                                    child: ElevatedButton(
                                      onPressed: _incrementCounter,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: CircleBorder(),
                                        padding: EdgeInsets.all(24),
                                        shadowColor: Colors.black.withOpacity(0.9),
                                        elevation: 20,
                                      ),
                                      child: Icon(
                                        Icons.fingerprint,
                                        color: Color(0xFF00A9B6),
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
