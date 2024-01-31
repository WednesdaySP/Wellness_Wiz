import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Welcome to the Health Care App!';
  List<String> userQueries = [];
  List<String> aiResponses = [];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          print('status: $status');
        },
        onError: (errorNotification) {
          print('error: $errorNotification');
        },
      );

      if (available) {
        _speech.listen(
          onResult: (result) {
            setState(() {
              _text = result.recognizedWords;
              userQueries.add(_text);
              // Call a function to get AI response for the user query
              aiResponses.add(getAIResponse(_text));
            });
          },
        );
      }
    } else {
      _speech.stop();
    }

    setState(() {
      _isListening = !_isListening;
    });
  }

  // Dummy function to simulate AI response based on user query
  String getAIResponse(String userQuery) {
    
    return 'AI Response for: $userQuery';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 240, 67, 67),
        
        title: Text('Sawsthya Sathi',style: TextStyle(
          fontSize: 20,fontWeight: FontWeight.w600
        ),),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
         
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              // gradient: LinearGradient(
              //   colors: [Colors.black, Colors.blue],
              //   begin: Alignment.centerLeft,
              //   end: Alignment.centerRight,
              // ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                
                
                prefixIcon: Icon(Icons.search, color: Colors.black),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      
      ),
      drawer: Drawer(
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < userQueries.length; i++)
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
                    color: Color.fromARGB(255, 240, 150, 150),
                    child: Text(
                      'User: ${userQueries[i]}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                for (int i = 0; i < aiResponses.length; i++)
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
                    color: Colors.black,
                    child: Text(
                      'AI: ${aiResponses[i]}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                SizedBox(height: 20),
                FloatingActionButton(
                  onPressed: _startListening,
                  backgroundColor: Colors.white,
                  child: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    color: Color.fromARGB(255, 243, 33, 33),
                    size: 40.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




