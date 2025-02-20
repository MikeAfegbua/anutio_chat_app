import 'package:anutio_chat_app/components/message_sending_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String messageText;

  final messageTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;

        if (kDebugMode) {
          print(loggedInUser.email);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _firestore
                    .collection('messages')
                    .orderBy('date', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }

                  final messages = snapshot.data?.docs.reversed ?? [];
                  List<MessageBubbleWidget> messageWidgets = [];

                  for (var message in messages) {
                    final messageText = message['text'];
                    final messageSender = message['sender'];

                    final currentUser = loggedInUser.email;
                    final messageBubble = MessageBubbleWidget(
                      text: messageText,
                      sender: messageSender,
                      isMe: currentUser == messageSender,
                    );
                    messageWidgets.add(messageBubble);
                  }

                  return Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10,
                      ),
                      children: messageWidgets,
                    ),
                  );
                },
              ),
              MessageSendingWidget(
                messageTextController: messageTextController,
                onTapSend: () {
                  messageTextController.clear();
                  _firestore.collection('messages').add(
                    {
                      'text': messageText,
                      'sender': loggedInUser.email,
                      'date': FieldValue.serverTimestamp(),
                    },
                  );
                },
                onChanged: (value) {
                  messageText = value;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageBubbleWidget extends StatelessWidget {
  const MessageBubbleWidget({
    required this.text,
    required this.sender,
    required this.isMe,
    super.key,
  });
  final String text;
  final String sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender, //' $sender ${DateTime.fromMillisecondsSinceEpoch(time.seconds * 1000)}',
            style: const TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.only(
              topLeft:
                  isMe ? const Radius.circular(30.0) : const Radius.circular(0),
              topRight:
                  isMe ? const Radius.circular(0) : const Radius.circular(30.0),
              bottomLeft: const Radius.circular(30.0),
              bottomRight: const Radius.circular(30.0),
            ),
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
