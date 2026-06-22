import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
TextEditingController controller;
  String hint;
  PasswordTextField({super.key,required this.controller,this.hint = 'Password'});
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
    return TextField(
      controller: widget.controller,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: hidePass,
                  
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