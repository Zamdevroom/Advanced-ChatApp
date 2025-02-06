import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class Fetch_contacts{

Future<void> requestContactPermission() async {
  var status = await Permission.contacts.status;
  if (!status.isGranted) {
    await Permission.contacts.request();
  }
}
Future<void> fetchAndStoreContacts() async {
  await requestContactPermission();

  Iterable<Contact> contacts = await ContactsService.getContacts();

  // Get Firestore instance
  final firestore = FirebaseFirestore.instance;

  // Store contacts in Firebase
  for (Contact contact in contacts) {
    firestore.collection('contacts').add({
      'name': contact.displayName,
      'phone': contact.phones!.isNotEmpty ? contact.phones!.first.value : null,
    });
  }
}
}