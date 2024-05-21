import 'package:dishapp/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class MainTextField extends StatefulWidget{

  final TextEditingController? controller;
  final FocusNode? focus;
  final String? Function(BuildContext, String?)? validator;
  final String label;
  final bool isPassword;
  final textAlign;
  final int maxLines;
  TextInputType textInputType;

  MainTextField({
    required this.controller,
    required this.focus,
    required this.validator,
    required this.label,
    required this.isPassword,
    required this.textAlign,
    required this.maxLines,
    this.textInputType = TextInputType.text
  });

  @override
  State<StatefulWidget> createState() => MainTextFieldState(
    controller: controller,
    validator: validator,
    label: label,
    focus: focus,
    isPassword: isPassword,
    textAlign: textAlign,
    maxLines: maxLines,
    textInputType: textInputType
  );

}

class MainTextFieldState extends State<MainTextField> {

  final TextEditingController? controller;
  final FocusNode? focus;
  final String? Function(BuildContext, String?)? validator;
  final String label;
  final bool isPassword;
  final textAlign;
  final int maxLines;
  final TextInputType textInputType;

  MainTextFieldState({
    required this.controller,
    required this.focus,
    required this.validator,
    required this.label,
    required this.isPassword,
    required this.textAlign,
    required this.maxLines,
    required this.textInputType
  });

  late bool obscureText = isPassword;

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: this.controller,
      focusNode: this.focus,
      autofocus: false,
      obscureText: obscureText,
      textAlign: textAlign,
      maxLines: maxLines,
      keyboardType: this.textInputType,
      decoration: InputDecoration(
        labelText: this.label,
        labelStyle:
        FlutterFlowTheme.of(context).labelLarge.override(
          fontFamily: 'Outfit',
          color: FlutterFlowTheme.of(context).primaryText,
          letterSpacing: 0,
        ),
        hintStyle:
        FlutterFlowTheme.of(context).labelLarge.override(
          fontFamily: 'Outfit',
          letterSpacing: 0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff59be32),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF59BE32),
            width: 4,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).error,
            width: 4,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).error,
            width: 4,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,

        suffixIcon: (isPassword == false) ? null :
        IconButton(
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
              if(obscureText == true){
                obscureText = false;
              }else{
                obscureText = true;
              }
            });
          },
        ),
      ),
      style: FlutterFlowTheme.of(context).bodyLarge.override(
        fontFamily: 'Outfit',
        letterSpacing: 0,
      ),
      validator:
      validator.asValidator(context),
    );
  }
}

