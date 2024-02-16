
import 'package:flutter/material.dart';
import 'package:wellness/screens/welcome_screen.dart';
import 'package:wellness/widgets/profile.dart';

void main() => runApp(SettingsPage());

class User {
  final String name;
  final String profileImageUrl;

  User({required this.name, required this.profileImageUrl});
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: Theme(
        data: ThemeData(
          primarySwatch: Colors.red, // Change the primary color to red
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Settings'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(
                    context); // Navigate back when back button is pressed
              },
            ),
          ),
          body: SettingsBody(),
        ),
      ),
    );
  }
}

class SettingsBody extends StatefulWidget {
  @override
  _SettingsBodyState createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  late User _user;
  bool _isEditingProfile = false;

  @override
  void initState() {
    super.initState();
    _user = User(
      name: 'SM',
      profileImageUrl: 'assets/images/logo.png',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0), // Add space around the ListView
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isEditingProfile = !_isEditingProfile;
                    });
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(_user.profileImageUrl),
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isEditingProfile = !_isEditingProfile;
                    });
                  },
                  child: Text(
                    _user.name,
                    style: TextStyle(
                      color: _isEditingProfile ? Colors.red : null,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                  height: 10,
                ),
                _isEditingProfile
                    ? Icon(Icons.edit, color: Colors.red)
                    : SizedBox(),
              ],
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Profile'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {
              // Handle notifications tap
            },
          ),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Privacy'),
            onTap: () {
              // Handle privacy tap
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => WelPage()));
            },
          ),
        ],
      ),
    );
  }
}
