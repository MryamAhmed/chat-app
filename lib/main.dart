import 'package:chatapp/pages/chat.dart';
import 'package:chatapp/pages/cubts/chat_cubit/chat_cubit.dart';
import 'package:chatapp/pages/cubts/login_cubit/login_cubit.dart';
import 'package:chatapp/pages/cubts/regester_cubit/register_cubit.dart';
import 'package:chatapp/pages/login.dart';
import 'package:chatapp/pages/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> LoginCubit()),
        BlocProvider(create: (context)=>RegisterCubit()),
        BlocProvider(create: (context)=> ChatCubit())
      ],
      child: MaterialApp(
        routes: {
          LoginPage.id :(context)=> LoginPage(),
          RegesrePage.id :(context)=> RegesrePage(),
          ChatPage.id :(context) => ChatPage(),
        },
        initialRoute:LoginPage.id,
      ),
    );
  }
}
