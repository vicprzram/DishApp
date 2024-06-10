import 'package:dishapp/components/TextFields.dart';
import 'package:dishapp/pages/SignUpFlow.dart';
import 'package:flutter/gestures.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import '../components/ImagesLogin.dart';
import 'package:dishapp/database/Authentication.dart';
import 'MainMenu.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginModel extends FlutterFlowModel<LoginWidget> {

  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? usernameController;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? passwordController;
  String? Function(BuildContext, String?)? textController2Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode1?.dispose();
    usernameController?.dispose();

    textFieldFocusNode2?.dispose();
    passwordController?.dispose();
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late LoginModel _model;
  bool obscureText = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginModel());

    _model.usernameController ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.passwordController ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void SignUserIn(context) async {
    final message = await Authentication().login(
        emailOrPassword: _model.usernameController.text,
        password: _model.passwordController.text);
    if(message!.contains('Success')){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
    }
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message))
    );  }


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        backgroundColor: Color(0xFFFEEDDD),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Container(
                  height: 170,
                  decoration: BoxDecoration(),
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'lib/images/main_logo.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(),
                child: RichText(
                  textScaler: MediaQuery.of(context).textScaler,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'DishApp',
                        style: TextStyle(
                          fontSize: 45,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Ginger_Cat',
                      letterSpacing: 0,
                      fontWeight: FontWeight.w100,
                      useGoogleFonts: false,
                    ),
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                child: MainTextField(
                  controller: _model.usernameController,
                  focus: _model.textFieldFocusNode1,
                  label: 'Username or Email',
                  isPassword: false,
                  validator: _model.textController1Validator,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                ),
              ),

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                child:  MainTextField(
                  controller: _model.passwordController,
                  focus: _model.textFieldFocusNode2,
                  label: 'Password',
                  isPassword: true,
                  validator: _model.textController2Validator,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                ),
              ),

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
                child: FFButtonWidget(
                  onPressed: () {
                    this.SignUserIn(context);
                  },
                  text: 'Login',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 50,
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: Color(0xff59be32),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      letterSpacing: 0,
                    ),
                    elevation: 3,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

                Expanded(child: Align(alignment: Alignment.bottomCenter,
                child: Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20), child: RichText(text: TextSpan(
                  style: FlutterFlowTheme.of(context).labelLarge.override(
                    fontFamily: 'Outfit',
                    letterSpacing: 0,
                    fontSize: 15.0,
                    color: Colors.black
                  ),

                  children: <TextSpan>[
                    new TextSpan(
                        text: 'Not a member?   ',

                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpWidget()));
                          }),

                    new TextSpan(
                        text: 'Register now',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpWidget()));
                          },
                        style: new TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                  ],
                ),
                )
              ))),
            ],
          ),
        ),
      ),
    );
  }
}
