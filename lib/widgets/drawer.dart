import 'package:flutter/material.dart';

  Drawer DrawerScreen(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
          colors: [Color.fromARGB(255, 240, 67, 67),
          Color.fromARGB(255, 244, 167, 167), Color.fromARGB(255, 245, 246, 247)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ), 
            ),
            child: Text(
              'Swasthya Sathi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
              // Implement navigation to HomeScreen
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.pop(context);
            
            },
          ),
           ListTile(
            leading: Icon(Icons.settings),
            title: Text('Setting'),
            onTap: () {
              Navigator.pop(context);
              // Implement navigation to HomeScreen
            },
          ),
           ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            onTap: () {
              Navigator.pop(context);
              // Implement navigation to HomeScreen
            },
          ),
        ],
      ),
    );
  }
