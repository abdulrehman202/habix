import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:habix/utilities/extensions.dart';

class SelectableBox extends StatefulWidget {
  VoidCallback onOptionSelected;
  Widget option;
  Color selectedColor;
  Color unSelectedColor;
  bool isSelected;
  bool filledBox;

  SelectableBox({
    super.key,
    required this.onOptionSelected,
    required this.option,
    required this.selectedColor,
    this.unSelectedColor = Colors.grey,
    required this.isSelected,
    this.filledBox = false,
  });

  @override
  State<SelectableBox> createState() => _SelectableBoxState();
}

class _SelectableBoxState extends State<SelectableBox> {
  late BoxDecoration selectedBoxDecoration = BoxDecoration(
    border: Border.all(width: 2, color: widget.selectedColor),
    borderRadius: BorderRadius.circular(10),
    shape: BoxShape.rectangle,
    color: widget.selectedColor.withValues(alpha: 0.2),
  );

  late BoxDecoration unSelectedBoxDecoration = BoxDecoration(
    border: Border.all(width: widget.filledBox?0: 1, color: widget.unSelectedColor),
    borderRadius: BorderRadius.circular(10),
    shape: BoxShape.rectangle,
    color: widget.filledBox?widget.selectedColor.withValues(alpha: 0.2):Colors.transparent
  );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
        widget.onOptionSelected();
        setState(() {
        });
        },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        // margin: EdgeInsets.only(right: i.index == 2 ? 0 : 5),
        decoration: widget.isSelected
            ? selectedBoxDecoration
            : unSelectedBoxDecoration,
        child: widget.option
      ),
    );
  }
}
