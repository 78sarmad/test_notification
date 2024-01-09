import 'package:flutter/material.dart';
import 'package:test_notifications/Drawer_Page/homescreen.dart';
 

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(child: Text('Login Screen',style: TextStyle(color: Colors.white),)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
        
              // Positioned.fill(
              //   left: 0,
              //   bottom: 0,
              //   child: Align(
              //     alignment: Alignment.center,
              //     child: Image.asset("assets/images/loveimage.jpeg"),
              //   ),
              // ),
                  
                 Image.asset("assets/images/loveimage.jpeg"),



              SizedBox(height: 10,),
              TextField(
  controller: _usernameController,
  decoration: InputDecoration(
    labelText: 'Username',
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red), // Set the underline color to red
    ),
    labelStyle: TextStyle(
      color: Colors.red, // Set the label text color to red
    ),
  ),
),

              SizedBox(height: 16.0),
                      TextField(
                        obscureText: true,
  controller: _passwordController,
  decoration: InputDecoration(
    labelText: 'Password',
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red), // Set the underline color to red
    ),
    labelStyle: TextStyle(
      color: Colors.red, // Set the label text color to red
    ),
  ),
),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
            primary: Colors.red, // Set the background color to red
          ),
                onPressed: () {
                  if (_usernameController.text == 'admin' &&
                      _passwordController.text == 'admin') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => 
                     HomeScreen()
                    //  MyHomePage()
                      ),
                    );
                  } else {
                    // Show an error message or handle invalid login
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Invalid Credentials'),
                        content: Text('Please enter valid username and password.'),
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
                  }
                },
                
                child: Text('Login',
                style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 