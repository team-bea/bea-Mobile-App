import 'dart:io';

import 'package:breastCancerAwareness/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OriginalDocumentWidget extends StatelessWidget {
  final File _pickedImage;
  OriginalDocumentWidget(this._pickedImage);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "original-doc".tr(),
              style: kButtonStyle,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              height: double.maxFinite,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      image: FileImage(_pickedImage), fit: BoxFit.fill)),
            ),
          ),
        ],
      ),
    );
  }
}
