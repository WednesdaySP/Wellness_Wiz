import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wellness/screens/home_screen.dart';
import 'package:wellness/screens/login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController LnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    fnameController.dispose();
    LnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login(
    String fname,
    String Lname,
    String email,
    String password,
  ) async {
    String fname = fnameController.text;
    String Lname = LnameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    try {
      final response = await post(
        Uri.parse('http://ankursingh.xyz/api/registerUser.php'),
        body: {
          "fname": fname,
          "Lname": Lname,
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body.toString());
        print(data);
        print('Login successfully');
        // Navigate to another screen upon successful login
        // Example: Navigator.push(...)
      } else {
        print('Login failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 240, 67, 67),
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Container(
           decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 240, 67, 67),
              Color.fromARGB(255, 244, 167, 167), Color.fromARGB(255, 245, 246, 247)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ), 
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png', // Replace with your image path
                height: 200, // Adjust height as needed
                width: 200, // Adjust width as needed
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: fnameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: LnameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // login(
                  //   fnameController.text.toString(),
                  //   LnameController.text.toString(),
                  //   emailController.text.toString(),
                  //   passwordController.text.toString(),
                  // );
        
                   Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                },
                child: Text('Create Your Account'),
              ),
              SizedBox(height: 10), // Added SizedBox for spacing
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
