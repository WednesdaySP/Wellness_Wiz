// import 'package:flutter/material.dart';
// import 'package:wellness/widgets/drawer.dart';
// import 'package:wellness/widgets/scheme.dart';
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 240, 67, 67),
        
//         title: Text('Sawsthya Sathi',style: TextStyle(
//           fontSize: 20,fontWeight: FontWeight.w600
//         ),),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.person),
//             onPressed: () {
         
//             },
//           ),
//         ],
//         // bottom: PreferredSize(
//         //   preferredSize: Size.fromHeight(60),
//         //   child: Container(
//         //     decoration: BoxDecoration(
//         //       color: Colors.white,
//         //       gradient: LinearGradient(
//         //         colors: [Colors.black, Colors.blue],
//         //         begin: Alignment.centerLeft,
//         //         end: Alignment.centerRight,
//         //       ),
//         //       borderRadius: BorderRadius.circular(10.0),
//         //     ),
//         //     margin: EdgeInsets.all(8.0),
//         //     child: TextFormField(
//         //       decoration: InputDecoration(
                
                
//         //         prefixIcon: Icon(Icons.search, color: Colors.black),
//         //         border: InputBorder.none,
//         //         contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
//         //         hintStyle: TextStyle(color: Colors.black),
//         //       ),
//         //     ),
//         //   ),
//         // ),
      
//       ),
//       drawer: DrawerScreen(context),
      // body: SingleChildScrollView(
      //   child: Container(
      //      decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //         colors: [Color.fromARGB(255, 240, 67, 67),
      //         Color.fromARGB(255, 244, 167, 167), Color.fromARGB(255, 245, 246, 247)],
      //         begin: Alignment.topCenter,
      //         end: Alignment.bottomCenter,
      //       ), 
      //     ),
      //     padding: const EdgeInsets.all(20.0),
      //     child: Column(
//             // crossAxisAlignment: CrossAxisAlignment.center,
//             // mainAxisAlignment: MainAxisAlignment.center,
//             children: [

//                SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed:(){
//                  Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => HomeScreen()));
//               },
//               child: Text('Chatbot'),
//             ),
//             ElevatedButton(
//               onPressed: (){
//                  Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => Scheme()));
//               },
//               child: Text('Scheme'),
//             ),
//             SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: (){
//                  Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => HomeScreen()));
//               },
//               child: Text('Doc Scanner'),
//             ),
//             ]
                                  
               
              
//             ),
//           ),
//         ),
//       );
    
//   }
// }


import 'package:flutter/material.dart';
import 'package:wellness/screens/location.dart';
import 'package:wellness/screens/multilang.dart';
import 'package:wellness/widgets/scheme.dart';

import 'package:wellness/widgets/settings.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  static List<Widget> widgetOptions = <Widget>[
    Text('Home'),
    Text('Govt Schemes'),
    Text('Location'),
    Text('Settings'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 240, 67, 67),
        title: Text('Swasthya Sathi'),
        automaticallyImplyLeading: true,
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
        
        
        
        
        
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/hm.png',
                  width: 500,
                  height: 450,
                ),
                // SizedBox(height: 20),
                // Center(
                //   child: Text(
                //     'Arogyam Sarveshaam Bhavantu, Swastyasathi Sarveshaam Bhavantu',
                //     style: TextStyle(fontSize: 15,),
                //   ),
                // ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                     Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => FeatureBox()));
                  },
                  child: Text('Your Swastya Sathi'),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 249, 204, 204),
        child: Row(
          
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            IconButton(
              icon: Icon(Icons.folder_open),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Scheme()));
              }
            ),
            IconButton(
              icon: Icon(Icons.location_pin),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Coming()));
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              },
            ),
          ],
        ),
     ),
);
}
}