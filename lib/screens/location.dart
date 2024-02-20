import 'package:flutter/material.dart';

void main() {
  runApp(Coming());
}

class Coming extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // This removes the debug banner
      home: ComingSoonPage(),
    );
  }
}

class ComingSoonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Color.fromARGB(255, 240, 67, 67),
        title: Text('Google Map'),
        centerTitle: true,
      ),
      body: Center(
        child: Image.asset(
          'assets/images/map.jpg',
          width: 900,
          height: 1500,
          fit: BoxFit.contain,
        ),
     ),
);
}
}