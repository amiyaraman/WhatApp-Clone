import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsappclone/model/chat_model.dart';

class IndividualPage extends StatefulWidget {
  IndividualPage({required this.chat, Key? key}) : super(key: key);
  ChatModel chat;

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 95,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)),
            GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                child: SvgPicture.asset(
                  "assets/" + widget.chat.icon,
                  color: Colors.white,
                  height: 36,
                  width: 36,
                ),
                radius: 20,
                backgroundColor: Colors.blueGrey,
              ),
            ),
          ],
        ),
        title: InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chat.name,
                  style: TextStyle(
                    fontSize: 18.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Last seen today or never",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
          IconButton(onPressed: () {}, icon: Icon(Icons.call)),
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text("New group"),
                  value: "New group",
                ),
                PopupMenuItem(
                  child: Text("New broadcast"),
                  value: "New broadcast",
                ),
                PopupMenuItem(
                  child: Text("Whatsapp Web"),
                  value: "Whatsapp Web",
                ),
                PopupMenuItem(
                  child: Text("Starred Message"),
                  value: "Starred Message",
                ),
                PopupMenuItem(
                  child: Text("Settings"),
                  value: "Settings",
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            ListView(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 55,
                    child: Card(
                      margin: EdgeInsets.only(
                        left: 2,
                        right: 2,
                        bottom: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 5,
                        minLines: 1,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type a message",
                            prefixIcon: IconButton(
                              icon: Icon(Icons.emoji_emotions),
                              onPressed: () {},
                            ),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.attach_file)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.camera_alt)),
                              ],
                            ),
                            contentPadding: EdgeInsets.all(5)),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                        right: 2,
                        left: 1,
                        bottom: 8,
                      ),
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF128C7F),
                        radius: 25,
                        child:
                            IconButton(icon: Icon(Icons.mic,color: Colors.white,), onPressed: () {}),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
