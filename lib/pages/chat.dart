import 'package:chatapp/models/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';
import '../wedgets/chat_buble.dart';

class ChatPage extends StatelessWidget {
  static String id = 'Chat Page';
  //FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference x = FirebaseFirestore.instance.collection(kMessagesCollection);

  TextEditingController controller=TextEditingController();
  ScrollController ListController = ScrollController();
  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;

    return StreamBuilder<QuerySnapshot>(
      stream: x.orderBy('createdAt',descending: true).snapshots(),
      builder:( context,  snapshot) {
          if(snapshot.hasData){
            List<Message> messageList =[];
            for(int i=0; i < snapshot.data!.docs.length; i++){
              messageList.add(Message.fromJson(snapshot.data!.docs[i])); // the data is message model
            }
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
                        child: ListView.builder(
                          reverse: true,
                          controller: ListController,
                            itemCount: messageList.length,
                            itemBuilder: (context,index){
                              return  messageList[index].id == email ?
                              chatBuble(me: messageList[index],)
                                  :friendChatBuble(me: messageList[index]);
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          controller: controller,
                          onSubmitted: (data){
                            x.add({
                              'body': data,
                              'createdAt':DateTime.now(),
                              'id': email,
                            });
                            print(data);
                            controller.clear();
                            ListController.animateTo(
                              //ListController.position.maxScrollExtent,
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
          }else{
            return Text('error');
          }


          },
    );
  }
}