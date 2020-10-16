import 'package:flutter/material.dart';

class Utility {
  //method to show snack bar in any of the screen
  static void showSnackBar(BuildContext ctx, String message) {
    Scaffold.of(ctx).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
      backgroundColor: Theme.of(ctx).accentColor,
      behavior: SnackBarBehavior.fixed,
    ));
  }
}
