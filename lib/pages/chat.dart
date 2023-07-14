import 'package:chatapp/pages/cubts/chat_cubit/chat_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';
import '../models/message.dart';
import '../wedgets/chat_buble.dart';

class ChatPage extends StatelessWidget {
  static String id = 'Chat Page';
  TextEditingController controller=TextEditingController();
  ScrollController ListController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments ;
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                title: (
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                            kPrimaryLogo,
                            height: 50
                        ),
                        Text('chat'),
                      ],
                    )),
              ),

              body: Column(
                  children:[
                    Expanded(
                      child: BlocBuilder<ChatCubit,ChatState>(
                        builder: (context,state) {
                          List<Message> messagesList = BlocProvider.of<ChatCubit>(context).messageList;
                          return ListView.builder(
                              reverse: true,
                              controller: ListController,
                              itemCount: messagesList.length,
                              itemBuilder: (context,index){
                                return  messagesList[index].id == email ?
                                chatBuble(me: messagesList[index],)
                                    :friendChatBuble(me: messagesList[index]);
                              });
                        }
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: controller,
                        onSubmitted: (data){
                          BlocProvider.of<ChatCubit>(context).sendMassege(data:data,email:email);
                          controller.clear();
                          ListController.animateTo(
                            0,
                            duration: Duration(microseconds: 500),
                            curve: Curves.fastOutSlowIn,
                          );
                        },
                        decoration: InputDecoration(
                            hintText: 'Message',
                            suffixIcon: Icon(Icons.send,color: kPrimaryColor,),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                    color: kPrimaryColor
                                )
                            )
                        ),
                      ),
                    )
                  ]
              )
          );
        }
      }