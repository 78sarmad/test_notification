 
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:test_notifications/Drawer_Page/history.dart';
 import 'package:test_notifications/Drawer_Page/notificationPage.dart';
import 'package:test_notifications/loginpage.dart';


class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({Key? key}) : super(key: key);

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {

  List<ScreenHiddenDrawer> _pages = [];
  final myTextStyle =  TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.white,
          
       );

  @override
  void initState() {
    super.initState();
    _pages = [
      
    ScreenHiddenDrawer(
      
      ItemHiddenMenu(
        
        name: "History",
       baseStyle:  myTextStyle,
        selectedStyle: TextStyle(), 
        colorLineSelected: Colors.white
        ),

      HistoryPage(),
      ),
      
         ScreenHiddenDrawer(
      ItemHiddenMenu(
        name: "Notification",
       baseStyle:  myTextStyle,
        selectedStyle: TextStyle(), 
        colorLineSelected: Colors.white
        ),

      MyHomePage(),
      ),
    
          ScreenHiddenDrawer(
      ItemHiddenMenu(
        name: "Log Out",
      baseStyle:  myTextStyle,
        selectedStyle: TextStyle(), 
        colorLineSelected: Colors.white,
        onTap: (){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
        }
        ),
        Icon(Icons.logout)
     
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return   HiddenDrawerMenu(

      backgroundColorMenu: Colors.red,
      screens: _pages,
      initPositionSelected: 0,
      slidePercent: 45,
      contentCornerRadius: 100,
    );
  }
 
}

