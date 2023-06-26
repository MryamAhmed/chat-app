import 'package:chatapp/pages/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import '../wedgets/text_form.dart';
import 'chat.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  static String id = 'Login Page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String?email;

  String?password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
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
                      'Login',
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
                    type: TextInputType.emailAddress,onChange: (data){email = data.toString();}
                ),
                const SizedBox(height: 10,),
                TextForm(obscureText: true ,hint:'Password',type: TextInputType.emailAddress,onChange: (data){password = data.toString();}),
                const SizedBox(height: 10,),
                ButtonForm(
                    text: 'LOGIN',

                    ontap: ()async{
                      if(formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {

                        });
                        try {
                          await loginUser();
                          showSnackBar(context, 'success');

                          Navigator.pushNamed(context, ChatPage.id,arguments: email);

                        } on FirebaseAuthException catch (ex) {
                          if (ex.code == 'user-not-found') {
                            showSnackBar(context, 'user not found');

                          } else if (ex.code == 'wrong-password') {
                            showSnackBar(context, 'wrong password');

                          }
                        } catch (ex) {
                          showSnackBar(context, 'there was an error');
                        }

                        isLoading  = false;
                        setState(() {});

                      }else{}
                    }),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an acount?',
                      style: TextStyle(
                          color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context,RegesrePage.id);
                      },
                      child: const Text(
                        ' Regester',
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
    );
  }

  void showSnackBar(BuildContext context,String mess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mess)),
    );
  }

  Future<void> loginUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
