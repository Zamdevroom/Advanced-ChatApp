import 'package:flutter/material.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
          backgroundColor: Colors.green[900],
          onPressed: () {},
        ),
      ),
    );
  }
}
