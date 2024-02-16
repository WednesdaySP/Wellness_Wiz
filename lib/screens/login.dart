import 'package:flutter/material.dart';
import 'package:wellness/screens/home_screen.dart';
import 'package:wellness/screens/onbording_screen.dart';
import 'package:wellness/screens/sign_up.dart';



class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() {
    String email = emailController.text;
    String password = passwordController.text;

    // Perform login logic here
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 240, 67, 67),
        title: const Text('Login'),
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 180,
                width: 180,
              ),
              SizedBox(height: 20),
              // TextField(
              //    controller: emailController,
              //   style: TextStyle(color: Colors.black), 
              //   decoration: InputDecoration(
              //     hintText: 'Email Address',
              //     hintStyle: TextStyle(color: const Color.fromARGB(179, 42, 41, 41)), // Set hint text color
              //     prefixIcon: Icon(Icons.email, color: Colors.black), // Set icon color
              //     filled: true,
              //     fillColor: Colors.transparent, 
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.black),
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.black),
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 10),

                            TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                   prefixIcon: Icon(Icons.email, color: Colors.black),
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                   prefixIcon: Icon(Icons.lock, color: Colors.black),
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              // TextField(
              //   controller: passwordController,
              //   obscureText: true, // Use this for password fields
              //   style: TextStyle(color: Colors.black),
              //   decoration: InputDecoration(
              //     hintText: 'Password',
              //     hintStyle: TextStyle(color: Colors.black),
              //     prefixIcon: Icon(Icons.lock, color: Colors.black),
              //     filled: true,
              //     fillColor: Colors.transparent,
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.black),
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.black),
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //   ),
              // ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: Text('Login'),
                
                // Text('Login', style: TextStyle(color: Colors.black)),
                // style: ElevatedButton.styleFrom(
                //   primary: Color.fromARGB(255, 235, 43, 14), 
                //   elevation: 0, // Remove elevation
                  
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(10.0),
                //     side: BorderSide(color: Colors.black),
                    
                //   ),
                // ),
              ),
        
               SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUpScreen()));
                  },
                  child: Text('Create an Account'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
