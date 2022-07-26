import 'dart:convert';
import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsappclone/customui/own_message_card.dart';
import 'package:whatsappclone/customui/reply_card.dart';
import 'package:whatsappclone/model/chat_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:whatsappclone/model/message_model.dart';

class IndividualPage extends StatefulWidget {
  IndividualPage({required this.chat, Key? key, required this.sourchat})
      : super(key: key);
  ChatModel chat;
  ChatModel sourchat;
 

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool showEmoji = false;
  FocusNode focusNode = FocusNode();
  late IO.Socket socket;
  bool sendbutton = false;
  List<MessageModel> messages = [];
  

  ScrollController _scrollController = ScrollController();
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showEmoji = false;
        });
      }
    });
     connect();
  }

  void connect() {
  //  print("here one part");
    socket = IO.io("http://192.168.0.104:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false
    });
    if (!socket.connected) {
      socket.connect();
      socket.onConnect((data) {
        socket.emit("signin", widget.sourchat.id);
      });
    } else if (socket.connected) {
      //do someting if the connection is already established
       
    }
      socket.on("message", (msg) {
        print(msg);
        setMessage("destination", msg["message"]);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);

      });

    //print(socket.connected);
  }
  void sendMessage(String message , int sourceId , int targetId){
       setMessage("source", message);
    socket.emit("message",{
      "message":message,
      "sourceId":sourceId,
      "targetId":targetId
    });
  }
    void setMessage(String type, String message) {
      
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16));
    print(messages);

    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //socket.disconnect();
    // socket.dispose();
  }

  @override
  Widget build(BuildContext context) {
   // connect();
    return Stack(children: [
      Image.network(
        "https://res.cloudinary.com/practicaldev/image/fetch/s--WAKqnINn--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://thepracticaldev.s3.amazonaws.com/i/tw0nawnvo0zpgm5nx4fp.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
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
          child: WillPopScope(
            onWillPop: () {
              if (showEmoji == true) {
                setState(() {
                  showEmoji = false;
                });
              } else {
                Navigator.pop(context);
              }
              return Future.value(false);
            },
            child: Column(
              children: [
                Expanded(
                 // height: MediaQuery.of(context).size.height - 140,
                  child: ListView.builder(
                  
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount:  messages.length + 1 ,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Container(
                            height: 70,
                          );
                        }
                        if (messages[index].type == "source") {
                          return OwnMessageCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        } else {
                          return ReplyCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        }
                      },
                    ),
                  ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 70,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
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
                                    controller: _controller,
                                    focusNode: focusNode,
                                    keyboardType: TextInputType.multiline,
                                    textAlignVertical: TextAlignVertical.center,
                                    maxLines: 5,
                                    onChanged: (value) {
                                      if (value.length > 0) {
                                        setState(() {
                                          sendbutton = true;
                                        });
                                      } else {
                                        setState(() {
                                          sendbutton = false;
                                        });
                                      }
                                    },
                                    minLines: 1,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Type a message",
                                        prefixIcon: IconButton(
                                          icon: Icon(Icons.emoji_emotions),
                                          onPressed: () {
                                            setState(() {
                                              focusNode.unfocus();
                                              focusNode.canRequestFocus = false;
                                              showEmoji = !showEmoji;
                                            });
                                          },
                                        ),
                                        suffixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      context: context,
                                                      builder: (builder) =>
                                                          bottomSheet());
                                                },
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
                                    child: IconButton(
                                        icon: Icon(
                                          sendbutton ? Icons.send : Icons.mic,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          if(sendbutton){
                                            _scrollController.animateTo(_scrollController.position.maxScrollExtent,duration: Duration(milliseconds: 500),curve: Curves.easeOut);
                                            sendMessage(_controller.text, widget.sourchat.id, widget.chat.id);
                                             setState(() {
                                              _controller.clear();
                                              sendbutton=false;
                                            });
                                          }
                                        }),
                                  ))
                            ],
                          ),
                          showEmoji ? emojiSelect() : Container(),
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  Widget bottomSheet() {
    return Container(
      height: 268,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.insert_drive_file, Colors.indigo, "Document"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.location_pin, Colors.teal, "Location"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.person, Colors.blue, "Contact"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icons, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              // semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }

  Widget emojiSelect() {
    return Container(
      //width: 100,
      height: MediaQuery.of(context).size.height / 3,
      child: EmojiPicker(
        onEmojiSelected: (emoji, category) {
          setState(() {
            _controller.text = _controller.text + category.emoji;
          });
          // print(emoji);
        },
        config: Config(
          columns: 7,
        ),
      ),
    );
  }
}
