import 'package:flutter/material.dart';
import 'package:test_notifications/Drawer_Page/hidden_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _chatUserListState();
}

class _chatUserListState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      
      debugShowCheckedModeBanner:false,
   home: HiddenDrawer(),
    theme:  ThemeData(primarySwatch: Colors.red),
    );
  }
}