import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import '../../../constants.dart';
import '../../../models/message.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference me = FirebaseFirestore.instance.collection(kMessagesCollection);
  List<Message> messageList = [];
  void sendMassege({required String data, required var email}){
    try{
      print('successssssss');
      me.add({
        'body': data,
        'createdAt':DateTime.now(),
        'id': email,
      });
    }on Exception catch(e){}
  }

  void getMessage(){
    me.orderBy('createdAt',descending: true).snapshots().listen((event) {
      messageList.clear(); //to prevent getting all messages in collection when add  new message 'call this function'
        for(var doc in event.docs){
          messageList.add(Message.fromJson(doc));
        }
        emit(ChatSuccess(messageList: messageList));
    });
  }
}
