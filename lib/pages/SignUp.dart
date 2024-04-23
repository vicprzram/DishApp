import 'package:dishapp/components/ButtonLogin.dart';
import 'package:dishapp/components/TextFieldLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class SignUp extends StatefulWidget {

  const SignUp({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpState();

}

class _SignUpState extends State<SignUp> {

  // Controllers
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordRepeatController = TextEditingController();

  void changeLogin(context){
      Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfffeeddd),
      body: SafeArea(
        child: Column(children: [

          // Lock
          Container(
            alignment: Alignment.center,
            child: Image.asset("lib/images/fruit_box.png", height: 250, width: 250)
          ),


          // Welcome
          Container(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                // Here is the explicit parent TextStyle
                style: new TextStyle(
                  fontSize: 31.0,
                  color: Colors.black,
                  fontFamily: 'Ginger_Cat',
                ),
                children: <TextSpan>[
                  new TextSpan(text: 'Register', style: new TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),

          SizedBox(height: 10),

          TextFieldUsername(controller: emailController, hintText: "Email"),

          SizedBox(height: 5),

          TextFieldUsername(controller: usernameController, hintText: "Username"),

          SizedBox(height: 5),

          TextFieldPassword(controller: passwordController, hintText: "Password"),

          SizedBox(height: 5),

          TextFieldPassword(controller: passwordRepeatController, hintText: "Repeat password"),

          SizedBox(height: 35),

          ButtonLogin(onTap: () {Navigator.pop(context);}, buttonText: "Sign up"),

          SizedBox(height: 40),

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
                            text: 'Already created?   ',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                changeLogin(context);
                              }),
                        new TextSpan(
                            text: 'Log in',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                changeLogin(context);
                              },
                            style: new TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                      ],
                    ),
                    )
                  ]
              )
          ),

          /*Container(
            alignment: Alignment.bottomLeft,
            child: Image.asset("lib/images/fruit_box.png")
          )*/
        ],),
      ),
    );
  }

}