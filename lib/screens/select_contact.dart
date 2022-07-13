import 'package:flutter/material.dart';
import 'package:whatsappclone/customui/contact_card.dart';
import 'package:whatsappclone/screens/create_group.dart';

import '../customui/button_card.dart';
import '../model/chat_model.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({ Key? key }) : super(key: key);

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  List<ChatModel> contacts = [
      ChatModel("person1", "currentMessage part 1", "person.svg", false, "4:00",false),
    ChatModel("person2", "currentMessage part 2", "person.svg", false, "3:00",true),
    ChatModel("person3", "currentMessage part 3", "person.svg", false, "7:00",false),
    ChatModel("nperson4", "currentMessage part 4", "person.svg", false, "9:00",true),
    ChatModel("person5", "currentMessage part 5", "groups.svg", true, "19:00",false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Contact",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "256 contacts",
              style: TextStyle(
                fontSize: 13,
              ),
            )
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                size: 26,
              ),
              onPressed: () {}),
          PopupMenuButton<String>(
            padding: EdgeInsets.all(0),
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext contesxt) {
              return [
                PopupMenuItem(
                  child: Text("Invite a friend"),
                  value: "Invite a friend",
                ),
                PopupMenuItem(
                  child: Text("Contacts"),
                  value: "Contacts",
                ),
                PopupMenuItem(
                  child: Text("Refresh"),
                  value: "Refresh",
                ),
                PopupMenuItem(
                  child: Text("Help"),
                  value: "Help",
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length+2,
        itemBuilder: (context,index){
                        if (index == 0) {
              return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => CreateGroup()));
                },
                child: ButtonCard(
                  icon: Icons.group,
                  name: "New group",
                ),
              );
            } else if (index == 1) {
              return ButtonCard(
                icon: Icons.person_add,
                name: "New contact",
              );
            }
          
          return ContactCard(contacts[index-2]);

      }),
      
    );
  }
}