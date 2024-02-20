// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:speech_to_text/speech_to_text.dart' as stt;



// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final stt.SpeechToText _speech = stt.SpeechToText();
//   TextEditingController _controller = TextEditingController();
//   List<String> _messages = [];

//   @override
//   void initState() {
//     super.initState();
//     _speech.initialize(
//       onError: (error) => print('Error: $error'),
//     );
//   }

//   void _startListening() async {
//     if (await _speech.initialize()) {
//       _speech.listen(
//         onResult: (result) {
//           setState(() {
//             _controller.text = result.recognizedWords;
//           });
//         },
//       );
//     }
//   }

//   void _stopListening() {
//     _speech.stop();
//   }

//   void _sendMessage() async {
//     if (_controller.text.isEmpty) return;

//     setState(() {
//       _messages.add('User: ${_controller.text}');
//     });

//     final response = await http.post(
//       Uri.parse('http://your_backend_api_url/api/chatbot'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'message': _controller.text}),
//     );

//     if (response.statusCode == 200) {
//       final responseData = jsonDecode(response.body);
//       setState(() {
//         _messages.add('Chatbot: ${responseData['response']}');
//       });
//     } else {
//       setState(() {
//         _messages.add('Error: Failed to communicate with the chatbot.');
//       });
//     }

//     _controller.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('COPD Voice Chatbot'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: ListView.builder(
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(_messages[index]),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: <Widget>[
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(
//                       hintText: 'Type a message or tap the mic button to speak...',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.mic),
//                   onPressed: _startListening,
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.stop),
//                   onPressed: _stopListening,
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: _sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//      ),
// );
// }
// }


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:wellness/widgets/secrets.dart';




class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  TextEditingController _controller = TextEditingController();
  List<String> _messages = [];

  @override
  void initState() {
    super.initState();
    _speech.initialize(
      onError: (error) => print('Error: $error'),
    );
  }

  void _startListening() async {
    if (await _speech.initialize()) {
      _speech.listen(
        onResult: (result) {
          setState(() {
            _controller.text = result.recognizedWords;
          });
        },
      );
    }
  }

  void _stopListening() {
    _speech.stop();
  }

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;

    setState(() {
      _messages.add('User: ${_controller.text}');
    });

    final response = await http.post(
      Uri.parse('http://localhost:8080'), // Your API endpoint here
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $openAIAPIKey'}, // Your API headers here
      body: jsonEncode({'message': _controller.text}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      setState(() {
        _messages.add('Chatbot: ${responseData['response']}');
      });
    } else {
      setState(() {
        _messages.add('Error: Failed to communicate with the chatbot.');
      });
    }

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COPD Voice Chatbot'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message or tap the mic button to speak...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: _startListening,
                ),
                IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: _stopListening,
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
