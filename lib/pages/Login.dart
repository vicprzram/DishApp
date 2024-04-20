import 'package:dishapp/components/ButtonLogin.dart';
import 'package:dishapp/components/ImagesLogin.dart';
import 'package:dishapp/components/TextFieldLogin.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  Login({super.key});

  // Controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Sign in user
  void SignUserIn() {
    print("Se ha pulsado \"Sign In\"");
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xfffeeddd),
      body: SafeArea(
        child: Column(
          children: [
            
            // Logo
            Container(
              alignment: Alignment.topCenter,
              child: Image.asset("lib/images/main_logo.jpg", height: 210, width: 210,)
            ),

            // Name of app
            Container(
              alignment: Alignment.center,
              child: RichText(
                  text: TextSpan(
                    // Here is the explicit parent TextStyle
                    style: new TextStyle(
                      fontSize: 50.0,
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
            TextFieldLogin(
              controller: usernameController,
              hintText: 'Username',
              obscureText: false,
            ),

            const SizedBox(height: 10),

            // Password
            TextFieldLogin(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),

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
                        print('Se ha clicado \"Forgot password?\"');
                      }),
                  )
                ]
              )
            ),

            const SizedBox(height: 35),

            // Sing In
            ButtonLogin(
              onTap: this.SignUserIn,
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
                                print("Se ha clicado \"Register now\"");
                              }),
                          new TextSpan(
                              text: 'Register now',
                              recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print("Se ha clicado \"Register now\"");
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