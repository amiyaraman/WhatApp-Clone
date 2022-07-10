import 'package:flutter/material.dart';
import 'package:whatsappclone/customui/custom_card.dart';
import 'package:whatsappclone/model/chat_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [
    ChatModel("person1", "currentMessage part 1", "person.svg", false, "4:00"),
    ChatModel("person2", "currentMessage part 2", "person.svg", false, "3:00"),
    ChatModel("person3", "currentMessage part 3", "person.svg", false, "7:00"),
    ChatModel("nperson4", "currentMessage part 4", "person.svg", false, "9:00"),
    ChatModel("person5", "currentMessage part 5", "groups.svg", true, "19:00"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
