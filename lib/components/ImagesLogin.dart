import 'package:flutter/material.dart';

class ImagesLogin extends StatelessWidget {

  final String imagePath;

  const ImagesLogin({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xff59be32)),
          borderRadius: BorderRadius.circular(16),
          color: Colors.white),
      child: Image.asset(
        imagePath,
        height: 60,
      ),

    );
  }
}