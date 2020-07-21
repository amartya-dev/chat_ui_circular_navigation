import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:chat_ui/screens/home_screen.dart';
import 'package:chat_ui/screens/call_screen.dart';

class NavigatedScreensWidet extends StatefulWidget {
  NavigatedScreensWidet({Key key}) : super(key: key);

  @override
  _NavigatedScreensWidetState createState() => _NavigatedScreensWidetState();
}

class _NavigatedScreensWidetState extends State<NavigatedScreensWidet> {
  int selectedPos = 0;

  double bottomNavBarHeight = 60;

  List<TabItem> tabItems = List.of([
    new TabItem(Icons.chat, "Chat", Colors.red[900], labelStyle: TextStyle(fontWeight: FontWeight.normal)),
    new TabItem(Icons.call, "Call", Colors.black, labelStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
  ]);

  CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = new CircularBottomNavigationController(selectedPos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(child: bodyContainer(), padding: EdgeInsets.only(bottom: bottomNavBarHeight),),
          Align(alignment: Alignment.bottomCenter, child: bottomNav())
        ],
      ),
    );
  }

  Widget bodyContainer() {
    Widget selectedScreen;

    switch (selectedPos) {
      case 0:
        selectedScreen = HomeScreen();
        break;
      case 1:
        selectedScreen = CallScreen();
        break;
    }

    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: selectedScreen
      ),
      onTap: () {
        if (_navigationController.value == tabItems.length - 1) {
          _navigationController.value = 0;
        } else {
          _navigationController.value++;
        }
      },
    );
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      barHeight: bottomNavBarHeight,
      barBackgroundColor: Colors.white,
      animationDuration: Duration(milliseconds: 300),
      selectedCallback: (int selectedPos) {
        setState(() {
          this.selectedPos = selectedPos;
          print(_navigationController.value);
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }
}
