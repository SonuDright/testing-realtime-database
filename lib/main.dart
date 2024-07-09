import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'home_pagescreen.dart';
import 'image_picker/practics_imgpic.dart';



void main()async {
  WidgetsFlutterBinding.ensureInitialized();
   if(Firebase.apps.isEmpty){
     await Firebase.initializeApp(
       name: "flutter-projects-94ac5",
       options: DefaultFirebaseOptions.currentPlatform,
     );
   }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  HomeScreen(),
    );
  }
}

