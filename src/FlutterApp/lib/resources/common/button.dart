import 'package:flutter/material.dart';

Widget generalButton({
  required String title,
  required IconData icon,
  required VoidCallback onClicked,
  required Color color,
  required Color textColor,
  required double width,
  required double height,
}) =>
    SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          primary: color,
          onPrimary: textColor,
          textStyle: const TextStyle(fontSize: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
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
