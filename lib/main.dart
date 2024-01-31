import 'package:flutter/material.dart';
import 'package:wellness/screens/login.dart';
import 'dart:async';

import 'package:wellness/screens/onbording_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health Care App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // color: Colors.white
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 240, 67, 67),
            Color.fromARGB(255, 244, 167, 167), Color.fromARGB(255, 245, 246, 247)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png', // Replace with your app logo
                height: 200,
                width: 200,
              ),
              SizedBox(height: 20),
              Text(
                'Swasthya Sathi',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 14, 0, 0), // Adjust text color based on your design
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
