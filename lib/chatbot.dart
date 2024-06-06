import 'package:flutter/material.dart';


class ChatbotPage extends StatelessWidget {
  final Map<String, String> qaPairs = {
    "what is a legal consultation": "A legal consultation is a meeting between a lawyer and a client to discuss legal matters and potential courses of action.",
    "how much do you charge per hour?": "Our fees depend on the complexity of the case. We can discuss this further during a consultation.",
    "do you handle criminal cases?": "Yes, we handle a wide range of cases including criminal defense.",
    "what are your office hours?": "Our office hours are from 9 AM to 5 PM, Monday through Friday.",
    "hey": "Hello! How can I help you? \n"
        "1. What is a legal consultation\n"
        "2. How much do you charge per hour?\n"
        "3. what are your office hours? \n",
        "4.Do you handle criminal cases? \n"
    "What is a legal consultation": "A legal consultation is a meeting between a lawyer and a client to discuss legal matters and potential courses of action.",
    "How much do you charge per hour?": "Our fees depend on the complexity of the case. We can discuss this further during a consultation.",
    "Do you handle criminal cases?": "Yes, we handle a wide range of cases including criminal defense.",
    "What are your office hours?": "Our office hours are from 9 AM to 5 PM, Monday through Friday.",
    "Hey": "Hello! How can I help you? \n"
  "1. What is a legal consultation\n"
  "2. How much do you charge per hour?\n"
  "3. what are your office hours? \n",
    "2": "Our fees depend on the complexity of the case. We can discuss this further during a consultation.",
    "4": "Yes, we handle a wide range of cases including criminal defense.",
    "3": "Our office hours are from 9 AM to 5 PM, Monday through Friday.",
    "1": "A legal consultation is a meeting between a lawyer and a client to discuss legal matters and potential courses of action.",


  };

  MapEntry<String, String> findAnswer(String question) {
    var lowercaseQuestion = question.toLowerCase();
    var entry = qaPairs.entries.firstWhere(
          (entry) => entry.key.toLowerCase() == lowercaseQuestion,
      orElse: () => findSimilarAnswer(lowercaseQuestion),
    );
    return entry.value.isNotEmpty
        ? MapEntry(entry.key, entry.value)
        : MapEntry("No answer found", "I'm still learning, can you rephrase?");
  }

  MapEntry<String, String> findSimilarAnswer(String question) {
    // Implement fuzzy string matching logic here
    // This example uses a simple case-insensitive substring search
    for (var entry in qaPairs.entries) {
      if (entry.key.toLowerCase().contains(question)) {
        return MapEntry(entry.key, "Here's something related: ${entry.value}");
      }
    }
    return MapEntry("", "");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ChatBot',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.red),
          actionsIconTheme: IconThemeData(color: Colors.orange),
          actions: [],
          shape: Border(
            bottom: BorderSide(
              color: Colors.orange,
              width: 2.0,
            ),
          ),
        ),
        body: Chatbot(qaPairs: qaPairs),
      );
  }
}

class Chatbot extends StatefulWidget {
  final Map<String, String> qaPairs;

  const Chatbot({Key? key, required this.qaPairs}) : super(key: key);

  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final TextEditingController _controller = TextEditingController();
  final List<Widget> chatMessages = [];

  void _handleSendMessage() {
    setState(() {
      String question = _controller.text.trim();
      if (question.isNotEmpty) {
        chatMessages.add(MessageBubble(
          message: "You: $question",
          isUserMessage: true,
        ));
        _controller.clear();
        Future.delayed(Duration(seconds: 1), () {
          if (widget.qaPairs.containsKey(question)) {
            setState(() {
              chatMessages.add(MessageBubble(
                message: "Lawyer: ${widget.qaPairs[question]}",
                isUserMessage: false,
              ));
            });
          } else {
            setState(() {
              chatMessages.add(MessageBubble(
                message: "Lawyer: I'm sorry, I don't have an answer for that question.",
                isUserMessage: false,
              ));
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: chatMessages,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Type your question here...',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: _handleSendMessage,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isUserMessage;

  const MessageBubble({Key? key, required this.message, required this.isUserMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUserMessage ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isUserMessage ? Colors.blue : Colors.orange,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: isUserMessage ? Radius.circular(15) : Radius.circular(0),
            bottomRight: isUserMessage ? Radius.circular(0) : Radius.circular(15),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

