import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
TextEditingController controller;
  String hint;
  
  PasswordTextField({super.key,required this.controller,this.hint = 'Password',});
  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();

  
}

class _PasswordTextFieldState extends State<PasswordTextField> {

  bool hidePass = true;
  
  @override
  void dispose() {
    // TODO: implement dispose
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: hidePass,
                  onChanged: (newVal)
      {
        if(newVal[newVal.length-1]==' ')
        {
          widget.controller.text = newVal.trim();
        }
        
      },
      selectAllOnFocus: false,
                  validator: (val){
                    if(val!.trim().isEmpty)
                    {
                      return 'Field cannot be empty';
                    }

                    else if(val.trim().length<6)
                    {
                      return 'Password must be atleast 6 characters long';
                    }

                    return null;
                  },
                  
                  maxLines: 1,
                  decoration: InputDecoration(
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      hidePass = !hidePass;
                    });
                  }, icon: Icon( hidePass? Icons.remove_red_eye_outlined :Icons.close )),  
                    label: Text(widget.hint),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
  }
  
}