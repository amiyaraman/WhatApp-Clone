import 'package:flutter/material.dart';
import 'package:whatsappclone/page/chat_page.dart';

class HomeScrenn extends StatefulWidget {
  const HomeScrenn({ Key? key }) : super(key: key);

  @override
  State<HomeScrenn> createState() => _HomeScrennState();
}

class _HomeScrennState extends State<HomeScrenn> with SingleTickerProviderStateMixin {
  late TabController _tabController ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this,initialIndex: 0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Whatsapp Clone"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search)),
          PopupMenuButton<String>(
            onSelected: (value){
              print(value);
            },
            itemBuilder: (BuildContext context){
            return [
              PopupMenuItem(child: Text("New group"),value: "New group",),
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
          }),
        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
      
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
              text: "Chats",
            ),
            Tab(
              text: "Status",
            ),
            Tab(
              text: "Calls",
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
         children: [
          Text("Camera"),
          ChatPage(),
          Text("Status"),
          Text("Calls"),
         ],
      ),

    );
  }
}