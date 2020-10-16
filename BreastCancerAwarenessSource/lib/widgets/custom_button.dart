import 'package:breastCancerAwareness/styles/styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String route;
  final String text;
  CustomButton({this.text, this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      width: double.infinity,
      child: OutlineButton(
        padding: EdgeInsets.all(10),
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
        shape: StadiumBorder(),
        highlightColor: Color(0xffEF81AE),
        highlightedBorderColor: Theme.of(context).primaryColor,
        textColor: Colors.black,
        disabledTextColor: Colors.black,
        child: Text(
          text,
          style: kButtonStyle,
          textAlign: TextAlign.center,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(route);
        },
      ),
    );
  }
}
