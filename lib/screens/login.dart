import 'package:flutter/material.dart';
import 'package:wellness/screens/home_screen.dart'; // Import your home screen or any other screen you want to navigate to after login



class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 240, 67, 67),
            Color.fromARGB(255, 244, 167, 167), Color.fromARGB(255, 245, 246, 247)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ), // Set your desired bg
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/logo.png', // Replace with your app logo
              height: 180,
              width: 180,
            ),
            SizedBox(height: 20),
            TextField(
              style: TextStyle(color: Colors.black), // Set text color to white
              decoration: InputDecoration(
                hintText: 'Email Address',
                hintStyle: TextStyle(color: const Color.fromARGB(179, 42, 41, 41)), // Set hint text color
                prefixIcon: Icon(Icons.email, color: Colors.black), // Set icon color
                filled: true,
                fillColor: Colors.transparent, // Use transparent to make it look like the input is on the background
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              obscureText: true, // Use this for password fields
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(Icons.lock, color: Colors.black),
                filled: true,
                fillColor: Colors.transparent,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your login logic here
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text('Login', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 235, 43, 14), // Use transparent to make it look like the button is on the background
                elevation: 0, // Remove elevation
                
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.black),
                  
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
