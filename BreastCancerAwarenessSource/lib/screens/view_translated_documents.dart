import 'dart:io' as io;

import 'package:breastCancerAwareness/screens/pdf_viewer_widget.dart';
import 'package:breastCancerAwareness/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

//This screen is to view the list of translated documents
class ViewTranslatedDocumentList extends StatefulWidget {
  static const routeName = "viewTranslatedDocListRoute";
  @override
  _ViewTranslatedDocumentListState createState() =>
      _ViewTranslatedDocumentListState();
}

class _ViewTranslatedDocumentListState
    extends State<ViewTranslatedDocumentList> {
  List file = [];

  @override
  void initState() {
    super.initState();
    fetchDocsList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            padding: EdgeInsets.all(10),
            decoration: bgGradientDecoration,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "my-files".tr(),
                      style: largeTextStyle,
                    )),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(40)),
                    child: (file.length != 0)
                        ? ListView.builder(
                            itemBuilder: (ctx, i) {
                              return Container(
                                padding: EdgeInsets.only(
                                    bottom: 10, left: 5, top: 5, right: 5),
                                child: Column(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            PdfViewerPage.routeName,
                                            arguments: {"path": file[i].path});
                                      },
                                      title: Text(
                                        basename(file[i].path),
                                        style: kButtonStyle,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1,
                                      child: Divider(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            itemCount: file.length,
                          )
                        : Center(
                            child: Text(
                              "no_data".tr(),
                              style: buttonTextStyle,
                            ),
                          ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

//fetch the files from application directory with extension .pdf
  void fetchDocsList() async {
    String directoryPath = (await getApplicationDocumentsDirectory()).path;
    setState(() {
      List _file = io.Directory("$directoryPath/").listSync();
      _file.forEach((element) {
        if (element.toString().contains(".pdf")) file.add(element);
      });
    });
  }
}
