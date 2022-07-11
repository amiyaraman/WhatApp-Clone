class ChatModel{

  String name;
String icon;
bool isGroup;
  String time;
String currentMessage;
 late String status;
  late bool select = false;
  late int id;
  ChatModel(this.name,this.currentMessage,this.icon,this.isGroup,this.time,this.select){
    this.status="THIS IS THE SAME STATUS FOR EVERY CONTACT";
    this.id=2313;


  }

 
}