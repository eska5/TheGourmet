library gourmet.result_card;

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_ui/resources/classify_screen/sub_screens/classify_results.dart';

import 'classify_methods.dart';

class CardDetails {
  String mealName;
  String mealDescription;
  double mealProbability;
  Color color = Colors.blue.shade300;
  int cardNumber = 1;
  final bool isExpanded;

  CardDetails({
    this.mealName = "",
    this.mealDescription = "",
    this.mealProbability = 0,
    required this.color,
    required this.cardNumber,
    this.isExpanded = true,
  });
}

List<CardDetails> classifyResultCards = [
  CardDetails(color: Colors.blue.shade300, cardNumber: 1),
  CardDetails(color: Colors.blue.shade300, cardNumber: 2),
  CardDetails(color: Colors.blue.shade300, cardNumber: 3)
];

List<CardDetails> detectionResultCards = [
  CardDetails(color: Colors.blue.shade300, cardNumber: 1),
];

Widget createResultCard(CardDetails cardDetails, bool classification) {
  ValueNotifier<bool> isReady =
      classification ? ResultScreen.isClassified : ResultScreen.isDetected;
  return Card(
    margin: const EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 5),
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
          leading: cardNumberSwitchCase(cardDetails.cardNumber),
          textColor: Colors.white,
          iconColor: Colors.white,
          title: ValueListenableBuilder<bool>(
            builder: (BuildContext context, bool value, Widget? child) {
              return value == true
                  ? mealName(text: cardDetails.mealName, isLoading: false)
                  : mealName(text: cardDetails.mealName, isLoading: true);
            },
            valueListenable: isReady,
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
              valueListenable: isReady,
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
              valueListenable: isReady,
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

Widget cardNumberSwitchCase(int cardNumber) {
  Widget widget = const SizedBox.shrink();
  switch (cardNumber) {
    case 1:
      widget = Wrap(children: const <Widget>[
        Icon(
          Icons.emoji_events_rounded,
          color: Colors.amber,
          size: 35,
        ),
      ]);
      break;
    case 2:
      widget = Wrap(children: <Widget>[
        Icon(
          Icons.emoji_events_rounded,
          color: Colors.grey.shade300,
          size: 35,
        ),
      ]);
      break;
    case 3:
      widget = Wrap(children: const <Widget>[
        Icon(
          Icons.emoji_events_rounded,
          color: Colors.brown,
          size: 35,
        ),
      ]);
      break;
    case 4:
      widget = Wrap(children: <Widget>[
        Icon(
          Icons.star_outline_rounded,
          color: Colors.grey.shade300,
          size: 35,
        ),
      ]);
      break;
    default:
      widget = const SizedBox.shrink();
      break;
  }
  return widget;
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
      ? Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: const TextStyle(
                fontFamily: 'avenir',
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18),
          ),
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
                            onTap: () => getMoreResults(2, onClick, context),
                            //onTap: () => setDataInCards(2, onClick),
                            child: Container(
                              width: 120,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade400,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 4.0,
                                      spreadRadius: 1,
                                      offset: Offset(0, 0))
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  "Więcej\nwyników",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
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
                              decoration: const BoxDecoration(
                                color: Color(0xFFDC143C),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 4.0,
                                      spreadRadius: 1,
                                      offset: Offset(0, 0))
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  "Zgłoś\nwynik",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
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
