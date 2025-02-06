import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  final String senderID;
  final String senderEmail;
  final String receiverID;
  final String message;
  final Timestamp timestamp;
  Messages({
    required this.message,
    required this.receiverID,
    required this.senderEmail,
    required this.senderID,
    required this.timestamp

  });
  Map<String, dynamic> toMap(){
    return {
      'senderID': senderID,
      'senderEmail': receiverID,
      'receiverID': receiverID,
      'messags' : message,
      'Timestamp': timestamp

    };
  }
}