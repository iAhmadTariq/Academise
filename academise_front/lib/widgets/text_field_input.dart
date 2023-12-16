import 'package:academise_front/utils/color.dart';
import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final bool isPass;
  final String hintText;
  final TextEditingController textEditingController;
  final TextInputType textInputType;

  const TextFieldInput({
    super.key,
    required this.hintText,
    this.isPass = false,
    required this.textEditingController,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
      borderRadius:const BorderRadius.all(Radius.circular(25)),
    );
    return TextField(
      cursorColor: purpleColor,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12
        ),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
