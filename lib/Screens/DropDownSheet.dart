import 'package:flutter/material.dart';

class AttachFileOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30,right: 20,left: 20),
      child: GridView.count(
        crossAxisCount: 3, // Three items in each row
        children: [
          OptionItem(icon: Icons.description, label: 'Document', color: Colors.blue),
          OptionItem(icon: Icons.camera_alt, label: 'Camera', color: Colors.red),
          OptionItem(icon: Icons.photo, label: 'Gallery', color: Colors.green),
          OptionItem(icon: Icons.audiotrack, label: 'Audio', color: Colors.orange),
          OptionItem(icon: Icons.location_on, label: 'Location', color: Colors.purple),
          OptionItem(icon: Icons.contact_phone, label: 'Contact', color: Colors.teal),
        ],
      ),
    );
  }
}

class OptionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  OptionItem({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle, // Make the icon container circular
            color: Colors.grey[300], // Set the background color for the icon container
          ),
          padding: EdgeInsets.all(10), // Add padding around the icon
          child: Icon(
            icon,
            size: 48, // Adjust the icon size as needed
            color: color, // Set the icon color
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 16), // Adjust the text style as needed
        ),
      ],
    );
  }
}
