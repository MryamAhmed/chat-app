import 'package:chatapp/models/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class chatBuble extends StatelessWidget {
  const chatBuble({Key? key,required this.me}) : super(key: key);

  final Message me; //هتستقبل مي

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 32,top: 32,bottom: 32),
          decoration:  const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(32),
                bottomRight: Radius.circular(32),
                topLeft: Radius.circular(32)
            ),
          ),
          child:  Text(
            me.body,
            style:
            TextStyle(
                color: Colors.white)
            ,),
        ),
      ),
    );
  }
}


class friendChatBuble extends StatelessWidget {
  const friendChatBuble({Key? key,required this.me}) : super(key: key);

  final Message me; //هتستقبل مي

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 32,top: 32,bottom: 32),
          decoration:  const BoxDecoration(
            color: Color(0xff006D84),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(32),
                bottomLeft: Radius.circular(32),
                topLeft: Radius.circular(32)
            ),
          ),
          child:  Text(
            me.body,
            style:
            TextStyle(
                color: Colors.white)
            ,),
        ),
      ),
    );
  }
}
