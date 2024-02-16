import 'package:flutter/material.dart';
import 'package:wellness/screens/article.dart';
import 'package:wellness/screens/login.dart';
import 'package:wellness/screens/splash.dart';
import 'dart:async';

import 'package:wellness/screens/welcome_screen.dart';
import 'package:wellness/widgets/doc_scan.dart';
import 'package:wellness/widgets/scheme.dart';





void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Swasthya Sathi',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen()
    );
  }
}
