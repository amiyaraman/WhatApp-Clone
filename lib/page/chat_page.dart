import 'package:flutter/material.dart';
import 'package:whatsappclone/customui/custom_card.dart';
import 'package:whatsappclone/model/chat_model.dart';
import 'package:whatsappclone/screens/select_contact.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.chatmodels}) : super(key: key);
  final List<ChatModel> chatmodels;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectContact()));
        },
        child: Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: widget.chatmodels.length,
        itemBuilder: (context, index) {
          return CustomCard(widget.chatmodels[index]);
        },
      ),
    );
  }
}
