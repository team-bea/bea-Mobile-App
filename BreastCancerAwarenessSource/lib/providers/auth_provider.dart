import 'package:breastCancerAwareness/models/languages.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _userName = "";
  String _userEmail = "";
  String _userSelectedLanguageCode = "";
  bool _termsConditionsAccepted = false;

  get userName {
    return _userName;
  }

  get userEmail {
    return _userEmail;
  }

  get userSelectedLanguageCode {
    return _userSelectedLanguageCode;
  }

  get termsConditionsAccepted {
    return _termsConditionsAccepted;
  }

  Future<void> checkAuth() async {
    await checkForFirstTimeUser();
    return true;
  }

//method to check if the user is the first time user or not
  Future<void> checkForFirstTimeUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('username'))
        _userName = prefs.getString('username');
      if (prefs.containsKey('userEmail'))
        _userEmail = prefs.getString('userEmail');
      if (prefs.containsKey('userSelectedLanguage')) {
        _userSelectedLanguageCode = prefs.getString('userSelectedLanguage');
        print("userSelected Language " + _userSelectedLanguageCode);
      }
      if (prefs.containsKey('termsCondition')) {
        _termsConditionsAccepted = prefs.getBool('termsCondition');
      }
      notifyListeners();
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
    return true;
  }

//method to save user selected language code
  Future<void> selectLanguage(LanguageCode code) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("userSelectedLanguage", code.toString());
      _userSelectedLanguageCode = code.toString();

      notifyListeners();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //method to save the termsAndCondition
  Future<void> acceptTermsAndCondition(bool isAccepted) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("termsCondition", isAccepted);
      _termsConditionsAccepted = isAccepted;
      notifyListeners();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //method to save the userName and email
  Future<void> saveUserNameAndEmail(String username, String email) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("username", username);
      prefs.setString("userEmail", email);

      _userName = username;
      _userEmail = email;
      notifyListeners();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
