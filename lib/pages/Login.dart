import 'package:dishapp/components/ButtonLogin.dart';
import 'package:dishapp/components/ImagesLogin.dart';
import 'package:dishapp/components/TextFields.dart';
import 'package:dishapp/pages/MainMenu.dart';
import 'package:dishapp/pages/caca.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:dishapp/database/Authentication.dart';
import 'dart:math';
import 'SignUp.dart';
import 'package:dishapp/database/ForgotPassword.dart';

class Login extends StatelessWidget {
  Login({super.key});

  // Controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Sign in user
  void SignUserIn(context) async {
    final message = await Authentication().login(
        emailOrPassword: usernameController.text,
        password: passwordController.text);
    if(message!.contains('Success')){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
    }
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message))
    );  }

  void changeRegister(context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  @override
  Widget build(BuildContext context){

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfffeeddd),
      body: SafeArea(
        child: Column(
          children: [

            // Logo
            Container(
              alignment: Alignment.topCenter,
              child: Image.asset("lib/images/main_logo.jpg", height: screenHeight * 0.2, width: screenWidth)
            ),

            // Name of app
            Container(
              alignment: Alignment.center,
              child: RichText(
                  text: TextSpan(

                    // Here is the explicit parent TextStyle
                    style: new TextStyle(
                      fontSize: screenWidth * 0.13,
                      color: Colors.black,
                      fontFamily: 'Ginger_Cat',
                      decoration: TextDecoration.underline,
                    ),
                    children: <TextSpan>[
                      new TextSpan(text: 'DishApp', style: new TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
              )
            ),

            const SizedBox(height: 25),
            // Username


            const SizedBox(height: 10),

            // Password


            const SizedBox(height: 5),

            // Forgot password
            Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                RichText(text: TextSpan(
                    text: 'Forgot password?',
                    style: TextStyle(color: Colors.grey[700]),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        ForgotPasswordDialog();
                      }),
                  )
                ]
              )
            ),

            const SizedBox(height: 35),

            // Sing In
            ButtonLogin(
              onTap: () {SignUserIn(context);},
              buttonText: "Sign In",
            ),

            const SizedBox(height: 50),

            // Google + Apple
            Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Expanded(child: Divider(
                    thickness: 1,
                    color: Colors.grey[400],
                  ),),

                  Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text("Or continue with")),

                  Expanded(child: Divider(
                    thickness: 1,
                    color: Colors.grey[400],
                  ),),
                ],
              )
            ),

        const SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

              InkWell(
                child: ImagesLogin(imagePath: "lib/images/google_logo.png"),
                onTap: (){
                  print("Se ha clicado \"Google\"");
                },
              ),

              const SizedBox(width: 20,),

            InkWell(
              child: ImagesLogin(imagePath: "lib/images/apple_logo.png"),
              onTap: (){
                print("Se ha clicado \"Apple\"");
              },
            )
            ],),

            const SizedBox(width: 10,),

            // Not an account?
            Padding(padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(text: TextSpan(
                        style: new TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          new TextSpan(
                              text: 'Not a member?   ',
                              recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                changeRegister(context);
                              }),
                          new TextSpan(
                              text: 'Register now',
                              recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                changeRegister(context);
                              },
                              style: new TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                        ],
                      ),
                      )
                    ]
                )
            ),

          ],
        )
      ),
    );
  }
}