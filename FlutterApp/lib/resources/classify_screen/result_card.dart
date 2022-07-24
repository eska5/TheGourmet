library gourmet.result_card;

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_ui/resources/classify_screen/sub_screens/results.dart';

import 'methods.dart';

class CardDetails {
  String mealName;
  String mealDescription;
  double mealProbability;
  Color color;
  int cardNumber;
  bool isExpanded;

  CardDetails({
    required this.mealName,
    required this.mealDescription,
    required this.mealProbability,
    required this.color,
    required this.cardNumber,
    this.isExpanded = true,
  });
}

CardDetails result_1 = CardDetails(
  mealName: "",
  mealDescription: "",
  mealProbability: 0,
  color: Colors.blue.shade300,
  cardNumber: 1,
);

CardDetails result_2 = CardDetails(
    mealName: "",
    mealDescription: "",
    mealProbability: 0,
    color: Colors.blue.shade300,
    cardNumber: 2);

CardDetails result_3 = CardDetails(
    mealName: "",
    mealDescription: "",
    mealProbability: 0,
    color: Colors.blue.shade300,
    cardNumber: 3);

CardDetails result_4_and_more = CardDetails(
    mealName: "",
    mealDescription: "",
    mealProbability: 0,
    color: Colors.blue.shade300,
    cardNumber: 4);

CardDetails report_card = CardDetails(
    mealName: "Złe wyniki?",
    mealDescription: "",
    mealProbability: 0,
    color: const Color(0xFFFE9901),
    cardNumber: 4);

List<CardDetails> resultCards = [result_1, result_2, result_3];

Widget createResultCard(CardDetails cardDetails) {
  return Card(
    margin: EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 5),
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Container(
      decoration: BoxDecoration(
        color: cardDetails.color,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          collapsedTextColor: Colors.white,
          collapsedIconColor: Colors.white,
          leading: cardDetails.cardNumber == 1
              ? Wrap(children: const <Widget>[
                  Icon(
                    Icons.emoji_events_rounded,
                    color: Colors.amber,
                    size: 35,
                  ),
                ])
              : cardDetails.cardNumber == 2
                  ? Wrap(children: <Widget>[
                      Icon(
                        Icons.emoji_events_rounded,
                        color: Colors.grey.shade300,
                        size: 35,
                      ),
                    ])
                  : Wrap(children: const <Widget>[
                      Icon(
                        Icons.emoji_events_rounded,
                        color: Colors.brown,
                        size: 35,
                      ),
                    ]),
          textColor: Colors.white,
          iconColor: Colors.white,
          title: ValueListenableBuilder<bool>(
            builder: (BuildContext context, bool value, Widget? child) {
              return value == true
                  ? mealName(text: cardDetails.mealName, isLoading: false)
                  : mealName(text: cardDetails.mealName, isLoading: true);
            },
            valueListenable: ResultScreen.isClassified,
            child: const SizedBox.shrink(),
          ),
          children: <Widget>[
            ValueListenableBuilder<bool>(
              builder: (BuildContext context, bool value, Widget? child) {
                return value == true
                    ? mealProbability(
                        probability: cardDetails.mealProbability,
                        isLoading: false)
                    : mealProbability(
                        probability: cardDetails.mealProbability,
                        isLoading: true);
              },
              valueListenable: ResultScreen.isClassified,
              child: const SizedBox.shrink(),
            ),
            const SizedBox(
              height: 10,
            ),
            ValueListenableBuilder<bool>(
              builder: (BuildContext context, bool value, Widget? child) {
                return value == true
                    ? mealDescription(
                        text: cardDetails.mealDescription, isLoading: false)
                    : mealDescription(
                        text: cardDetails.mealDescription, isLoading: true);
              },
              valueListenable: ResultScreen.isClassified,
              child: const SizedBox.shrink(),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget mealName({required String text, required bool isLoading}) {
  return isLoading == false
      ? Text(
          text,
          style: const TextStyle(
              fontFamily: 'avenir',
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 24),
        )
      : const SpinKitThreeBounce(
          color: Colors.white,
          size: 40,
          duration: Duration(seconds: 2),
        );
}

Widget mealProbability({required double probability, required bool isLoading}) {
  return isLoading == false
      ? Text(
          "Prawdopodobieństwo: " + probability.toStringAsFixed(2) + "%",
          style: const TextStyle(
              fontFamily: 'avenir',
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18),
        )
      : const SizedBox();
}

Widget mealDescription({required String text, required bool isLoading}) {
  return isLoading == false
      ? Text(
          "Opis: " + text,
          style: const TextStyle(
              fontFamily: 'avenir',
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18),
        )
      : const SizedBox();
}

Widget createReportCard(
    CardDetails cardDetails, BuildContext context, Function onClick) {
  return Card(
    margin: EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 5),
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Container(
      decoration: BoxDecoration(
        color: cardDetails.color,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          collapsedTextColor: Colors.white,
          collapsedIconColor: Colors.white,
          leading: const Icon(
            Icons.report_rounded,
            size: 35,
          ),
          textColor: Colors.white,
          iconColor: Colors.white,
          title: ValueListenableBuilder<bool>(
            builder: (BuildContext context, bool value, Widget? child) {
              return value == true
                  ? mealName(text: cardDetails.mealName, isLoading: false)
                  : mealName(text: cardDetails.mealName, isLoading: true);
            },
            valueListenable: ResultScreen.isClassified,
            child: const SizedBox.shrink(),
          ),
          children: <Widget>[
            ValueListenableBuilder<bool>(
              builder: (BuildContext context, bool value, Widget? child) {
                return value == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            height: 3,
                          ),
                          GestureDetector(
                            onTap: () => getMoreResults(onClick),
                            child: Container(
                              width: 120,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade400,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  const BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 4.0,
                                      spreadRadius: 1,
                                      offset: Offset(0, 0))
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  "Więcej\nwyników",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontFamily: 'avenir',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => navigateToReportScreen(context),
                            child: Container(
                              width: 120,
                              height: 80,
                              decoration: BoxDecoration(
                                color: const Color(0xFFDC143C),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  const BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 4.0,
                                      spreadRadius: 1,
                                      offset: Offset(0, 0))
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  "Zgłoś\nwynik",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontFamily: 'avenir',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                        ],
                      )
                    : const SizedBox.shrink();
              },
              valueListenable: ResultScreen.isClassified,
              child: const SizedBox.shrink(),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget reportCardContent() {
  return Row(
    children: [],
  );
}
