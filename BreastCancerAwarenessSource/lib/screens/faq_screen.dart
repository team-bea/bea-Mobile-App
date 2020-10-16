import 'package:breastCancerAwareness/models/faqModel.dart';
import 'package:breastCancerAwareness/styles/styles.dart';
import 'package:flutter/material.dart';

/*
* FAQ question and answer screen
* */
class FAQScreen extends StatefulWidget {
  final List<FAQ> faqList;
  final title;
  static const String routeName = "FAQRouteName";
  FAQScreen(this.faqList, this.title);
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: Text(
          widget.title,
          style: largeTextStyle,
        ),
      ),
      Expanded(
        child: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: widget.faqList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Column(
                children: [
                  Text(
                    widget.faqList[index].question,
                    textAlign: TextAlign.center,
                    style: kButtonStyle,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border:
                            Border.all(color: Theme.of(context).primaryColor)),
                    child: Text(widget.faqList[index].answer),
                  )
                ],
              ),
            );
          },
        ),
      )
    ]);
  }
}
