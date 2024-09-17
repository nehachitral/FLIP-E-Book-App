import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  final String title;

  ChatPage({required this.title});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<Map<String, dynamic>> _messages = [
    {'sender': 'You', 'text': 'Hello!'},
    {'sender': 'Group Member', 'text': 'Hi there!'},
  ];

  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add({
          'sender': 'You',
          'text': _controller.text,
        });
      });

      // Save message to Firestore
      await _firestore
          .collection('chats')
          .doc(widget.title)
          .collection('messages')
          .add({
        'sender': 'You',
        'text': _controller.text,
        'time': DateTime.now(),
      });

      // Simulate automated reply after a short delay
      _simulateReply();
      _controller.clear(); // Clear input after sending
    }
  }

  void _simulateReply() {
    Future.delayed(Duration(seconds: 1), () {
      String reply;
      int userMessagesCount =
          _messages.where((msg) => msg['sender'] == 'You').length;

      if (userMessagesCount == 1) {
        reply = 'Hello!';
      } else if (userMessagesCount == 2) {
        reply = 'I’m doing great, how are you?';
      } else if (userMessagesCount == 3) {
        reply = 'Yes';
      } else {
        reply = 'This is an automated reply.';
      }

      setState(() {
        _messages.add({
          'sender': 'Group Member',
          'text': reply,
        });
      });

      // Save automated reply to Firestore
      _firestore
          .collection('chats')
          .doc(widget.title)
          .collection('messages')
          .add({
        'sender': 'Group Member',
        'text': reply,
        'time': DateTime.now(),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/avatar_placeholder.png'), // Placeholder image
            ),
            SizedBox(width: 10),
            Text(widget.title),
          ],
        ),
        backgroundColor: Colors.lightBlue, // Light blue color for the AppBar
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isMe = message['sender'] == 'You';
                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.lightBlue : Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(isMe ? 15 : 0),
                        bottomRight: Radius.circular(isMe ? 0 : 15),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message['text'],
                          style: TextStyle(
                            color: isMe ? Colors.white : Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '12:00 PM', // Placeholder for timestamp
                          style: TextStyle(
                            color: isMe ? Colors.white70 : Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border(
                top: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.add, color: Colors.lightBlue),
                  onPressed: () {
                    // Action to add images, etc.
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.lightBlue),
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
