import 'dart:io';

import 'package:breastCancerAwareness/styles/styles.dart';
import 'package:breastCancerAwareness/utilities/save_pdf.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TranslatedDocumentWidget extends StatefulWidget {
  final List<String> _scannedText;
  TranslatedDocumentWidget(this._scannedText);

  @override
  _TranslatedDocumentWidgetState createState() =>
      _TranslatedDocumentWidgetState();
}

class _TranslatedDocumentWidgetState extends State<TranslatedDocumentWidget> {
  File _imageFile;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "translated_document".tr(),
              style: kButtonStyle,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(5)),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),
                  child: _imageFile != null
                      ? Image.file(_imageFile)
                      : ListView.builder(
                          itemBuilder: (context, i) {
                            return Text(widget._scannedText[i]);
                          },
                          itemCount: widget._scannedText.length,
                        ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                      color: Theme.of(context).primaryColorLight,
                      icon: Icon(Icons.download_outlined),
                      onPressed: () async {
                        await report(context, widget._scannedText);
                        Navigator.of(context).pop();
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
