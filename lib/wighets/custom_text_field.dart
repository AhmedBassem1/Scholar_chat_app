import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField({super.key, required this.hintText, this.onChange});
final String hintText;
Function(String)? onChange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data){
        if(data!.isEmpty){
          return 'field is required';
        }
        return null;
      },
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: hintText ,
        hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,),

          ),
          enabledBorder:OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,),
      ),
     )
    );
  }
}
