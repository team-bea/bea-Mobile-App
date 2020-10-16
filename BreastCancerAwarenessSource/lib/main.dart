import 'package:breastCancerAwareness/screens/faq_home_screen.dart';
import 'package:breastCancerAwareness/screens/faq_pager_view_screen.dart';
import 'package:breastCancerAwareness/screens/glossary_meaning_screen.dart';
import 'package:breastCancerAwareness/screens/glossary_screen.dart';
import 'package:breastCancerAwareness/screens/home_screen.dart';
import 'package:breastCancerAwareness/screens/language_selection_screen.dart';
import 'package:breastCancerAwareness/screens/source_sites_screen.dart';
import 'package:breastCancerAwareness/screens/termsAndCondition_screen.dart';
import 'package:breastCancerAwareness/screens/translate_words_screen.dart';
import 'package:breastCancerAwareness/screens/view_translated_documents.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'screens/pdf_viewer_widget.dart';
import 'screens/splash_screen.dart';
import 'screens/translate_doc_screen.dart';
import 'screens/translator_view_pager_screen.dart';
import 'utilities/Strings.dart';

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

void main() => runApp(RestartWidget(
    child: EasyLocalization(
        path: 'assets/locales',
        supportedLocales: [
          Locale('en', 'US'),
          Locale('hi', 'IN'),
          Locale('fr', 'US'),
          Locale('es', 'ES')
        ],
        fallbackLocale: Locale('en', 'US'),
        child: MyApp())));

// This widget is the root of your application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) {
            return MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,

              title: kAppName,
              theme: ThemeData(
                  fontFamily: 'Alata',
                  primaryColor: Color(0xffEF81AE),
                  primaryColorLight: Colors.pink[300],
                  accentColor: Colors.pinkAccent[100],
                  textTheme: TextTheme(
                      // all headings
                      headline1:
                          TextStyle(color: Color(0xff4f4f4f), fontSize: 70),
                      headline4:
                          TextStyle(color: Color(0xff333333), fontSize: 30),
                      //button text
                      headline5:
                          TextStyle(color: Color(0xff333333), fontSize: 21),
                      //language screen sub title
                      caption:
                          TextStyle(color: Color(0xff333333), fontSize: 40),
                      headline6: TextStyle(color: Colors.black, fontSize: 18),
                      //bottom navigation text
                      subtitle1:
                          TextStyle(color: Color(0xff4F4F4F), fontSize: 14),
                      button: TextStyle(color: Colors.white, fontSize: 15))),
              home: SplashScreen(),
              // This is the start widget
              debugShowCheckedModeBanner: false,

              routes: {
                //This is the translated Docment View,( English / Selected Language) Screen
                TranslatorViewPagerScreen.routeName: (ctx) =>
                    TranslatorViewPagerScreen(),
                //Translator Screen
                TranslatorScreen.routeName: (ctx) => TranslatorScreen(),
                //This is the translated documents view screen
                ViewTranslatedDocumentList.routeName: (ctx) =>
                    ViewTranslatedDocumentList(),
                //This is the PDF Viewer screen
                PdfViewerPage.routeName: (ctx) => PdfViewerPage(),
                //This is the Language Selection screen
                LanguageSelectionScreen.routeName: (ctx) =>
                    LanguageSelectionScreen(),
                HomeScreen.routeName: (ctx) => HomeScreen(),
                GlossaryScreen.routeName: (ctx) => GlossaryScreen(),
                GlossaryMeaning.routeName: (ctx) => GlossaryMeaning(),
                TranslateQuestions.routeName: (ctx) => TranslateQuestions(),
                FAQHomeWidget.faqRouteName: (ctx) => FAQHomeWidget(),
                FAQPagerViewScreen.routeName: (ctx) => FAQPagerViewScreen(),
                TermsAndCondition.routeName: (ctx) => TermsAndCondition(),
                SourceSitesScreen.routeName: (ctx) => SourceSitesScreen()
              },
            );
          },
        ));
  }
}
