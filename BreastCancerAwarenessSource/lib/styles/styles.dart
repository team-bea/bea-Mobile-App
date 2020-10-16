import 'package:flutter/material.dart';

import 'appIcons.dart';

class Styles {
  //FFECF4, 100%
  static BoxDecoration containerBoxShadow() {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        color: Color(0xffEF81AE));
  }
}

const TextStyle kButtonStyle =
    TextStyle(color: Color(0xff333333), fontSize: 21);
const RoundedRectangleBorder kRoundedBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)));
const TextStyle largeTextStyle =
    TextStyle(color: Color(0xff4f4f4f), fontSize: 50, fontFamily: 'Alata');

const TextStyle buttonTextStyle =
    TextStyle(color: Color(0xff333333), fontSize: 21, fontFamily: 'Alata');

const TextStyle subtitleStyle =
    TextStyle(color: Color(0xff333333), fontSize: 30, fontFamily: 'Alata');

const TextStyle languageSubtitleStyle =
    TextStyle(color: Color(0xff333333), fontSize: 40, fontFamily: 'Alata');
const LinearGradient gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xffEF81AE),
      Color(0xFFFFECF4),
    ]);
BoxDecoration bgGradientDecoration = BoxDecoration(
    image: new DecorationImage(
  image: AssetImage(gradient_bg),
  fit: BoxFit.fill,
));
