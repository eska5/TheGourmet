import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_ui/functions/func.dart';
import 'package:new_ui/popupcard/add_todo_button.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo[50],
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            height: smallSreen() ? 5 : 30,
          ),
          Text('Gourmet',
              style: GoogleFonts.caveat(
                fontSize: 90,
                textStyle: TextStyle(letterSpacing: 7),
              )),
          SizedBox(
            height: 20,
          ),
          Image.asset(
            "assets/hot.png",
            height: 290,
          ),
          SizedBox(
            height: 10,
          ),
          Text('Jakub Sachajko & Łukasz Niedźwiadek © 2022',
              style: GoogleFonts.caveat(
                fontSize: 17,
                textStyle: TextStyle(letterSpacing: 0),
              )),
          Expanded(child: Container()),

          // InfoButton(
          //   title: 'Instrukcja',
          //   icon: Icons.info_outline_rounded,
          //   onClicked: () => LoaderDialog.showLoadingDialog(context, _LoaderDialog),
          // ),
          // SizedBox(
          //   height: 25,
          // ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: AddTodoButton(),
          )
        ],
      ),
    );
  }
}
