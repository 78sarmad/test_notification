import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_notifications/constants.dart';
import 'package:http/http.dart' as http;
 class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(
        title: Center(child: Text("Notification Detail", style: TextStyle(color: Colors.white),)),
        backgroundColor: Colors.red,),
      body: Container(
         child: Center(
           child: Column(
            children: [ 
 

                  SizedBox(height: 30,),
                       StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection('client').snapshots(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }

    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }

    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return Text('No data available');
    }

    final clients = snapshot.data!.docs.reversed.toList();
    List<Widget> clientWidgets = [];

    for (var client in clients) {
      final clientWidget = GestureDetector(
        onTap: () {
        // press on blue container
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: 
           Container(
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(20.0),
  ),
  height: 100,
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        client['email'],
        style: TextStyle(
          color: Colors.white,
          overflow: TextOverflow.ellipsis, // Show ellipsis for overflow.
          //maxLines: 1, // Set maximum lines to 1.
        ),
        maxLines: 1,
      ),
      Text(
        client['name'],
        style: TextStyle(
          color: Colors.white,
          overflow: TextOverflow.ellipsis,
         // maxLines: 1,
        ),
        maxLines: 1,
      ),
      Container(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Detail Notification'),
                content: Container(
     
                  padding: EdgeInsets.all(8.0), 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text("Title,",style: TextStyle(color: Colors.red,),)),
                      Container(
     // ok for title
                        child: Text(
                          client['email'],
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18),
                         
                          
                        ),

                      ),
                      SizedBox(height: 5,),
                       Divider(
      height: 20, // Adjust the height of the line as needed
      thickness: 2, // Adjust the thickness of the line as needed
      color: Colors.black,
    ),
                      SizedBox(height: 5,),
                     Container(
                        child: Text("Body,",style: TextStyle(color: Colors.red,),)),
                      Text(
                        client['name'],
                        style: TextStyle(color: Colors.black),
                      
                      
                      ),
                    ],
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                         style: TextButton.styleFrom(
    primary: Colors.red, // Set the text color to red
  ),
                        child: Text('Cancel'),
                      ),
                      SizedBox(width: 8),
                      TextButton(
                        onPressed: () async {
                           Navigator.pop(context);

                            showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Send Notification Again'),
                        content: Text('Sure Send Notification Again '),
                        actions: [
                            TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                         style: TextButton.styleFrom(
    primary: Colors.red, // Set the text color to red
  ),
                        child: Text('Cancel'),
                      ),
                          TextButton(
                            
                            onPressed: () async {
                              Navigator.pop(context);

                                                    // Get FCM token for the device
      String deviceToken =
          await FirebaseMessaging.instance.getToken() ?? "";
      

      // Send FCM notification to the added client
      await pushNotificationsAllUsers(
        token: deviceToken, 
        
        title:  client['email'].toString()
        
        , body:  client['name'].toString(),
         
      );
                          

                        //  Navigator.pop(context);
                            },
                             style: TextButton.styleFrom(
    primary: Colors.red, // Set the text color to red
  ),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
      //                     // Get FCM token for the device
      // String deviceToken =
      //     await FirebaseMessaging.instance.getToken() ?? "";
      

      // // Send FCM notification to the added client
      // await pushNotificationsAllUsers(
      //   token: deviceToken, title: '', body: '',
         
      // );
                          

      //                     Navigator.pop(context);
                        },
                         style: TextButton.styleFrom(
    primary: Colors.red, // Set the text color to red
  ),
                        child: Text('Resend'),
                      ),
                    ],
                  ),
                ],
              ),
            );
            print("Show Detail button pressed!");
          },
          child: Text("Show Detail"),
        ),
      ),
    ],
  ),
),
 
        ),
      );
      clientWidgets.add(clientWidget);

      // for notificatin dialog detail show
     
    }

    return Expanded(
      child: ListView(
        children: clientWidgets,
      ),
    );
  },
) 
            ],
           ),
         ),
      ),
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
}