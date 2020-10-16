import 'package:breastCancerAwareness/screens/faq_screen.dart';
import 'package:breastCancerAwareness/styles/styles.dart';
import 'package:breastCancerAwareness/utilities/Strings.dart';
import 'package:breastCancerAwareness/widgets/slider_dot_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/*
* FAQ View Pager screen (sliding screen)
* */
class FAQPagerViewScreen extends StatefulWidget {
  static const String routeName = "FAQPageViewScreen";
  @override
  _FAQPagerViewScreenState createState() => _FAQPagerViewScreenState();
}

class _FAQPagerViewScreenState extends State<FAQPagerViewScreen> {
  var _faqList = {};
  int page;
  var _firstTime = true;
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    if (_firstTime) {
      page = args["page"];
      _faqList = args["map"];
      _firstTime = false;
    }
    final _controller = PageController(initialPage: page);
    final pageView = PageView(
      controller: _controller,
      onPageChanged: (value) {
        page = value;
        setState(() {});
      },
      children: <Widget>[
        FAQScreen(_faqList["general"], "general".tr()),
        FAQScreen(_faqList["diagnosis"], "diagnosis".tr()),
        FAQScreen(_faqList["treatment"], "treatment".tr()),
        FAQScreen(_faqList["followUp"], "follow-up".tr()),
      ],
    );

    setState(() {});
    return Scaffold(
        appBar: AppBar(title: Text(kAppName)),
        body: Column(
          children: [
            Expanded(
                child: Container(
              decoration: bgGradientDecoration,
              child: pageView,
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < 4; i++)
                  SliderDot(
                    isActive: (i == page),
                  )
              ],
            )
          ],
        ));
  }
}
