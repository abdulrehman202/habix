import 'package:flutter/material.dart';

class NameTextField extends StatefulWidget {
  TextEditingController controller;
  String labelText;
  NameTextField({super.key, required this.controller, required this.labelText});
  @override
  State<NameTextField> createState() => _NameTextFieldState();
}

class _NameTextFieldState extends State<NameTextField> {
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
      validator: (name) {
        if (name!.trim().isEmpty) {
          return 'Field cannot be empty';
        } 
        return null;
      },
      controller: widget.controller,
      keyboardType: TextInputType.name
      
      ,
      decoration: InputDecoration(
        label: Text(widget.labelText),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
