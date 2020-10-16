import 'package:flutter/material.dart';

class SliderDot extends StatelessWidget {
  bool isActive;
  SliderDot({this.isActive});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        child: CircleAvatar(
            radius: 3,
            backgroundColor:
                isActive ? Theme.of(context).primaryColor : Colors.grey,
            foregroundColor: Colors.grey));
  }
}
