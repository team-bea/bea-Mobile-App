import 'dart:io';

import 'package:breastCancerAwareness/screens/translator_view_pager_screen.dart';
import 'package:breastCancerAwareness/services/connectivity_service.dart';
import 'package:breastCancerAwareness/styles/styles.dart';
import 'package:breastCancerAwareness/utilities/Constants.dart';
import 'package:breastCancerAwareness/utilities/Strings.dart';
import 'package:breastCancerAwareness/utilities/utility_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translator/translator.dart';

//This is the translator screen
//User can upload or take picture and translate it to the
class TranslatorScreen extends StatefulWidget {
  static const String routeName = "translatorScreenRoute";

  @override
  _TranslatorScreenState createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  CircularProgressIndicator _progressIndicator;
  File _pickedImage;
  List<String> _convertedLines = [];
  static const String _CAMERA = "CAMERA";
  static const String _GALLERY = "GALLERY";
  final picker = ImagePicker();
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  @override
  void dispose() {
    super.dispose();
    _isLoading = false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isLoading = false;
  }

  // method used to pickImage either from gallery or camera
  void _pickImage(String selectedOption) async {
    switch (selectedOption) {
      case _CAMERA:
        try {
          var tempFile = await picker.getImage(source: ImageSource.camera);

          _processTempFile(tempFile);
        } catch (e) {
          setState(() {
            _isLoading = false;
          });

          throw Exception(e);
        }
        break;
      case _GALLERY:
        try {
          var tempFile = await picker.getImage(source: ImageSource.gallery);
          _processTempFile(tempFile);
        } catch (e) {
          setState(() {
            _isLoading = false;
          });
          throw Exception(e);
        }
        break;
      default:
        break;
    }
  }

//Method to convert the temporary image to a File format

  void _processTempFile(PickedFile tempFile) {
    try {
      if (tempFile != null) {
        setState(() {
          _isLoading = true;
        });
        _pickedImage = File(tempFile.path);
        _readImage();
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } on Exception catch (e) {
      _isLoading = false;
      throw (e.toString());
    }
  }

//Method to recognize the text using the firebase ML Vision api
  void _readImage() async {
    try {
      FirebaseVisionImage fbImage = FirebaseVisionImage.fromFile(_pickedImage);
      TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
      VisionText readText = await textRecognizer.processImage(fbImage);
      final translator = GoogleTranslator();
      _convertedLines = [];
      for (TextBlock block in readText.blocks) {
        String text = "";

        for (TextLine line in block.lines) {
          text += line.text + '\n';
        }
        var translation =
            await translator.translate(text, to: context.locale.languageCode);
        _convertedLines.add(translation.toString());
      }

      // await translateText();
      _isLoading = false;
      Navigator.pushReplacementNamed(
          context, TranslatorViewPagerScreen.routeName, arguments: {
        kImageFile: _pickedImage,
        kScannedTextList: _convertedLines
      });
    } on Exception catch (e) {
      _isLoading = false;
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    _progressIndicator = CircularProgressIndicator(
      backgroundColor: Theme.of(context).accentColor,
      valueColor: new AlwaysStoppedAnimation<Color>(
          Theme.of(context).primaryColorLight),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          kAppName,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                    decoration: BoxDecoration(color: Color(0xffFFFEFE)),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0xffFFF6F7),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50))),
                      child: Container(),
                    )),
              ),
              Container(
                height: 100,
                decoration: BoxDecoration(color: Color(0xffFFF6F7)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(50)),
                      color: Color(0xffFFFEFE)),
                ),
              ),
            ],
          ),
          Center(
            child: _isLoading
                ? _progressIndicator
                : Container(
                    decoration: bgGradientDecoration,
                    padding: EdgeInsets.all(10),
                    child: Center(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 50,
                          width: 200,
                          child: Builder(
                            builder: (context) => buildOutlineButton(
                                context, "translate-doc".tr(), _GALLERY),
                          ),
                        ),
                        Builder(
                          builder: (context) => Container(
                            margin: EdgeInsets.all(10),
                            height: 50,
                            width: 200,
                            child: buildOutlineButton(
                                context, "take-picture".tr(), _CAMERA),
                          ),
                        ),
                      ],
                    )),
                  ),
          )
        ],
      ),
    );
  }

  OutlineButton buildOutlineButton(
      BuildContext context, String label, String action) {
    return OutlineButton(
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
      shape: StadiumBorder(),
      highlightColor: Color(0xffEF81AE),
      highlightedBorderColor: Theme.of(context).primaryColor,
      textColor: Colors.black,
      disabledTextColor: Colors.black,
      onPressed: () async {
        if (await ConnectivityService().isConnectedToNetwork()) {
          _pickImage(action);
        } else
          Utility.showSnackBar(context, "connect_internet".tr());
      },
      child: Text(
        label,
        style: kButtonStyle,
      ),
    );
  }
}
