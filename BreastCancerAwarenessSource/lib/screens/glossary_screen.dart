import 'package:breastCancerAwareness/models/glossary.dart';
import 'package:breastCancerAwareness/screens/glossary_meaning_screen.dart';
import 'package:breastCancerAwareness/styles/styles.dart';
import 'package:breastCancerAwareness/utilities/Strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/*
* Glossary home screen
* */
class GlossaryScreen extends StatefulWidget {
  static const String routeName = "GlossaryRouteName";
  @override
  _GlossaryScreenState createState() => _GlossaryScreenState();
}

class _GlossaryScreenState extends State<GlossaryScreen> {
  List<Glossary> _glossaryList = List();

  Future<dynamic> _returnLocalList() async {
    return _filteredGlossary;
  }

  List<Glossary> _filteredGlossary = List();
  bool _firstTime = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kAppName),
      ),
      body: Column(
        children: [
          Container(
            child: Text(
              "glossary".tr(),
              style: largeTextStyle,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: TextField(
              cursorColor: Theme.of(context).primaryColor,
              style: kButtonStyle,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: "search".tr(),
                  focusColor: Theme.of(context).primaryColor,
                  hintStyle: buttonTextStyle,
                  labelStyle: buttonTextStyle),
              onChanged: (string) {
                setState(() {
                  if (string.isNotEmpty) {
                    _filteredGlossary = _glossaryList
                        .where((u) => (u.term
                                .toLowerCase()
                                .contains(string.toLowerCase()) ||
                            u.meaning
                                .toLowerCase()
                                .contains(string.toLowerCase())))
                        .toList();
                  } else {
                    _filteredGlossary = _glossaryList;
                  }
                });
              },
            ),
          ),
          FutureBuilder(
              future: (_glossaryList.length == 0)
                  ? parseJson(context.locale.languageCode)
                  : _returnLocalList(),
              builder: (ctx, snapshot) {
                if (snapshot.hasData) {
                  if (_firstTime) {
                    _glossaryList = snapshot.data;
                    _firstTime = false;
                    _filteredGlossary = _glossaryList;
                  }

                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      itemCount: _filteredGlossary.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Container(
                              width: 200,
                              child: OutlineButton(
                                padding: EdgeInsets.all(10),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      GlossaryMeaning.routeName,
                                      arguments: {
                                        "term": _filteredGlossary[index].term,
                                        "meaning":
                                            _filteredGlossary[index].meaning
                                      });
                                },
                                highlightColor: Color(0xffEF81AE),
                                highlightedBorderColor:
                                    Theme.of(context).primaryColor,
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                shape: StadiumBorder(),
                                textColor: Colors.black,
                                disabledTextColor: Colors.black,
                                child: Text(
                                  _filteredGlossary[index].term,
                                  textAlign: TextAlign.center,
                                  style: kButtonStyle,
                                ),
                              ),
                            ));
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      "no_data".tr(),
                      style: kButtonStyle,
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
