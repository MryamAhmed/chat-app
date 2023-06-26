import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
   TextForm({this.hint,this.onChange,this.type,this.obscureText = false,   }) ;

  String? hint;
  bool obscureText ;

  Function(String)?onChange;
  TextEditingController? controller;
      TextInputType?  type;

   //IconData suffix;
   //final Function suffixPressed;
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      obscureText:obscureText ,
      validator: (data){
        if(data!.isEmpty){
          return ' field is required';
        }
      },
      controller: controller,
      keyboardType:type,
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white),
        border:OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            )
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            )
        ),
      ),




    );
  }
}

class ButtonForm extends StatelessWidget {
   ButtonForm({required this.text,this.ontap}) ;
  String  text;
  VoidCallback?ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: Text(text)),
      ),
    );
  }
}
