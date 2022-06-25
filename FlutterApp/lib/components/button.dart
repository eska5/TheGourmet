import 'package:flutter/material.dart';

Widget UploadImageButton({
  required String title,
  required IconData icon,
  required VoidCallback onClicked,
}) =>
    SizedBox(
      width: 65, // <-- Your width
      height: 40, // <-- Your height
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.indigoAccent,
          onPrimary: Colors.white,
          textStyle: TextStyle(fontSize: 13),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.0),
              topRight: Radius.zero,
              bottomLeft: Radius.circular(32.0),
              bottomRight: Radius.zero,
            ),
          ),
          //minimumSize: const Size(40, 60),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 23),
            //const SizedBox(width: 5),
            //Text(title),
          ],
        ),
        onPressed: onClicked,
      ),
    );

Widget NavigationButton({
  required String title,
  required IconData icon,
  required VoidCallback onClicked,
  required Color? backgroundColor,
  required double fontSize,
  required bool enabled,
}) =>
    SizedBox(
      width: 245, // <-- Your width
      height: 60, // <-- Your height
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          alignment: Alignment.centerLeft,
          primary: backgroundColor,
          onPrimary: Colors.white,
          textStyle: TextStyle(fontSize: fontSize),
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
        onPressed: enabled ? onClicked : null,
      ),
    );

Widget TakeImageButton({
  required String title,
  required IconData icon,
  required VoidCallback onClicked,
}) =>
    SizedBox(
      width: 65, // <-- Your width
      height: 40, // <-- Your height
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.indigoAccent,
          onPrimary: Colors.white,
          textStyle: TextStyle(fontSize: 11),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.zero,
              topRight: Radius.circular(32.0),
              bottomLeft: Radius.zero,
              bottomRight: Radius.circular(32.0),
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 23),
            //const SizedBox(width: 10),
            //Text(title),
          ],
        ),
        onPressed: onClicked,
      ),
    );

Widget SubmitImageButton({
  required String title,
  required IconData icon,
  required VoidCallback onClicked,
}) =>
    SizedBox(
      width: 245, // <-- Your width
      height: 60, // <-- Your height
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.deepPurpleAccent,
          onPrimary: Colors.white,
          textStyle: TextStyle(fontSize: 20),
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

Widget SubmitErrorButton({
  required String title,
  required IconData icon,
  required VoidCallback onClicked,
  required Color errorColor,
}) =>
    SizedBox(
      width: 235, // <-- Your width
      height: 60, // <-- Your height
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: errorColor,
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