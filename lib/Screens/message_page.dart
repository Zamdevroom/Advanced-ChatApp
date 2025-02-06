import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

class message_page extends StatefulWidget {
  const message_page({super.key});

  @override
  State<message_page> createState() => _message_pageState();
}

class _message_pageState extends State<message_page> {
  static const stylSender = BubbleStyle(
    margin: const BubbleEdges.only(top: 10),
    alignment: Alignment.topRight,
    nip: BubbleNip.rightTop,
    color: const Color.fromRGBO(225, 255, 199, 1),
  );
  static const stylReceiver = BubbleStyle(
    margin: const BubbleEdges.only(top: 10),
    alignment: Alignment.topLeft,
    nip: BubbleNip.leftTop,
  );
  ScrollController _myController = ScrollController();
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _myController.jumpTo(_myController.position.maxScrollExtent);
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          controller: _myController,
          scrollDirection: Axis.vertical,
          children: [
            Bubble(
              alignment: Alignment.center,
              color: const Color.fromRGBO(212, 234, 244, 1),
              child: const Text('TODAY',
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 11)),
            ),
            Bubble(
              style: stylSender,
              child: const Text('Hello, World!', textAlign: TextAlign.right),
            ),
            Bubble(
              style: stylSender,
              showNip: false,
              child: const Text('How are you?', textAlign: TextAlign.right),
            ),
            Bubble(
              style: stylReceiver,
              child: const Text('Hi, developer!'),
            ),
            Bubble(
              style: stylReceiver,
              showNip: false,
              child: const Text('Well, see for yourself'),
            ),
            Bubble(
              style: stylSender,
              child: const Text('Hello, World!', textAlign: TextAlign.right),
            ),
            Bubble(
              style: stylSender,
              showNip: false,
              child: const Text('How are you?', textAlign: TextAlign.right),
            ),
            Bubble(
              style: stylReceiver,
              child: const Text('Hi, developer!'),
            ),
            Bubble(
              style: stylReceiver,
              showNip: false,
              child: const Text('Well, see for yourself'),
            ),
            Bubble(
              style: stylSender,
              child: const Text('Hello, World!', textAlign: TextAlign.right),
            ),
            Bubble(
              style: stylSender,
              showNip: false,
              child: const Text('How are you?', textAlign: TextAlign.right),
            ),
            Bubble(
              style: stylReceiver,
              child: const Text('Hi, developer!'),
            ),
            Bubble(
              style: stylReceiver,
              showNip: false,
              child: const Text('Well, see for yourself'),
            ),
            Bubble(
              style: stylSender,
              child: const Text('Hello, World!', textAlign: TextAlign.right),
            ),
            Bubble(
              style: stylSender,
              showNip: false,
              child: const Text('How are you?', textAlign: TextAlign.right),
            ),
            Bubble(
              style: stylReceiver,
              child: const Text('Hi, developer!'),
            ),
            Bubble(
              style: stylReceiver,
              showNip: false,
              child: const Text('Well, see for yourself'),
            ),
            Bubble(
              style: stylSender,
              child: const Text('Hello, World!', textAlign: TextAlign.right),
            ),
            Bubble(
              style: stylSender,
              showNip: false,
              child: const Text('How are you?', textAlign: TextAlign.right),
            ),
            Bubble(
              style: stylReceiver,
              child: const Text('Hi, developer!'),
            ),
            Bubble(
              style: stylReceiver,
              showNip: false,
              child: const Text('Well, see for yourself'),
            ),
          ],
        ),
      ),
    );
  }
}
