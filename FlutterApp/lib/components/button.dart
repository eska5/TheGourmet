import 'package:flutter/material.dart';

Widget UploadImageButton({
  required String title,
  required IconData icon,
  required VoidCallback onClicked,
}) =>
    SizedBox(
      width: 235, // <-- Your width
      height: 60, // <-- Your height
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

Widget NavigationButton({
  required String title,
  required IconData icon,
  required VoidCallback onClicked,
  required Color? backgroundColor,
  required double fontSize,
  required bool enabled,
}) =>
    SizedBox(
      width: 235, // <-- Your width
      height: 60, // <-- Your height
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
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
      width: 235, // <-- Your width
      height: 60, // <-- Your height
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

Widget ClassifyImageButton({
  required String title,
  required IconData icon,
  required VoidCallback onClicked,
}) =>
    SizedBox(
      width: 235, // <-- Your width
      height: 60, // <-- Your height
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.indigo,
          onPrimary: Colors.white,
          textStyle: TextStyle(fontSize: 18),
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

Widget SubmitImageButton({
  required String title,
  required IconData icon,
  required VoidCallback onClicked,
}) =>
    SizedBox(
      width: 235, // <-- Your width
      height: 60, // <-- Your height
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

Widget InfoButton({
  required String title,
  required IconData icon,
  required VoidCallback onClicked,
}) =>
    SizedBox(
      width: 190, // <-- Your width
      height: 55, // <-- Your height
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.indigo,
          onPrimary: Colors.white,
          textStyle: TextStyle(fontSize: 23),
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
