import 'package:farm/widget/varaible.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    Key? key,
    this.controller,
    this.hintText,
    this.isNumberKeyBoard,
    this.onChanged,
    this.validator,
    this.padding,
    this.icon,
  }) : super(key: key);
  //
  final TextEditingController? controller;
  final String? hintText;
  final bool? isNumberKeyBoard;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? padding;
  final IconData? icon;
  //
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: padding,
        child: TextFormField(
          controller: controller,
          keyboardType: isNumberKeyBoard == true ? TextInputType.number : null,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: hintText ?? '',
              suffixIcon: Icon(icon, color: green, size: 20)),
        ),
      ),
    );
  }
}
