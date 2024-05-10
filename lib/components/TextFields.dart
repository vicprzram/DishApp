import 'package:flutter/material.dart';

class TextFieldPassword extends StatefulWidget {
  final controller;
  final String hintText;

  const TextFieldPassword({Key? key, required this.controller, required this.hintText}) : super(key: key);
  @override
  State<TextFieldPassword> createState() => _TextFieldPasswordState(controller: this.controller, hintText: this.hintText);
}

class _TextFieldPasswordState extends State<TextFieldPassword> {

  final controller;
  final String hintText;
  bool obscureText = true;

  _TextFieldPasswordState({
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              obscureText
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: Colors.grey[600],
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff59be32)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff59be32)),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }

}

class TextFieldUsername extends StatelessWidget {
  final controller;
  final String hintText;

  const TextFieldUsername({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: false,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff59be32)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff59be32)),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}


class TextFieldRecipe extends StatelessWidget {

  final controller;
  final String hintText;
  final alignment;
  final int maxLines;

  const TextFieldRecipe({
    super.key,
    required this.controller,
    required this.hintText,
    required this.alignment,
    required this.maxLines
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: TextField(
          controller: controller,
          textAlign: alignment,
          maxLines: maxLines,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Color(0xff59be32)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500], ),
          ),
        ));
  }

}
