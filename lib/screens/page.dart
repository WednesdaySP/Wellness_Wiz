import 'package:flutter/material.dart';

void main() => runApp(HealthcareChatbotApp());

class HealthcareChatbotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthcare Chatbot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Example accent color
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  void _handleSubmitted(String text) {
    setState(() {
      _messages.add(text);
    });
    _controller.clear();
    // Perform logic to handle the user input and generate a response from the chatbot
    // This could involve calling an API or using a chatbot library
    // For simplicity, we are just echoing the user's message for demonstration purposes
    _handleBotResponse(text);
  }

  void _handleBotResponse(String userMessage) {
    // Perform logic to generate a response from the chatbot
    // For demonstration purposes, we are just echoing the user's message
    String botResponse = "Bot: You said '$userMessage'";
    setState(() {
      _messages.add(botResponse);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Healthcare Chatbot'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(
        color: Theme.of(context)
            .primaryColor, // Fallback to black if accentColor is null
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _controller,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(
                  hintText: "Send a message",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => _handleSubmitted(_controller.text),
              ),
            ),
          ],
        ),
     ),
);
}
}
