import 'package:chatapp/pages/chat.dart';
import 'package:chatapp/pages/login.dart';
import 'package:chatapp/pages/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(const Scolarship());
}
class Scolarship extends StatelessWidget {
  const Scolarship({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id :(context)=> LoginPage(),
        RegesrePage.id :(context)=> RegesrePage(),
        ChatPage.id :(context) => ChatPage(),
      },
      initialRoute:LoginPage.id,
    );
  }
}
