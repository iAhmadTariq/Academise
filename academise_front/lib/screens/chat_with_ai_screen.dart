import 'dart:convert';
import 'package:academise_front/utils/color.dart';
import 'package:academise_front/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatWithAI extends StatefulWidget {
  const ChatWithAI({Key? key}) : super(key: key);

  @override
  _ChatWithAIState createState() => _ChatWithAIState();
}

class _ChatWithAIState extends State<ChatWithAI> {
  final _controller = TextEditingController();
  final _messages = <String>[];

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
      borderRadius: const BorderRadius.all(Radius.circular(25)),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Chatbot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isCurrentUser = index % 2 == 0;
                return ChatBubble(
                  text: message,
                  isCurrentUser: isCurrentUser,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (String prompt) async {
                      await _sendMessage(prompt);
                    },
                    decoration: InputDecoration(
                      hintText: 'Ask the question',
                      border: inputBorder,
                      focusedBorder: inputBorder,
                      enabledBorder: inputBorder,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                    cursorColor: purpleColor,
                  ),
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  backgroundColor: purpleColor,
                  child: const Icon(Icons.send,color: Colors.white,),
                  onPressed: () async {
                    await _sendMessage(_controller.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage(String prompt) async {
    setState(() {
      _messages.add(prompt);
    });
    _controller.clear();
    try {
      final response = await fetchResponse(prompt);
      final responseJson = jsonDecode(response);
      setState(() {
        _messages.add(responseJson['response']);
      });
    } catch (e) {
      print('Error fetching response: $e');
    }
  }
}

Future<String> fetchResponse(String prompt) async {
  final response = await http.post(
    Uri.parse('http://10.7.93.182:5000/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(
        {'prompt': prompt}), // Add this line to send the request payload
  );

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to get response');
  }
}