import 'package:breastCancerAwareness/providers/auth_provider.dart';
import 'package:breastCancerAwareness/screens/faq_home_screen.dart';
import 'package:breastCancerAwareness/screens/glossary_screen.dart';
import 'package:breastCancerAwareness/screens/translate_doc_screen.dart';
import 'package:breastCancerAwareness/screens/translate_words_screen.dart';
import 'package:breastCancerAwareness/styles/appIcons.dart';
import 'package:breastCancerAwareness/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_button.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({
    Key key,
  }) : super(key: key);

  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  Auth auth;
  @override
  Widget build(BuildContext context) {
    auth = Provider.of<Auth>(context, listen: false);
    return Container(
        decoration: bgGradientDecoration,
        padding: EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                "hello-name".tr() + " " + auth.userName,
                style: largeTextStyle,
                textAlign: TextAlign.right,
              ),
              Text("today".tr(),
                  textAlign: TextAlign.right, style: subtitleStyle),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 300,
                    width: 100,
                    alignment: Alignment.bottomCenter,
                    child: Image(
                      fit: BoxFit.contain,
                      image: AssetImage(avatarHome),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomButton(
                              text: "translate-doc".tr(),
                              route: TranslatorScreen.routeName,
                            ),
                            CustomButton(
                              text: "to-glossary".tr(),
                              route: GlossaryScreen.routeName,
                            ),
                            CustomButton(
                              text: "my-questions".tr(),
                              route: TranslateQuestions.routeName,
                            ),
                            CustomButton(
                              text: "know-more".tr(),
                              route: FAQHomeWidget.faqRouteName,
                            )
                          ],
                        ),
                      ))
                ],
              )
            ]));
  }
}
