import 'package:breastCancerAwareness/screens/saved_questions.dart';
import 'package:breastCancerAwareness/screens/settings_screen.dart';
import 'package:breastCancerAwareness/screens/view_translated_documents.dart';
import 'package:breastCancerAwareness/styles/appIcons.dart';
import 'package:breastCancerAwareness/widgets/home_screen_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreenRoute";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Widget> _widgets = [
    HomeScreenWidget(),
    ViewTranslatedDocumentList(),
    SettingsScreen(),
    SavedQuestionsScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 20),
            ],
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
              ),
              child: BottomNavigationBar(
                  currentIndex: _selectedIndex,
                  onTap: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  backgroundColor: Colors.white,
                  selectedItemColor: Color(0xff333333),
                  unselectedItemColor: Colors.grey,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  selectedLabelStyle: TextStyle(
                      color: Color(0xff4F4F4F),
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                  unselectedLabelStyle: TextStyle(
                      color: Color(0xff4F4F4F),
                      fontWeight: FontWeight.normal,
                      fontSize: 14),
                  type: BottomNavigationBarType.shifting,
                  items: [
                    BottomNavigationBarItem(
                      label: "home".tr(),
                      icon: Icon(
                        Icons.home,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    BottomNavigationBarItem(
                        label: "my-files".tr(),
                        icon: Icon(
                          Icons.folder_open_rounded,
                          color: Theme.of(context).primaryColor,
                        )),
                    BottomNavigationBarItem(
                      label: "settings".tr(),
                      icon: Icon(
                        Icons.settings,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: "saved-questions".tr(),
                      icon: Image(
                        height: 21,
                        width: 21,
                        image: AssetImage(my_questions),
                      ),
                    ),
                  ]))),
      body: Container(child: _widgets[_selectedIndex]),
    );
  }
}
