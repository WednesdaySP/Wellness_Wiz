import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:http/http.dart' as http;
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart'; // Google ML Kit for language identification

import 'package:translator/translator.dart';
import 'package:wellness/widgets/secrets.dart';

//  actual import for Firebase Firestore if needed
// import 'package:cloud_firestore/cloud_firestore.dart';

class OpenAIService {
  final List<Map<String, String>> messages = [];

  Future<String> isArtPromptAPI(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "user", "content": prompt}
          ]
        }),
      );
      print(res.body);
      if (res.statusCode == 200) {
        String content = jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        switch (content.toLowerCase()) {
          case 'yes':
            final res = await dallEAPI(prompt);
            return res;
          default:
            final res = await chatGPTAPI(prompt);
            return res;
        }
      }
      return 'An internal error occurred : ${res.reasonPhrase}';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGPTAPI(String prompt) async {
    messages.add({'role': 'user', 'content': prompt});

    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
        }),
      );

      if (res.statusCode == 200) {
        String content = jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        messages.add({'role': 'assistant', 'content': content});

        return content;
      }
      return 'An internal error occurred: ${res.reasonPhrase}';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> dallEAPI(String prompt) async {
    messages.add({'role': 'user', 'content': prompt});

    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/images/generations'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          'prompt': prompt,
          'n': 1,
        }),
      );

      if (res.statusCode == 200) {
        String imageUrl = jsonDecode(res.body)['data'][0]['url'];
        imageUrl = imageUrl.trim();

        messages.add({'role': 'assistant', 'content': imageUrl});

        return imageUrl;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }
}


class FeatureBox extends StatefulWidget {
  const FeatureBox({Key? key}) : super(key: key);

  @override
  State<FeatureBox> createState() => _FeatureBoxState();
}

class _FeatureBoxState extends State<FeatureBox> {
  final SpeechToText _speechToText = SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  String _lastWords = '';
  final OpenAIService _openAIService = OpenAIService();
  List<Map<String, String>> _chatMessages = [];
  final languageIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);

  @override
  void initState() {
    super.initState();
    _initSpeechToText();
    _initTextToSpeech();
  }

  Future<void> _initTextToSpeech() async {
    await _flutterTts.setSharedInstance(true);
  }

  Future<void> _initSpeechToText() async {
    await _speechToText.initialize();
  }

  Future<void> _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
  }

  Future<void> _stopListening() async {
    await _speechToText.stop();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  Future<void> _systemSpeak(String content, String languageCode) async {
    await _flutterTts.speak(content);
  }

  Future<void> _sendMessage(String message) async {
    // Add user message to chat
    _chatMessages.add({'role': 'user', 'content': message});

    // Generate response from the chatbot
    final response = await _generateResponse(message);

    // Add chatbot response to chat
    _chatMessages.add({'role': 'assistant', 'content': response});

    // Update UI
    setState(() {});
  }

  @override
  void dispose() {
    _speechToText.stop();
    _flutterTts.stop();
    super.dispose();
  }

  Future<String> _generateResponse(String text) async {
    // Code for generating response...
    try {
    final String languages = await languageIdentifier.identifyLanguage(text);
    final detectedLanguage = languages[0];
    
    if (detectedLanguage != 'en') {
      final translator = GoogleTranslator();
      try {
        text = (await translator.translate(text, to: 'en')).text!;
      } catch (e) {
        print('Translation failed: $e');
      }
    }

    final response = await _openAIService.isArtPromptAPI(text);

    if (detectedLanguage != 'en') {
      final translator = GoogleTranslator();
      try {
        final translatedResponse = await translator.translate(response, to: detectedLanguage);
         await _systemSpeak(translatedResponse.text!, detectedLanguage); // Speak out the translated response with the detected language
        return translatedResponse.text!;
      } catch (e) {
        print('Translation failed: $e');
      }
    }

     _systemSpeak(response, detectedLanguage); // Speak out the response
    return response;
  } catch (e) {
    print("Error generating response: $e");
    return "I'm sorry to hear that. Can you describe the headache? Is it a dull ache or a sharp pain? Have you experienced any other symptoms like nausea or sensitivity to light?";
  }
}

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chatbot"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 240, 67, 67),
              Color.fromARGB(255, 244, 167, 167),
              Color.fromARGB(255, 245, 246, 247),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _chatMessages.length,
                itemBuilder: (context, index) {
                  final message = _chatMessages[index];
                  return ListTile(
                    title: Text(
                      message['content'] ?? '',
                      style: TextStyle(color: message['role'] == 'assistant' ? Colors.white : Colors.black),
                    ),
                    tileColor: message['role'] == 'assistant' ? Colors.black : Colors.grey[300],
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    // You can customize the ListTile appearance as needed
                    // For example, you can use different colors or shapes for user and chatbot messages
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _lastWords = value;
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (_lastWords.isNotEmpty) {
                        await _sendMessage(_lastWords);
                      }
                    },
                    icon: Icon(Icons.send),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (await _speechToText.hasPermission && !_speechToText.isListening) {
                        await _startListening();
                      } else if (_speechToText.isListening) {
                        await _stopListening();
                        await _sendMessage(_lastWords);
                      } else {
                        _initSpeechToText();
                      }
                    },
                    icon: Icon(Icons.mic),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
