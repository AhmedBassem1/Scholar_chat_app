import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholer_chat_app/pages/chat_page.dart';
import 'package:scholer_chat_app/pages/sign_up_page.dart';
import 'package:scholer_chat_app/wighets/constants.dart';
import 'package:scholer_chat_app/wighets/custom_text_field.dart';

class SignInPage extends StatefulWidget {
   SignInPage({super.key});

   static String id = 'Sign In';
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {



   String? email;

   String? password;

   bool isLoading= false;

  GlobalKey<FormState> formKey= GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: formKey ,
            child: ListView(
              children: [
                SizedBox(
                  height: 75,
                ),
                Image.asset('assets/images/scholar.png', height: 100,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Scholar Chat',style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'pacifico'),),
                  ],
                ),
                SizedBox(
                  height: 75,
                ),
                Text('SIGN IN',style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),),
                SizedBox(height: 20,),
                CustomTextField(
                  onChange: (data){
                    email =data;
                  },
                  hintText: 'Email',),
                SizedBox(height: 15,),
                CustomTextField(
                     onChange:  (data){
                    password =data;
                  },
                  hintText: 'Password',),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading =true;
                      setState(() {

                      });
                      try {
                        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email!,
                            password: password!,
                        );
                        isLoading = false;
                        setState(() {});
                        Navigator.pushNamed(context, ChatPage.id,arguments: email);
                      } on FirebaseAuthException catch (e) {
                        isLoading = false;
                        setState(() {});
                        if (e.code == 'user-not-found') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No user found for that email.')));
                        } else if (e.code == 'wrong-password') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wrong password provided for that user.')));
                        }else {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text('Error: ${e.code}')),
                          // );
                        }
                      }
                      isLoading=false;
                      setState(() {

                      });
                    }else{}
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,

                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child:
                    Center(
                        child: Text('Sign In',
                          style: TextStyle(
                              fontSize: 22
                          ),
                        )
                    ) ,
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account ? ', style: TextStyle(fontSize: 14, color: Colors.grey),),

                    GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, SignUpPage.id);
                        },
                        child: Text(' Register Now !',style: TextStyle(fontSize: 14, color: Colors.white),))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
