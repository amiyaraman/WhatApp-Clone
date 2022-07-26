import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsappclone/model/chat_model.dart';
import 'package:whatsappclone/page/chat_page.dart';
import 'package:whatsappclone/screens/individual_page.dart';

class CustomCard extends StatelessWidget {
  CustomCard(this.chat, {Key? key, required this.sourchat}) : super(key: key);
  ChatModel chat;
  ChatModel sourchat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IndividualPage(chat: chat,sourchat: sourchat,)));
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueGrey,
          child: SvgPicture.asset(
            "assets/" + chat.icon,
            color: Colors.white,
            height: 37,
            width: 37,
          ),
          radius: 27,
        ),
        trailing: Text(
          chat.time,
          style: TextStyle(
            color: Color.fromARGB(255, 120, 119, 119),
          ),
        ),
        title: Text(
          chat.name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Row(
          children: [
            Icon(Icons.done_all),
            SizedBox(
              width: 3,
            ),
            Expanded(
                child: Text(
              chat.currentMessage,
              maxLines: 1,
              overflow: TextOverflow.clip,
            ))
          ],
        ),
      ),
    );
  }
}
