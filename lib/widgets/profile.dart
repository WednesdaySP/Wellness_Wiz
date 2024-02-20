import 'package:flutter/material.dart';

void main() => runApp(ProfilePage());

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: Text('Profile'),
            backgroundColor: Colors.red,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(
                    context); // Navigate back when back button is pressed
              },
            )),
        body: ProfileBody(),
      ),
    );
  }
}

class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = User(
      name: 'Swasthya Sathi',
      profileImageUrl: 'assets/images/logo.png',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 240, 67, 67),
              Color.fromARGB(255, 244, 167, 167), Color.fromARGB(255, 245, 246, 247)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ), 
          ),
         
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(_user.profileImageUrl),
              radius: 50,
            ),
            SizedBox(height: 20),
            Text(_user.name,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle edit profile
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Change the color of the button
              ),
              child: Text('Edit Profile', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}

class User {
  final String name;
  final String profileImageUrl;

  User({required this.name, required this.profileImageUrl});
}
