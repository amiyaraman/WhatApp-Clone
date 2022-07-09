import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueGrey,
          child:SvgPicture.asset("assets/groups.svg",color: Colors.white,
          height: 37,
          width: 37,),
          radius: 27,
        ),
        trailing: Text("18:04",style: TextStyle(
          color: Color.fromARGB(255, 120, 119, 119),
        ),),
        title: Text("9554567836",style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),),
        subtitle: Row(
          children: [
            Icon(Icons.done_all),
            SizedBox(
              width: 3,
            ),
           Expanded(child:  Text(
              "Hey!!I am not a developer.I am a student of rkgit gzb",
              maxLines: 1,
              overflow: TextOverflow.clip,
            )
            )
          ],
        ),
      ),
    );
  }
}