import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {

  final Function()? onTap;
  final String buttonText;

  const ButtonLogin({super.key, required this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
            color: Color(0xff59be32),
            borderRadius: BorderRadius.circular(8)),
        child: Center(child: Text(
            this.buttonText,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
            )
          )
        ),
      ),
    );
  }
}