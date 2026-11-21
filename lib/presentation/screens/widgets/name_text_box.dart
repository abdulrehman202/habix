import 'package:material_ui/material_ui.dart';

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
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      selectAllOnFocus: false,
      validator: (name) {
        if (name!.trim().isEmpty) {
          return 'Field cannot be empty';
        } 
        return null;
      },
      controller: widget.controller,
      keyboardType: TextInputType.name,

textCapitalization: TextCapitalization.words     
      ,
      decoration: InputDecoration(
        label: Text(widget.labelText),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
