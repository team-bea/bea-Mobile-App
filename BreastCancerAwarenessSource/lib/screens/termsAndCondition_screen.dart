import 'package:breastCancerAwareness/providers/auth_provider.dart';
import 'package:breastCancerAwareness/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

/*
* terms and conditions screen
* */
class TermsAndCondition extends StatefulWidget {
  static const String routeName = "TermsRoueName";
  @override
  _TermsAndConditionState createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  var isAccepted = false;
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
        body: SafeArea(
      child: Container(
          padding: EdgeInsets.all(10),
          height: double.infinity,
          decoration: bgGradientDecoration,
          child: Column(
            children: [
              Text("t-c".tr(), style: largeTextStyle),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: Theme.of(context).primaryColor)),
                      child: ListView(
                        children: [
                          Text(
                            "terms_and_condition".tr(),
                            style: buttonTextStyle,
                          ),
                        ],
                      ))),
              Container(
                  margin: EdgeInsets.only(top: 15, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Checkbox(
                        activeColor: Theme.of(context).primaryColor,
                        focusColor: Theme.of(context).accentColor,
                        value: isAccepted,
                        onChanged: (value) async {
                          isAccepted = value;
                          print(isAccepted);

                          setState(() {});
                          await auth.acceptTermsAndCondition(value);
                          Navigator.of(context)
                              .pushReplacementNamed(HomeScreen.routeName);
                        },
                      ),
                      Container(
                          child: Text(
                        "agree".tr(),
                        softWrap: true,
                        style: buttonTextStyle,
                      ))
                    ],
                  ))
            ],
          )),
    ));
  }
}
