import 'package:flutter/material.dart';
import 'package:test_notifications/loginpage.dart';


class SplashScreen extends StatefulWidget {
  // const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      
      // bool isOnboardingVisited = false;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) =>
           
                LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Image.asset("assets/images/heartiamge.jpeg"),
              ),
              const Spacer(flex: 1),
              Image.asset("assets/images/loveimage.jpeg"),
              const Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}
