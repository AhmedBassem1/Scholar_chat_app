import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholer_chat_app/wighets/constants.dart';

import '../wighets/custom_text_field.dart';

class SignUpPage extends StatefulWidget {
   SignUpPage({super.key});
   static String id = 'Sign up Page';
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {




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
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Image.asset('assets/images/scholar.png', height: 100,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Scholar Chat',style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'pacifico'),),
                  ],
                ),
                const SizedBox(
                  height: 75,
                ),
                const Text('SIGN UP',style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),),
                const SizedBox(height: 20,),
                CustomTextField(
                  onChange: (data){
                    email =data;
                  },
                  hintText: 'Email',),
                const SizedBox(height: 15,),
                CustomTextField(
                  onChange: (data){
                    password = data;
                  },
                  hintText: 'Password',),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: () async{
                    if (formKey.currentState!.validate()) {
                      isLoading =true;
                      setState(() {

                      });
                      try {
                        var auth = FirebaseAuth.instance;
                        UserCredential user= await  auth.createUserWithEmailAndPassword(email: email!, password: password!);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content:
                            Text('Success')));
                      } on FirebaseAuthException catch (e) {
                        if(e.code == 'weak-password'){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('The password provided is too weak.')));
                        }else if(e.code == 'email-already-in-use'){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('The password provided is too weak.')));
                        }
                      }catch(e){
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('There is error.')));
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
                    const Center(
                        child: Text('Sign Up',
                          style: TextStyle(
                              fontSize: 22
                          ),
                        )
                    ) ,
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account ? ', style: TextStyle(fontSize: 14, color: Colors.grey),),

                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: const Text(' LOGIN NOW !',style: TextStyle(fontSize: 14, color: Colors.white),))
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
