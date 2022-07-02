import 'package:flutter/material.dart';

Widget enabledButton({
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

Widget generalButton({
  required String title,
  required IconData icon,
  required VoidCallback onClicked,
  required Color color,
}) =>
    SizedBox(
      width: 245, // <-- Your width
      height: 60, // <-- Your height
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          onPrimary: Colors.white,
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

Widget smallImageButton({
  required IconData icon,
  required VoidCallback onClicked,
  required Color color,
  required bool isRight,
}) =>
    SizedBox(
      width: 65, // <-- Your width
      height: 40, // <-- Your height
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          onPrimary: Colors.white,
          textStyle: TextStyle(fontSize: 11),
          shape: isRight
              ? const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.circular(32.0),
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.circular(32.0),
                  ),
                )
              : const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.zero,
                    bottomLeft: Radius.circular(32.0),
                    bottomRight: Radius.zero,
                  ),
                ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 23),
          ],
        ),
        onPressed: onClicked,
      ),
    );
final List<String> genderItems = [
  'Male',
  'Female',
];

// Widget dropDownButton({required void function1, required void function2}) =>
//     PopupMenuButton(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(15.0))),
//       color: Colors.deepPurpleAccent,
//       initialValue: 1,
//       child: Container(
//         width: 245,
//         height: 60,
//         decoration: BoxDecoration(
//             color: Color(0xFFFE9901),
//             borderRadius: BorderRadius.all(Radius.circular(32))),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.add_photo_alternate_rounded,
//               size: 28,
//               color: Colors.white,
//             ),
//             const SizedBox(width: 10),
//             Text(
//               "Załaduj zdjęcie",
//               style: TextStyle(fontSize: 20, color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//       itemBuilder: (BuildContext context) => <PopupMenuEntry>[
//         PopupMenuItem(
//           onTap: () => function1,
//           padding: const EdgeInsets.only(right: 40, left: 40),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.photo_library_rounded,
//                 size: 28,
//                 color: Colors.white,
//               ),
//               const SizedBox(width: 10),
//               Text(
//                 " Wybierz zdjęcie",
//                 style: TextStyle(fontSize: 20, color: Colors.white),
//               ),
//             ],
//           ),
//         ),
//         PopupMenuItem(
//           onTap: () => function2,
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.camera_alt_rounded,
//                 size: 28,
//                 color: Colors.white,
//               ),
//               const SizedBox(width: 10),
//               Text(
//                 "     Zrób zdjęcie  ",
//                 style: TextStyle(fontSize: 20, color: Colors.white),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
