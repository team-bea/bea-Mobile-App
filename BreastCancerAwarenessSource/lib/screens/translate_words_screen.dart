import 'package:breastCancerAwareness/database/dbProvider.dart';
import 'package:breastCancerAwareness/database/queryDBRepository.dart';
import 'package:breastCancerAwareness/models/translateModel.dart';
import 'package:breastCancerAwareness/services/connectivity_service.dart';
import 'package:breastCancerAwareness/styles/styles.dart';
import 'package:breastCancerAwareness/utilities/Strings.dart';
import 'package:breastCancerAwareness/utilities/utility_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

/*
*
* Screen to translate the questions from the cureent language selection to English and save it in Sqlite
* */
class TranslateQuestions extends StatefulWidget {
  static const String routeName = "routeName";
  @override
  _TranslateQuestionsState createState() => _TranslateQuestionsState();
}

class _TranslateQuestionsState extends State<TranslateQuestions> {
  String _question = "";
  String _translatedQuestion = "";
  final _translator = GoogleTranslator();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(kAppName),
        ),
        body: Container(
            decoration: bgGradientDecoration,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    "my-questions".tr(),
                    style: largeTextStyle,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(30)),
                    child: TextField(
                      showCursor: true,
                      decoration: InputDecoration(
                          hintText: "enter_question".tr(),
                          focusColor: Theme.of(context).primaryColor,
                          hintStyle: buttonTextStyle,
                          labelStyle: buttonTextStyle),
                      style: kButtonStyle,
                      onSubmitted: (value) async {
                        _question = value;
                        await translateText();
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        _translatedQuestion,
                        style: kButtonStyle,
                      )),
                )
              ],
            )));
  }

//translate the user entered text to english
  Future<void> translateText() async {
    if (await ConnectivityService().isConnectedToNetwork()) {
      var _translation = await _translator.translate(_question, to: "en");
      var db = DatabaseProvider.get;
      QueryDBRepository repository =
          new QueryDBRepository(databaseProvider: db);

      repository.insert(new TranslateModel(
          id: 1,
          translateQuery: _question,
          translatedQuery: _translation.toString()));

      setState(() {
        _translatedQuestion = _translation.toString();
      });
    } else
      Utility.showSnackBar(context, "connect_internet".tr());
  }
}
