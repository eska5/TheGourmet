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
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: [
          SizedBox(
            height: smallSreen() ? 5 : 30,
          ),
          Center(
            child: Text('Gourmet',
                style: GoogleFonts.caveat(
                  fontSize: 90,
                  textStyle: const TextStyle(letterSpacing: 2),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            "assets/hot.png",
            height: 290,
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text('Jakub Sachajko & Łukasz Niedźwiadek © 2022',
                style: GoogleFonts.caveat(
                  fontSize: 17,
                  textStyle: const TextStyle(letterSpacing: 0),
                )),
          ),
          const SizedBox(
            height: 100,
          ),
          //Expanded(child: Container()),
          const Align(
            alignment: Alignment.bottomCenter,
            child: AddTodoButton(),
          )
        ],
      ),
    );
  }
}
