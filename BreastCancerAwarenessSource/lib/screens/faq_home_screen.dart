import 'package:breastCancerAwareness/models/faqModel.dart';
import 'package:breastCancerAwareness/screens/faq_pager_view_screen.dart';
import 'package:breastCancerAwareness/screens/source_sites_screen.dart';
import 'package:breastCancerAwareness/styles/styles.dart';
import 'package:breastCancerAwareness/utilities/Strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

var _faqList = {};

/*
* FAQ Screen
* */
class FAQHomeWidget extends StatefulWidget {
  static const String faqRouteName = "faqRouteName";
  @override
  _FAQHomeWidgetState createState() => _FAQHomeWidgetState();
}

class _FAQHomeWidgetState extends State<FAQHomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kAppName),
      ),
      body: Container(
        decoration: bgGradientDecoration,
        child: FutureBuilder(
          builder: (ctx, snapShot) {
            if (snapShot.hasData) {
              _faqList = snapShot.data;
              return Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "know-more".tr(),
                        style: largeTextStyle,
                      ),
                    ),
                    buildOutlineButton(context, "general".tr(), 0),
                    buildOutlineButton(context, "diagnosis".tr(), 1),
                    buildOutlineButton(context, "treatment".tr(), 2),
                    buildOutlineButton(context, "follow-up".tr(), 3),
                    Container(
                        margin: EdgeInsets.only(left: 40, right: 40, top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: gradient,
                        ),
                        child: MaterialButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(SourceSitesScreen.routeName);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "source".tr(),
                                  style: buttonTextStyle.apply(
                                      color: Colors.white),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: Colors.white,
                                )
                              ],
                            )))
                  ],
                ),
              );
            } else {
              return Center(child: Text("no_data".tr()));
            }
          },
          future: parseJson(context.locale.languageCode),
        ),
      ),
    );
  }
}

Container buildOutlineButton(BuildContext context, String label, int action) {
  return Container(
    padding: EdgeInsets.all(10),
    width: double.infinity,
    child: OutlineButton(
      padding: EdgeInsets.all(10),
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
      shape: StadiumBorder(),
      highlightColor: Color(0xffEF81AE),
      highlightedBorderColor: Theme.of(context).primaryColor,
      textColor: Colors.black,
      disabledTextColor: Colors.black,
      onPressed: () {
        Navigator.of(context).pushNamed(FAQPagerViewScreen.routeName,
            arguments: {"map": _faqList, "page": action});
      },
      child: Text(
        label,
        style: kButtonStyle,
      ),
    ),
  );
}
