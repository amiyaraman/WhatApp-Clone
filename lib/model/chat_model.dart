class ChatModel{

  String name;
String icon;
bool isGroup;
  String time;
String currentMessage;
 late String status;
  late bool select = false;
  late int id;
  ChatModel({
    required this.name,
    required this.icon,
    required this.isGroup,
    required this.time,
    required this.currentMessage,
    required this.status,
    this.select = false,
    required this.id,
  }){


  }

 
}