import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsappclone/Screens/home_screen.dart';
import 'package:whatsappclone/screens/camera_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras=await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.openSans().fontFamily,
        colorScheme:ColorScheme(
           primary: Color(0xFF075E54),
           onPrimary: Colors.white,
           secondary: Color(0xFF128C7E),
           onSecondary: Colors.white, 
           brightness: Brightness.light,
           background: Colors.blue,
           onBackground: Color.fromARGB(255, 40, 93, 137),
           error: Colors.red,
           onError: Color.fromARGB(255, 158, 55, 47),
           onSurface: Colors.white,
           surface: Colors.yellow,

),
       
      ),
      debugShowCheckedModeBanner: false,
    home: HomeScrenn()
    
    );
  }
}
