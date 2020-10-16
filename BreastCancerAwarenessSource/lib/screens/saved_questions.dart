import 'package:breastCancerAwareness/database/dbProvider.dart';
import 'package:breastCancerAwareness/database/queryDBRepository.dart';
import 'package:breastCancerAwareness/models/translateModel.dart';
import 'package:breastCancerAwareness/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/*
*
* Screen to view the saved questions (translated questions) in the local db
* */
class SavedQuestionsScreen extends StatefulWidget {
  @override
  _SavedQuestionsScreenState createState() => _SavedQuestionsScreenState();
}

class _SavedQuestionsScreenState extends State<SavedQuestionsScreen> {
  List<TranslateModel> listOfQueries = [];
  @override
  Widget build(BuildContext context) {
    var db = DatabaseProvider.get;
    QueryDBRepository repository = new QueryDBRepository(databaseProvider: db);

    return Scaffold(
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.all(10),
                decoration: bgGradientDecoration,
                child: Column(children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "saved-questions".tr(),
                        style: largeTextStyle,
                      )),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(5),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(40)),
                          child: FutureBuilder(
                            builder: (ctx, snapshot) {
                              if (snapshot.hasData) {
                                listOfQueries = snapshot.data;

                                if (listOfQueries.length != 0)
                                  return ListView.builder(
                                    itemBuilder: (ctx, i) {
                                      return Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "English: " +
                                                  listOfQueries[i]
                                                      .translatedQuery,
                                              style: buttonTextStyle.apply(
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            Text(
                                              listOfQueries[i].translateQuery,
                                              style: buttonTextStyle,
                                            ),
                                            Divider(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              height: 1,
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: listOfQueries.length,
                                  );
                                else {
                                  return Center(
                                      child: Container(
                                          child: Text(
                                    "no_data".tr(),
                                    style: buttonTextStyle,
                                  )));
                                }
                              } else
                                return Center(
                                    child: Container(
                                        child: Text(
                                  "no_data".tr(),
                                  style: buttonTextStyle,
                                )));
                            },
                            future: repository.getQueryList(),
                          )))
                ]))));
  }
}
