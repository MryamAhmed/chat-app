import 'package:chatapp/pages/cubts/regester_cubit/register_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import '../wedgets/text_form.dart';
import 'chat.dart';
import 'cubts/chat_cubit/chat_cubit.dart';


class RegesrePage extends StatelessWidget {
  static String id = 'Regester Page';
  String?email;
  String?password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit,RegisterState>(
      listener: (context,state){
        if(state is RegisterLoading){
          isLoading = true;
        }else if(state is RegisterSucces){
          BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.pushNamed(context, ChatPage.id);
          isLoading = false;
        }else if(state is RegisterFailure){
          showSnackBar(context, 'there was an error');
          isLoading = false;
        }
      },
      builder:(context,state)=>
          ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Scaffold(
              backgroundColor: kPrimaryColor,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Spacer(flex: 2,),
                      Image.asset(kPrimaryLogo),
                      const Text(
                        'ScholarShip',
                        style:
                        TextStyle(
                          fontSize: 32,
                          color:Colors.white,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                      const Spacer(flex: 1,),
                      Row(
                        children: const [
                          Text(
                            'REGESTER',
                            style:
                            TextStyle(
                              fontSize: 24,
                              color:Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15,),
                      TextForm(
                          hint:'Email',
                          type: TextInputType.emailAddress,
                          onChange: (data){email = data.toString();}
                      ),
                      const SizedBox(height: 10,),
                      TextForm(
                          obscureText: true,
                          hint:'Password',
                          type: TextInputType.emailAddress,
                          onChange: (data){password = data.toString();
                          }),
                      const SizedBox(height: 10,),
                      ButtonForm(
                          text: 'REGESTER',
                          ontap: ()async{
                            if(formKey.currentState!.validate()) {
                              BlocProvider.of<RegisterCubit>(context).
                              registerUser(email: email, password: password);
                            }else{}
                          }),

                      const SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('already have an acount?',
                            style: TextStyle(
                                color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: const Text(
                              ' Login',
                              style: TextStyle(
                                  color: Color(0xffC7EDE6)),),
                          )
                        ],
                      ),
                      const Spacer(flex: 3,)
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }

  void showSnackBar(BuildContext context,String mess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mess)),
    );
  }

  Future<void> registerUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
