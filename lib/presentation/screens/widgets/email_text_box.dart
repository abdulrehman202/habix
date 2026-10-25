import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:habix/utilities/extensions.dart';

class EmailTextField extends StatefulWidget {
  TextEditingController controller;
  EmailTextField({super.key, required this.controller,});
  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  @override
  void dispose() {
    // TODO: implement dispose
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (newVal)
      {
        if(newVal[newVal.length-1]==' ')
        {
          widget.controller.text = newVal.trim();
        }
        
      },
      selectAllOnFocus: false,
      validator: (emailValue) {
        if (emailValue!.trim().isEmpty) {
          return 'Email field cannot be empty';
        } else if (!emailValue.isValidEmail()) {
          return 'Incorrect Email Format';
        }
        return null;
      },
      controller: widget.controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        label: Text('Email'),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
