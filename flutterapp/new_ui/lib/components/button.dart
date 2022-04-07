import 'package:flutter/material.dart';

Widget UploadImageButton({
  required String title,
  required IconData icon,
  required VoidCallback onClicked,
}) =>
    SizedBox(
      width: 215, // <-- Your width
      height: 55, // <-- Your height
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.indigo,
          onPrimary: Colors.white,
          textStyle: TextStyle(fontSize: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
          //minimumSize: const Size(40, 60),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 10),
            Text(title),
          ],
        ),
        onPressed: onClicked,
      ),
    );

Widget TakeImageButton({
  required String title,
  required IconData icon,
  required VoidCallback onClicked,
}) =>
    SizedBox(
      width: 215, // <-- Your width
      height: 55, // <-- Your height
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.indigo,
          onPrimary: Colors.white,
          textStyle: TextStyle(fontSize: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
          //minimumSize: const Size(40, 60),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 10),
            Text(title),
          ],
        ),
        onPressed: onClicked,
      ),
    );
