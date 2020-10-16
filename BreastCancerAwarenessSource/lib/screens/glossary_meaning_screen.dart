import 'package:breastCancerAwareness/models/glossary.dart';
import 'package:breastCancerAwareness/styles/styles.dart';
import 'package:breastCancerAwareness/utilities/Strings.dart';
import 'package:flutter/material.dart';

/*
*  Screen showing the term and meaning
* */
class GlossaryMeaning extends StatefulWidget {
  static const String routeName = "glossaryMeaningroute";

  @override
  _GlossaryMeaningState createState() => _GlossaryMeaningState();
}

class _GlossaryMeaningState extends State<GlossaryMeaning> {
  Glossary _glossary = Glossary();
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;

    _glossary.term = args["term"];
    _glossary.meaning = args["meaning"];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(kAppName),
        ),
        body: Container(
          height: double.infinity,
          margin: EdgeInsets.all(10),
          decoration: bgGradientDecoration,
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(_glossary.term, style: largeTextStyle),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor)),
                    child: Text(_glossary.meaning, style: buttonTextStyle)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
