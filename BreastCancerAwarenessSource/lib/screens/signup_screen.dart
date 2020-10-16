import 'package:breastCancerAwareness/providers/auth_provider.dart';
import 'package:breastCancerAwareness/screens/termsAndCondition_screen.dart';
import 'package:breastCancerAwareness/styles/appIcons.dart';
import 'package:breastCancerAwareness/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
* Sign up screen to get the user name and email
* */
class SignUpScreen extends StatefulWidget {
  static const signupRoute = "SignUpRoute";
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Auth>(context, listen: false);

    TextEditingController _emailController = new TextEditingController();
    TextEditingController _usernameController = new TextEditingController();

    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: EdgeInsets.all(10),
      height: double.infinity,
      decoration: bgGradientDecoration,
      child: SingleChildScrollView(
          child: Column(
        children: [
          Text("login".tr() + "\n" + "sign-up".tr(), style: largeTextStyle),
          Container(
            margin: EdgeInsets.only(top: 45, bottom: 45),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border:
                          Border.all(color: Theme.of(context).primaryColor)),
                  child: TextField(
                    controller: _emailController,
                    cursorColor: Theme.of(context).primaryColor,
                    style: kButtonStyle,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                        hintText: "email".tr(),
                        focusColor: Theme.of(context).primaryColor,
                        hintStyle: buttonTextStyle,
                        labelStyle: buttonTextStyle),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border:
                          Border.all(color: Theme.of(context).primaryColor)),
                  child: TextField(
                    cursorColor: Theme.of(context).primaryColor,
                    style: kButtonStyle,
                    controller: _usernameController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                        hintText: "name".tr(),
                        focusColor: Theme.of(context).primaryColor,
                        hintStyle: buttonTextStyle,
                        labelStyle: buttonTextStyle),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(40),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                image: new DecorationImage(
              image: AssetImage(button_bg),
              fit: BoxFit.fill,
            )),
            child: MaterialButton(
              minWidth: double.infinity,
              onPressed: () async {
                String _name = _usernameController.text;
                String _email = _emailController.text;
                await auth.saveUserNameAndEmail(_name, _email);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => TermsAndCondition()),
                );
              },
              child: Text(
                "get_started".tr(),
                style: buttonTextStyle.apply(color: Colors.white),
              ),
            ),
          )
        ],
      )),
    )));
  }
}
