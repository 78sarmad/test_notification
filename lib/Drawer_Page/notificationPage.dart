 

import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:test_notifications/constants.dart';
// import 'package:test_notifications/homepage.dart';
import 'package:test_notifications/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  late TextEditingController _textToken;
  late TextEditingController _textSetToken;
   
  final _textTitle = TextEditingController();
  final _textBody = TextEditingController();

  @override
  void dispose() {
    _textToken.dispose();
    _textTitle.dispose();
    _textBody.dispose();
    _textSetToken.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    _textToken = TextEditingController();
    _textSetToken = TextEditingController();
    
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification!.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                  channel.id, channel.name, channel.description,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher'),
            ));
      }
    });
  }


// final nameController = TextEditingController();
//   final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
     
      appBar: AppBar(
        backgroundColor: Colors.red,
       title: Center(child: Text('Send Notifications' , style: TextStyle(color: Colors.white),)),
      ),
      body: Padding(
        
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
             
              TextField(
                controller: _textTitle,
                decoration: InputDecoration(
                  labelText: "Enter Title",
                   focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red), // Set the underline color to red
    ),
    labelStyle: TextStyle(
      color: Colors.red, // Set the label text color to red
    ),
                  
                  ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _textBody,
                decoration: InputDecoration(labelText: "Enter Body",
                 focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red), // Set the underline color to red
    ),
    labelStyle: TextStyle(
      color: Colors.red, // Set the label text color to red
    ),
                ),
              ),
               
              SizedBox(height: 30),
              Row(
                children: [
                
                  SizedBox(width: 8),
                  Expanded(
                    child:

                    TextButton(
                      
  onPressed: () async {
    if (_textTitle.text.isEmpty || _textBody.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please enter something in both fields.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
               style: TextButton.styleFrom(
    primary: Colors.red, // Set the text color to red
  ),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Done'),
          content: Container(
            constraints: BoxConstraints(maxHeight: 200, maxWidth: 200), // Set your desired max height and width
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensure the column takes minimum space
              children: [
                Text('You send notification '),
                Text('& Your Data is store in History'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
               style: TextButton.styleFrom(
    primary: Colors.red, // Set the text color to red
  ),
              child: Text('OK'),
            ),
          ],
        ),
      );

      // Add client to Firestore
      CollectionReference collRef =
          FirebaseFirestore.instance.collection('client');
      await collRef.add({
        'email': _textTitle.text,
        'name': _textBody.text,
      });

      // Get FCM token for the device
      String deviceToken =
          await FirebaseMessaging.instance.getToken() ?? "";
      await showNotification;

      // Send FCM notification to the added client
      await pushNotificationsAllUsers(
        token: deviceToken,
        title: _textTitle.text,
        body: _textBody.text,
      );
      _textTitle.clear();
      _textBody.clear();
    }
  },
  child: Text('Send Notification and Add History',style: TextStyle(color: Colors.white),),
   style: ElevatedButton.styleFrom(
    primary: Colors.red, // Set the background color to red
  ),
)
 
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     FloatingActionButton(
      //       onPressed: showNotification,
      //       tooltip: 'Increment',
      //       child: Icon(Icons.add),
      //     ),
      //     SizedBox(
      //       width: 16,
      //     ),
      
      
      //   ],
      // ),
    );
  }
 
  Future<bool> pushNotificationsAllUsers({
    required String token,
    required String title,
    required String body,
  }) async {
    // FirebaseMessaging.instance.subscribeToTopic("myTopic1");

    String dataNotifications = '{ '
        ' "to" : "/topics/general" , '
        ' "notification" : {'
        ' "title":"$title" , '
        ' "body":"$body" '
        ' } '
        ' } ';

    var response = await http.post(
      Uri.parse(Constants.BASE_URL),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key= ${Constants.KEY_SERVER}',
      },
      body: dataNotifications,
    );
    print(response.body.toString());
    return true;
  }

  Future<String> token() async {
    return await FirebaseMessaging.instance.getToken() ?? "";
  }

  void showNotification() {
    // setState(() {
    //   _counter++;
    // });
    flutterLocalNotificationsPlugin.show(
        0,
        "Testing $_counter",
        "How you doin ?",
        NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id, channel.name, channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher'))
                );
  }

  bool check() {
    if (_textTitle.text.isNotEmpty && _textBody.text.isNotEmpty) {
      return true;
    }
    return false;
  }
}
 