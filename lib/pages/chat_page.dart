import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scholer_chat_app/models/massages_model.dart';
import 'package:scholer_chat_app/wighets/chat_buble.dart';
import 'package:scholer_chat_app/wighets/chat_buble_for_friend.dart';
import 'package:scholer_chat_app/wighets/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
    ChatPage({super.key});
static String id = 'Chat Page';
TextEditingController controller =TextEditingController();
    CollectionReference massages = FirebaseFirestore.instance.collection('massages');
    final ScrollController _controller = ScrollController();

    void _scrollDown() {
      _controller.animateTo(
        0,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
  @override
  Widget build(BuildContext context) {
    String email =ModalRoute.of(context)!.settings.arguments as String;

    return StreamBuilder<QuerySnapshot>(
        stream: massages.orderBy('createdAt',descending: true).snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            List<MassagesModel> MassageList =[];
            for(int i=0; i < snapshot.data!.docs.length ;i++){
              MassageList.add(MassagesModel.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar:AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/scholar.png',
                      height: 60,
                      width: 70,
                    ),
                    Text('Chat',style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: 'pacifico'),),
                  ],
                ),
              ),
              backgroundColor: Colors.white,
              body:
              Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: MassageList.length,
                      itemBuilder: (context,index){
                        return MassageList[index].id == email ? ChatBubble(message: MassageList[index])
                            : ChatBubbleForFriend(message: MassageList[index]);
                      },

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data){
                        massages.add({
                          'massages': data,
                          'createdAt': DateTime.now(),
                          'id' : email,

                        });
                        controller.clear();
                        _scrollDown();
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: (){
                            controller.text;
                            final data = controller.text;
                            if (data.trim().isNotEmpty) {
                              massages.add({
                                'massages': data,
                                'createdAt': DateTime.now(),
                                'id': email,
                              });
                              controller.clear();
                              _scrollDown();
                            }
                          },
                         icon: Icon( Icons.send,color: kPrimaryColor,)),
                        hintText: 'Send Massage',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),

                      ),
                    ),
                  ),

                ],
              ),
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
