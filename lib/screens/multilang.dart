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
      return 'An internal error occurred';
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
      return 'An internal error occurred';
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
  String? _generateContent;
  String? _generateImageUrl;
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

  @override
  void dispose() {
    _speechToText.stop();
    _flutterTts.stop();
    super.dispose();
  }

  //ye code sirf text m output de rha h, voice kaam nhi kr rhi isme
Future<String> _generateResponse(String text) async {
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
    return "Sorry, I couldn't process your request at the moment.";
  }
}

  @override
  Widget build(BuildContext context) {
    final double wdth = MediaQuery.of(context).size.width;
    final double hgt = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chatbot"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        width: wdth,
        height: hgt,
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Visibility(
                visible: _generateContent == null,
                child: Container(
                  margin: EdgeInsets.only(top: 30, right: wdth * 0.1, left: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black54, Colors.black],
                    ),
                    borderRadius: BorderRadius.circular(30).copyWith(bottomLeft: Radius.circular(0)),
                  ),
                  child: Text(
                    'Hello, how can I help you?',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.only(top: 30, left: wdth * 0.1, right: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black54, Colors.black],
                    ),
                    borderRadius: BorderRadius.circular(30).copyWith(bottomRight: Radius.circular(0)),
                  ),
                  child: Text(
                    _lastWords,
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30, right: wdth * 0.1, left: 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black54, Colors.black],
                  ),
                  borderRadius: BorderRadius.circular(30).copyWith(bottomLeft: Radius.circular(0)),
                ),
                child: Text(
                  _generateContent ?? "",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        glowColor: Colors.red,
        glowRadiusFactor: 0.7,
        duration: Duration(milliseconds: 2000),
        repeat: true,
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () async {
            if (await _speechToText.hasPermission && !_speechToText.isListening) {
              await _startListening();
            } else if (_speechToText.isListening) {
              final response = await _generateResponse(_lastWords);
              setState(() {
                _generateContent = response;
              });
              await _stopListening();
            } 
            else {
              _initSpeechToText();
            }
          },
          child: Icon(
            Icons.mic,
            size: 30,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
