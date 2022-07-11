import 'package:flutter/material.dart';
import 'package:whatsappclone/customui/custom_card.dart';
import 'package:whatsappclone/model/chat_model.dart';
import 'package:whatsappclone/screens/select_contact.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [
    ChatModel(
        "person1", "currentMessage part 1", "person.svg", false, "4:00", false),
    ChatModel(
        "person2", "currentMessage part 2", "person.svg", false, "3:00", true),
    ChatModel(
        "person3", "currentMessage part 3", "person.svg", false, "7:00", false),
    ChatModel(
        "nperson4", "currentMessage part 4", "person.svg", false, "9:00", true),
    ChatModel(
        "person5", "currentMessage part 5", "groups.svg", true, "19:00", false),
  ];
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
        itemCount: chats.length,
        itemBuilder: (context, index) {
          return CustomCard(chats[index]);
        },
      ),
    );
  }
}
