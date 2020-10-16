import 'package:breastCancerAwareness/styles/styles.dart';
import 'package:breastCancerAwareness/utilities/Strings.dart';
import 'package:breastCancerAwareness/widgets/slider_dot_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/*
* Screen to view the source websites
* */
class SourceSitesScreen extends StatefulWidget {
  static const String routeName = "SourceSiteScreenRoute";
  @override
  _SourceSitesScreenState createState() => _SourceSitesScreenState();
}

class _SourceSitesScreenState extends State<SourceSitesScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    final pageView = PageView(
      controller: _controller,
      onPageChanged: (value) {
        _page = value;
        setState(() {});
      },
      children: [
        SourceSiteViewPagerWidget(
          page: 0,
        ),
        SourceSiteViewPagerWidget(
          page: 1,
        )
      ],
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(kAppName),
        ),
        body: Container(
            decoration: bgGradientDecoration,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    "Resources / Ressources\nRecursos / साधन",
                    style: subtitleStyle,
                  ),
                ),
                Expanded(child: pageView),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < 2; i++)
                      SliderDot(
                        isActive: (i == _page),
                      )
                  ],
                )
              ],
            )));
  }
}

class SourceSiteViewPagerWidget extends StatelessWidget {
  Map<int, List<String>> sitesMap = {
    3: ["Hindi / हिंदी", "http://cancerindia.org.in/hindi/breast-cancer/"],
    0: [
      "English",
      "www.breastcancer.org/",
      "www5.komen.org/",
      "www.cancer.org/cancer/breast-cancer.html",
      "www.cancer.net/cancer-types/breast-cancer"
    ],
    1: [
      "Spanish / Español",
      "www.breastcancer.org/es",
      "www.cancer.org/es/cancer/cancer-de-seno/acerca/que-es-el-cancer-de-seno.html",
      "www.cancer.net/es/tipos-de-c%C3%A1ncer/cancer-de-mama"
    ],
    2: [
      "French / Français",
      "www.fondation-arc.org/cancer/cancer-sein",
      "www.e-cancer.fr/Patients-et-proches/Les-cancers/Cancer-du-sein/Les-points-cles"
    ]
  };

  final int page;
  SourceSiteViewPagerWidget({this.page});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
            flex: 2,
            child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(30)),
                child: buildListView(page))),
        Expanded(
          flex: 2,
          child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(30)),
              child: buildListView(page + 2)),
        )
      ],
    ));
  }

  ListView buildListView(int pageIndex) {
    return ListView.builder(
      itemBuilder: (ctx, position) {
        if (position == 0) {
          return Text(
            sitesMap[pageIndex][position],
            style: buttonTextStyle,
          );
        } else {
          return InkWell(
              onTap: () {
                _launchURL(sitesMap[pageIndex][position]);
              },
              child: Container(
                  child: Text(
                sitesMap[pageIndex][position],
                style: buttonTextStyle.apply(
                    fontSizeFactor: 0.85,
                    color: Theme.of(ctx).primaryColor,
                    decoration: TextDecoration.underline),
              )));
        }
      },
      itemCount: sitesMap[pageIndex].length,
    );
  }

  _launchURL(String url) async {
    if (!url.contains("http")) url = "https://" + url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
