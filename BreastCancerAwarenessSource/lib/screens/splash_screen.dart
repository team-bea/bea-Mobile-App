import 'package:breastCancerAwareness/providers/auth_provider.dart';
import 'package:breastCancerAwareness/screens/home_screen.dart';
import 'package:breastCancerAwareness/screens/language_selection_screen.dart';
import 'package:breastCancerAwareness/screens/signup_screen.dart';
import 'package:breastCancerAwareness/screens/termsAndCondition_screen.dart';
import 'package:breastCancerAwareness/styles/appIcons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//This is the splash screen. It is shown for 5 seconds and the app navigates to the home Screen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> _setTimerForSplashScreen() async {
    await Future.delayed(Duration(milliseconds: 3000));
    return true;
  }

//navigate to home screen or language selection screen based on the condition isFirstTime
  void _navigateToHomeScreen() async {
    await auth.checkForFirstTimeUser();

    if (auth.userSelectedLanguageCode.isEmpty) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => LanguageSelectionScreen()));
    } else if (auth.userName.toString().isEmpty) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => SignUpScreen()));
    } else if (!auth.termsConditionsAccepted) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => TermsAndCondition()));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    _setTimerForSplashScreen().then((result) {
      if (result) _navigateToHomeScreen();
    });
  }

  Auth auth;
  @override
  Widget build(BuildContext context) {
    auth = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(
            image: new DecorationImage(
          image: AssetImage(splash_bg),
          fit: BoxFit.fill,
        )),
      ),
    );
  }
}
